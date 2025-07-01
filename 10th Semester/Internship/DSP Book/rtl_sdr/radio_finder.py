import numpy as np
import matplotlib.pyplot as plt
from rtlsdr import RtlSdr
import time

# Configure RTL-SDR
sdr = RtlSdr()
sdr.sample_rate = 2.4e6  # Hz
sdr.center_freq = 99.1e6  # Hz (change to a known station!)
sdr.gain = 47  # Try 20, 30, 40, etc.

# Spectrogram settings
fft_size = 512
num_rows = 100  # Visible history in time
spec = np.zeros((num_rows, fft_size))

# Setup plot
fig, ax = plt.subplots()
extent = [
    (sdr.center_freq - sdr.sample_rate / 2) / 1e6,
    (sdr.center_freq + sdr.sample_rate / 2) / 1e6,
    0,
    num_rows * fft_size / sdr.sample_rate,
]
img = ax.imshow(spec, aspect="auto", extent=extent, origin="lower", vmin=0, vmax=100)
ax.set_xlabel("Frequency [MHz]")
ax.set_ylabel("Time [s]")

# Live update loop
try:
    while True:
        samples = sdr.read_samples(fft_size)
        spectrum = 10 * np.log10(
            np.abs(np.fft.fftshift(np.fft.fft(samples))) ** 2 + 1e-12
        )

        # Scroll the spectrogram by one row
        spec = np.roll(spec, -1, axis=0)
        spec[-1, :] = spectrum

        # Update the image
        img.set_data(spec)
        fig.canvas.draw()
        fig.canvas.flush_events()
        plt.pause(0.01)  # Small pause to allow UI to update

except KeyboardInterrupt:
    print("Stopping...")

finally:
    sdr.close()
    plt.close()
