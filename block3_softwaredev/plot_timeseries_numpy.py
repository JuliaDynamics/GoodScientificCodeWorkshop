import matplotlib.pyplot as plt
import numpy as np
import requests
from io import StringIO

url = "https://raw.githubusercontent.com/JuliaDynamics/NonlinearDynamicsTextbook/master/exercise_data/11.csv"
w = 12

response = requests.get(url)
timeseries = np.genfromtxt(StringIO(response.text))

fig, axes = plt.subplots(nrows=2)
for ts, ax in zip(timeseries.T, axes):
    x = np.arange(ts.shape[0])
    moving_average = np.convolve(ts, np.ones(w) / w, mode="same")
    popt = np.polyfit(x, ts, deg=1)
    rmse = np.sqrt(np.mean((np.polyval(popt, x) - ts) ** 2))

    ax.plot(x, ts)
    ax.plot(x, moving_average)
    ax.plot(x, np.polyval(popt, x), ls=":", label=f"nrmse={rmse:.3f}")
    ax.legend()
plt.show()
