import matplotlib as mpl
import matplotlib.pyplot as plt
import librosa
import numpy as np
from scipy.fftpack import fft, ifft
import soundfile as sf
from scipy.signal import butter, lfilter, spectrogram

mpl.use("GTK3Agg")

y, fs = librosa.load("/home/hpsilva/Music/RingOfFire.wav")


# Frequência de corte
fc = round(5000 * 3.6 * 6.28)


def gerar_filtro_passa_alta(tamanho_fft, frequencia_corte):
    coeficientes = np.zeros(tamanho_fft)
    coeficientes[frequencia_corte:] = 1
    return coeficientes


tamanho_fft = len(y)
fpa = gerar_filtro_passa_alta(tamanho_fft, fc)

Y = fft(y)

Y = Y * fpa * fpa[::-1]

y_filtered = ifft(Y).real

# y_filtered = 2.0 / len(y) * np.abs(ifft(Y)[: len(y) // 2])

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


# Plot spectrogram of original and filtered signals


plt.figure(figsize=(12, 6))

frequencies, times, Sxx_original = spectrogram(y, fs)
plt.subplot(2, 1, 1)
plt.pcolormesh(times, frequencies, 10 * np.log10(Sxx_original))
plt.title("Spectrogram - Original Signal")
plt.ylabel("Frequency (Hz)")

frequencies, times, Sxx_filtered = spectrogram(y_filtered, fs)
plt.subplot(2, 1, 2)
plt.pcolormesh(times, frequencies, 10 * np.log10(Sxx_filtered))
plt.title("Spectrogram - Filtered Signal")
plt.xlabel("Time (s)")
plt.ylabel("Frequency (Hz)")

plt.tight_layout()
plt.show()

print(y)
print(abs(y_filtered))


sf.write("original.wav", y, fs)
sf.write("filtered.wav", y_filtered.real * 15, fs)
sf.write("transformado.wav", Y.real, fs)
