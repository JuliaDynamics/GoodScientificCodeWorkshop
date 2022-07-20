from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import requests


def download_data(url):
    response = requests.get(url)

    temp = Path("temp")
    temp.write_bytes(response.content)
    timeseries = np.genfromtxt("temp")
    temp.unlink()

    return timeseries


def moving_average(t, x, w=12):
    n = len(x)
    m = np.zeros(len(x) - w)
    m[0] = sum(x[:w]) / w
    for i in range(1, n - w):
        m[i] = m[i - 1] + (x[i + w] - x[i - 1]) / w

    return t[:-w], m


def determine_trend(y):
    x = np.arange(y.size) + 1
    mx = np.mean(x)
    my = np.mean(y)
    b = np.cov(y, x, bias=y.mean())[0, 1] / np.var(x)
    a = my - b * mx
    trend = a + b * x

    return trend


def nrmse(y, z):
    n = np.size(y)
    mse = np.sum(np.abs(y - z)) / n
    msemean = np.sum(np.abs(y - np.mean(y))) / n
    print(mse, msemean)

    return np.sqrt(mse / msemean)


def plot_timeseries(x, ax=None):
    if ax is None:
        ax = plt.gca()

    t = np.arange(x.size)
    ax.plot(t, x, linewidth=1)

    ax.plot(*moving_average(t, x), linewidth=2)

    trend = determine_trend(x)
    rmse = nrmse(x, trend)
    ax.plot(t, trend, linewidth=2, linestyle=":", label=f"nrmse={rmse:.3f}")
    ax.legend()


def main():
    url = "https://raw.githubusercontent.com/JuliaDynamics/NonlinearDynamicsTextbook/master/exercise_data/11.csv"
    timeseries = download_data(url)

    fig, axes = plt.subplots(nrows=2)
    for ts, ax in zip(timeseries.T, axes.flatten()):
        plot_timeseries(ts, ax=ax)
    plt.show()


if __name__ == "__main__":
    main()
