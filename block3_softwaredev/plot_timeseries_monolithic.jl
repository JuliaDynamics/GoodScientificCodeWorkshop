# Plot timesries
url = raw"https://raw.githubusercontent.com/JuliaDynamics/NonlinearDynamicsTextbook/master/exercise_data/11.csv"
w = 12

using DelimitedFiles
using Downloads
response = Downloads.request(url)
@assert response.status == 200 "URL doesn't exist!"
Downloads.download(url, "temp")
X = try
    readdlm("temp")
catch err
    throw(ArgumentError("Downloaded file isn't tabular text format!"))
end
rm("temp")
timeseries = X[:,1], X[:,2]

moving_averaged = []
for x in timeseries
    n = length(x)
    m = zeros(length(x)-w)
    m[1] = sum(x[1:w])/w
    for i in 2:n-w
        m[i] = m[i-1] + (x[i+w] - x[i-1])/w
    end
    push!(moving_averaged, m)
end

using Statistics: mean, covm, varm
trends = []
nrmses = []
for y in timeseries
    x = 1:length(y)
    mx = mean(x)
    my = mean(y)
    b = covm(x, mx, y, my)/varm(x, mx)
    a = my - b*mx
    trend = @. a + b*x
    push!(trends, trend)
    my = my
    n = length(y)
    mse = sum(abs2(trend[i] - y[i]) for i in 1:n) / n
    msemean = sum(abs2(y[i] - my) for i in 1:n) / n
    nrmse = sqrt(mse/msemean)
    push!(nrmses, nrmse)
end

fig = figure()
ax = subplot(2, 1, 1)
x = timeseries[1]
t = 1:length(timeseries[1])
plot(t, timeseries[1]; linewidth = 1)
plot(t[1:end-w], moving_averaged[1]; linewidth = 2)
plot(t, trends[1]; linewidth = 2, linestyle = ":", label = "nrmse=$(nrmses[1])")
ylabel("quantity 1")
legend()
ax = subplot(2, 1, 2)
x = timeseries[2]
t = 1:length(timeseries[2])
plot(t, timeseries[2]; linewidth = 1)
plot(t[1:end-w], moving_averaged[2]; linewidth = 2)
plot(t, trends[2]; linewidth = 2, linestyle = ":", label = "nrmse=$(nrmses[2])")
ylabel("quantity 2")
legend()
