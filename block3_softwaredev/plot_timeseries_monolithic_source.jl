using DelimitedFiles
using Downloads
function download_timeseries(url)
    response = Downloads.request(url)
    @assert response.status == 200 "URL doesn't exist!"
    Downloads.download(url, "temp")
    X = try
        readdlm("temp")
    catch err
        throw(ArgumentError("Downloaded file isn't tabular text format!"))
    end
    rm("temp")
    timeseries = eachcol(x)
end

function moving_average(x, w)
    n = length(x)
    m = zeros(length(x)-w)
    m[1] = sum(x[1:w])/w
    for i in 2:n-w
        m[i] = m[i-1] + (x[i+w] - x[i-1])/w
    end
    return m
end

using Statistics: mean, covm, varm
function fit_trend(y, x = 1:length(y))
    x = 1:length(y)
    mx = mean(x)
    my = mean(y)
    b = covm(x, mx, y, my)/varm(x, mx)
    a = my - b*mx
    trend = @. a + b*x
    return trend, nrmse(y, trend, my)
end

function nrmse(y, z, my = mean(y))
    n = length(y)
    mse = sum(abs2(z[i] - y[i]) for i in 1:n) / n
    msemean = sum(abs2(y[i] - my) for i in 1:n) / n
    nrmse = sqrt(mse/msemean)
end