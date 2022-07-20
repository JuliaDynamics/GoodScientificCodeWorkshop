# plot timeseries
# Here is a descritpion for the script.
include("plot_timeseries_source.jl")
url = raw"https://raw.githubusercontent.com/JuliaDynamics/NonlinearDynamicsTextbook/master/exercise_data/11.csv"
w = 12

timeseries = download_timeseries(url)
moving_averaged = moving_average.(timeseries, w)
trends = fit_trend.(timeseries)
nrmses = nrmse.(trends, timeseries)

fig = figure()
for i in 1:length(timeseries)
    ax = subplot(2, 1, i)
    x = timeseries[i]
    t = 1:length(timeseries[i])
    plot(t, timeseries[i]; linewidth = 1)
    plot(t[1:end-w], moving_averaged[i]; linewidth = 2)
    plot(t, trends[1]; linewidth = 2, linestyle = ":", label = "nrmse=$(nrmses[i])")
    ylabel("quantity $i")
    legend()
end
