from rtlsdr import RtlSdr
import numpy as np
import matplotlib.pyplot as plt

sdr = RtlSdr()

sdr.center_freq = 100e6  # Hz

sdr.gain = "auto"  # set gain to automatic

# ...
sdr.sample_rate = 2.4e6  # Hz
# ...

fft_size = 512
num_rows = 500
x = sdr.read_samples(2048)  # get rid of initial empty samples
x = sdr.read_samples(
    fft_size * num_rows
)  # get all the samples we need for the spectrogram
spectrogram = np.zeros((num_rows, fft_size))
for i in range(num_rows):
    spectrogram[i, :] = 10 * np.log10(
        np.abs(np.fft.fftshift(np.fft.fft(x[i * fft_size : (i + 1) * fft_size]))) ** 2
    )
extent = [
    (sdr.center_freq + sdr.sample_rate / -2) / 1e6,
    (sdr.center_freq + sdr.sample_rate / 2) / 1e6,
    len(x) / sdr.sample_rate,
    0,
]
sdr.close()
plt.imshow(spectrogram, aspect="auto", extent=extent)
plt.xlabel("Frequency [MHz]")
plt.ylabel("Time [s]")
plt.show()
