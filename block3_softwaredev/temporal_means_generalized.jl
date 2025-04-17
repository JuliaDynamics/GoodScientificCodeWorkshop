#=
This version shows the code that generalizable and is practically a simplification
of the code surrounding `monthlyagg` and co. in ClimateBase.jl.
=#
using Dates
using Statistics

# This is the "main" function of the codebase:
# it performs a temporal aggregation over provided "window"
# using provided aggregator. The "window" function can actually be anything
# that takes in a date and returns a value: consecutive entries with the same
# value belong to the same temporal window.
# The function then returns the coarse (middle point)
# time vector of the windows and the corresponding aggregated timeseries
function temporal_aggregation(t::AbstractVector{<:TimeType}, x::AbstractVector;
        aggregator = mean, window = Dates.month
    )
    tranges = temporal_ranges(t, window)
    y = [aggregator(view(x, r)) for r in tranges]
    coarse_t = [middle_date(t[r[1]], t[r[end]]) for r in tranges]
    return coarse_t, y
end

# splits the dates into ranges, each range corresponding to the requested window
function temporal_ranges(t::AbstractArray{<:TimeType}, window = Dates.month)
    issorted(t) || error("Sorted time vector required.") # checker step!
    L = length(t)
    ranges = Vector{UnitRange{Int}}() # initialize an empty vector
    i, previous = 1, window(t[1])
    for j in 2:L
        current = window(t[j])
        previous == current && continue
        push!(ranges, i:(j-1))
        i, previous = j, current
    end
    push!(ranges, i:L) # final range not included in for loop
    return ranges
end

# function for creating a new time vector for the aggregated timeseries
middle_date(t0, t1) = DateTime(t0) + (DateTime(t1) - DateTime(t2))/2

# the previous month mean functionality can still exist as a convenience function:
monthlymeans(t, x) = temporal_aggregation(t, x; aggregator = mean, window = Dates.month)

# Test from monthly means exercise
t = Date(2015, 1, 1):Day(1):Date(2020, 12, 31)
x = float.(month.(t))
m, y = monthlymeans(t, x)

# So how do we do it with summer and winter? Easy; just make a window function
# that assigns the same value to all summer months, and another value to all winter months!
summer(x) = month(x) ∈ (3,4,5,6,7,8)
m, y = temporal_aggregation(t, x; window = summer)
