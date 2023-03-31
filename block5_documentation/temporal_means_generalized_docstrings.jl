using Dates
using Statistics

"""
    monthlymeans(t, x) → w, y
Given a time vector `t` and `x` some values corresponding to it,
average `x` over months, and return `w`, the new monthly-spaced time vector
and `y` the monthly-averaged `x`.

See also [`monthlyagg`](@ref).
"""
monthlymeans(t, x) = monthlyagg(t, x; agg = mean)

"""
    monthlyagg(t, x; agg = mean) → w, y
Given a time vector `t` and `x` some values corresponding to it,
aggregate `x` over months. Return `w`, the new monthly-spaced time vector
corresponding to the aggregates, and `y` the aggregated value.

Aggregation is done via `agg` which maps a vector of values to a number.

See also [`temporal_aggregation`](@ref).
"""
function monthlyagg(t, x; agg = mean)
    return temporal_aggregation(t, x; agg, info = Dates.month)
end

"""
    temporal_aggregation(t::AbstractVector{<:TimeType}, x::Vector;
    agg = mean, info = Dates.month)
Calculate the temporally aggregated version of `x`, where it has been aggregated
over periods of time dictated by the `info` function and the time vector `t`.
Return `w, y` with `y` the aggregated values and `w` a new time vector
corresponding to `y`. `w` has the temporal mid point of each used intervals.

`info` decides the intervals used for aggregation. All sequential values
of `t` that have the same `info` value belong to the same interval.
For each interval `x` is aggregated using `agg`.
Typical values of `info` are `Dates.year, Dates.month, Dates.day`.
You could define `summer(t) = month(t) ∈ (3,4,5,6,7,8)` and use `info = summer`
to find the ranges that correspond to successive "summers" and "winters".

`agg` is the aggregating function, e.g., `mean, std`.

See also [`temporal_ranges`](@ref).
"""
function temporal_aggregation(t::AbstractVector{<:TimeType}, x::Vector;
        agg = mean, info = Dates.month
    )
    tranges = temporal_ranges(t, info)
    y = [agg(view(x, r)) for r in tranges]
    coarse_t = [middle_date(t[r[1]], t[r[end]]) for r in tranges]
    # TODO: We can have a `prettify_coarse_t` function to make
    # the time vector better in cases where it is possible,
    # e.g. like t[1]:Month(1):t[end]
    return coarse_t, y
end

"""
    middle_date(t0, t1) → tm
Given two dates `t0, t1`, return the date that is approximately their midpoint.
"""
middle_date(t0, t1) = ((d0, d1) = DateTime.((t0, t1)); d0 + (d1 - d0)/2)

"""
    temporal_ranges(t::AbstractVector{<:TimeType}}, info = Dates.month)
Return a vector of ranges so that each range of indices are consecutive values of `t` that
belong in either the same month, year, day, or other, depending on `info`.
See [`temporal_aggregation`](@ref) for more info on `info`.
"""
function temporal_ranges(t::AbstractArray{<:TimeType}, info = Dates.month)
    @assert issorted(t) "Sorted time required."
    L = length(t)
    r = Vector{UnitRange{Int}}()
    i, x = 1, info(t[1]) # previous entries
    for j in 2:L
        y = info(t[j])
        x == y && continue
        push!(r, i:(j-1))
        i, x = j, y
    end
    push!(r, i:L) # final range not included in for loop
    return r
end

