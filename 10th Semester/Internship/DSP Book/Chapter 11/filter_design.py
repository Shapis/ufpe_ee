from matplotlib import pyplot as plt
from scipy.signal import firwin

sample_rate = 1e6
h = firwin(101, [100e3, 200e3], pass_zero=False, fs=sample_rate)
print(h)

from scipy.signal import firwin2

sample_rate = 1e6
freqs = [0, 100e3, 110e3, 190e3, 200e3, 300e3, 310e3, 500e3]
gains = [1, 1, 0, 0, 0.5, 0.5, 0, 0]
h2 = firwin2(101, freqs, gains, fs=sample_rate)
print(h2)

import numpy as np
from scipy.signal import firwin2, convolve, fftconvolve, lfilter

# Create a test signal, we'll use Gaussian noise
sample_rate = 1e6  # Hz
N = 1000  # samples to simulate
x = np.random.randn(N) + 1j * np.random.randn(N)

# Create an FIR filter, same one as 2nd example above
freqs = [0, 100e3, 110e3, 190e3, 200e3, 300e3, 310e3, 500e3]
gains = [1, 1, 0, 0, 0.5, 0.5, 0, 0]
h2 = firwin2(101, freqs, gains, fs=sample_rate)

# Apply filter using the four different methods
x_numpy = np.convolve(h2, x)
x_scipy = convolve(h2, x)  # scipys convolve
x_fft_convolve = fftconvolve(h2, x)
x_lfilter = lfilter(h2, 1, x)  # 2nd arg is always 1 for FIR filters

# Prove they are all giving the same output
print(x_numpy[0:2])
print(x_scipy[0:2])
print(x_fft_convolve[0:2])
print(x_lfilter[0:2])

# Simulate signal comprising of Gaussian noise
N = 100000  # signal length
x = np.random.randn(N) + 1j * np.random.randn(N)  # complex signal

# Save PSD of the input signal
PSD_input = 10 * np.log10(np.fft.fftshift(np.abs(np.fft.fft(x)) ** 2) / len(x))

# Apply filter
x = fftconvolve(x, h2, "same")

# Look at PSD of the output signal
PSD_output = 10 * np.log10(np.fft.fftshift(np.abs(np.fft.fft(x)) ** 2) / len(x))
f = np.linspace(-sample_rate / 2 / 1e6, sample_rate / 2 / 1e6, len(PSD_output))
plt.plot(f, PSD_input, alpha=0.8)
plt.plot(f, PSD_output, alpha=0.8)
plt.xlabel("Frequency [MHz]")
plt.ylabel("PSD [dB]")
plt.axis([sample_rate / -2 / 1e6, sample_rate / 2 / 1e6, -40, 20])
plt.legend(["Input", "Output"], loc=1)
plt.grid()
# plt.savefig("../_images/fftconvolve.svg", bbox_inches="tight")
plt.show()
