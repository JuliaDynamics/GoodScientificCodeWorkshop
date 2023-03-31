#=
This version shows the code that generalizable and is practically a simplification
of the code surrounding `monthlyagg` and co. in ClimateBase.jl.
=#
using Dates
using Statistics

monthlymeans(t, x) = monthlyagg(t, x; agg = mean)

function monthlyagg(t, x; agg = mean)
    return temporal_aggregation(t, x; agg, info = Dates.month)
end

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

middle_date(t0, t1) = ((d0, d1) = DateTime.((t0, t1)); d0 + (d1 - d0)/2)

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

# Testing vectors
t = Date(2015, 1, 1):Day(1):Date(2020, 12, 31)
x = float.(month.(t))
m, y = monthlymeans(t, x)

# Test with summer and winter
summer(x) = month(x) ∈ (3,4,5,6,7,8)
m, y = temporal_aggregation(t, x; info = summer)
