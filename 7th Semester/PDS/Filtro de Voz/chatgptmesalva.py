import matplotlib as mpl
import matplotlib.pyplot as plt
import librosa
import numpy as np
from scipy.fftpack import fft, ifft
from scipy.signal import butter, lfilter, spectrogram, firwin, freqz
import soundfile as sf

mpl.use("GTK3Agg")

# Load audio file
y, fs = librosa.load("/home/hpsilva/Music/RingOfFire.wav")


# Define high-pass filter parameters
fc = 4000  # Cut-off frequency in Hz
order = 30  # Filter order

# Design high-pass filter
b, a = butter(order, fc / (fs / 2), btype="high")

filter_coefficients = firwin(5, 1, fs=fc, pass_zero=True)

frequencies2, response2 = freqz(filter_coefficients, 1)


def gerar_filtro_passa_alta(tamanho_fft, frequencia_corte):
    coeficientes = np.zeros(tamanho_fft)
    coeficientes[frequencia_corte:] = 1
    return coeficientes


tamanho_fft = len(y)
fpa = gerar_filtro_passa_alta(tamanho_fft, fc)

Y = np.fft.fft(y)
Y_filtered = Y * fpa * fpa[::-1]
# y_filtered = np.fft.ifft(Y_filtered, None)

# Apply high-pass filter to the signal
y_filtered = lfilter(b, a, y)

# Plot original and filtered signals
plt.figure(figsize=(10, 6))

plt.subplot(2, 1, 1)
plt.plot(y)
plt.title("Original Signal")

plt.subplot(2, 1, 2)
plt.plot(y_filtered)
plt.title("Filtered Signal")

plt.tight_layout()
plt.show()

# Save the filtered audio
sf.write("original.wav", y, fs)
sf.write("filtered.wav", y_filtered * 10, fs)

# Plot spectrogram of original and filtered signals
frequencies, times, Sxx_original = spectrogram(y, fs)
frequencies, times, Sxx_filtered = spectrogram(y_filtered, fs)
print("asda")
plt.figure(figsize=(12, 6))

print("a")
print(len(10 * np.log10(Sxx_original)))
print(len(times))
print(len(frequencies))
print("b")
plt.subplot(2, 1, 1)
plt.pcolormesh(times, frequencies, 10 * np.log10(Sxx_original))
plt.title("Spectrogram - Original Signal")
plt.ylabel("Frequency (Hz)")

print("a")
print(len(10 * np.log10(Sxx_filtered)))
print("b")
plt.subplot(2, 1, 2)
plt.pcolormesh(times, frequencies, 10 * np.log10(Sxx_filtered))
plt.title("Spectrogram - Filtered Signal")
plt.xlabel("Time (s)")
plt.ylabel("Frequency (Hz)")

plt.tight_layout()
plt.show()
