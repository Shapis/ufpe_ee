import numpy as np
from rtlsdr import RtlSdr
import matplotlib.pyplot as plt

# Read in signal
# x = np.fromfile("/home/hpsilva/Downloads/fm_rds_250k_1Msamples.iq", dtype=np.complex64)
sample_rate = 250e3
center_freq = 99.1e6

sdr = RtlSdr()

sdr.center_freq = center_freq  # Hz

sdr.gain = "auto"  # set gain to automatic

# ...
sdr.sample_rate = sample_rate  # Hz
# ...

fft_size = 512
num_rows = 5000
x = sdr.read_samples(2048)  # get rid of initial empty samples
x = sdr.read_samples(
    fft_size * num_rows
)  # get all the samples we need for the spectrogram

print(x[0], len(x))
