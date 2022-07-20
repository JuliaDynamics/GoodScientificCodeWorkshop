import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import xarray as xr


url = "https://raw.githubusercontent.com/JuliaDynamics/NonlinearDynamicsTextbook/master/exercise_data/11.csv"
w = 12

ds = pd.read_csv(url, delimiter="\t", names=["var1", "var2"]).to_xarray()

fig, axes = plt.subplots(nrows=2)
for var, ax in zip(ds, axes):
    ds[var].plot(ax=ax)
    ds[var].rolling(index=w).mean().plot(ax=ax)
    p = ds[var].polyfit(deg=1, dim="index")
    rmse = np.sqrt(
        np.mean((xr.polyval(ds.index, p.polyfit_coefficients) - ds[var]) ** 2)
    ).data
    xr.polyval(ds.index, p.polyfit_coefficients).plot(
        ls=":", label=f"nrmse={rmse:.3f}", ax=ax
    )
    ax.legend()
plt.show()
