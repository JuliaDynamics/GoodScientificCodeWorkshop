#=
This version shows the code that is not generalizable and could be
the typical way a scientist would write the solution to the exercise
=#
using Dates
using Statistics

function monthlymeans(t::AbstractVector{<:TimeType}, x::Vector; daynumber = 15)
    @assert issorted(t)
    @assert daynumber ≤ 28
    startdate = Date(year(t[1]), month(t[1]), daynumber)
    finaldate = Date(year(t[end]), month(t[end]), daynumber)
    m = startdate:Month(1):finaldate
    output = aggregate_same_months(t, x, m)
    return m, output
end

function aggregate_same_months(t, x, m)
    output = zeros(length(m)) # output, monthly means of `x`
    first_index_in_month = 1
    for j in 1:length(m)
        current_month = month(m[j])
        # Define search range so that we start search from current index
        search_range = first_index_in_month:length(t)
        k = findfirst(i -> month(t[i]) ≠ current_month, search_range)
        if isnothing(k) # we didn't find any index with different month
            last_index_in_month = length(t)
        else
            last_index_in_month = search_range[k - 1]
        end
        output[j] = mean(x[first_index_in_month:last_index_in_month])
        first_index_in_month = last_index_in_month + 1
    end
    return output
end

# Testing vectors
t = Date(2015, 1, 1):Day(1):Date(2020, 12, 31)
x = float.(month.(t))
m, output = monthlymeans(t, x)
