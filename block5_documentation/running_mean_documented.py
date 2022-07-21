import numpy as np
import matplotlib.pyplot as plt


def running_mean(x, win_size):
    """Compute a running mean with a given window size.

    Parameters:
        x (ndarray): Input data.
        win_size (int): Window size.

    Returns:
        ndarray: Smoothened data.
    """
    return np.convolve(x, np.ones(w) / w, mode="valid")


def running_mean(x, win_size, win_type=np.ones):
    """Compute a running mean with a given window size.

    Parameters:
        x (ndarray): Input data.
        win_size (int): Window size.
        win_type (callable): A callable object that when passed a `win_size`
            will return an array of weights.

    Returns:
        ndarray: Smoothened data.
    """
    w = win_type(win_size)
    return np.convolve(x, w / w.sum(), mode="valid")


def running_mean(x, win_size, win_type=np.ones, aggregation=None):
    """Compute a running mean with a given window size.

    Parameters:
        x (ndarray): Input data.
        win_size (int): Window size.
        win_type (callable): A callable object that when passed a `win_size`
            will return an array of weights.
        aggregartion (callable): A callable object which aggregrates the data
            within the window region. By default, the function computes a
            running mean.

    Note:
        In the default configuration, i.e. a running mean, the function makes
        use of a convolution which is implemented in a very efficient way.
        When passing the `aggregation` keyword this approach is no
        longer feasible because the data has to be explicitly "grouped".

    Returns:
        ndarray: Smoothened data.
    """
    w = win_type(win_size)

    if aggregation is None:
        # In the default case, we can use fast Fourier transform
        return np.convolve(x, w / w.sum(), mode="valid")
    else:
        # In the generic case, we have to group our array which is slower.
        # Therefore, it is good to have a separate API (i.e. keyword) for this case.
        return aggregation(
            np.lib.stride_tricks.sliding_window_view(x, win_size) * w,
            axis=1,
        ) / w.mean()


def main():
    windows = (
        np.ones,
        np.bartlett,
        np.blackman,
        np.hamming,
    )

    np.random.seed(1)
    x = np.random.randn(256) + 2

    fig, ax = plt.subplots(figsize=(10, 6))
    ax.plot(x, c="grey")
    for window in windows:
        ax.plot(
            running_mean(x, win_size=16, win_type=window),
            linewidth=2,
            label=window.__name__.capitalize(),
        )
    ax.legend()
    ax.set_ylim(np.percentile(x, [5, 95]))

    plt.show()


if __name__ == "__main__":
    main()
