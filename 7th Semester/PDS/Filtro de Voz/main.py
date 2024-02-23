import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from scipy.fftpack import fft, ifft
import soundfile as sf
from scipy.signal import butter, lfilter, spectrogram, cheby1, cheby2


mpl.use("GTK3Agg")
y, fs = sf.read("/home/hpsilva/Music/Sobrepos.wav")
# y, fs = librosa.load("/home/hpsilva/Music/RingOfFire.wav")
# y, fs = librosa.load("/home/hpsilva/Music/low.wav")
# y, fs = librosa.load("/home/hpsilva/Music/EnjoyTheSilence.wav")
# y, fs = librosa.load("/home/hpsilva/Music/HouseOfTheRisingSun.wav")
# y, fs = librosa.load("/home/hpsilva/Music/jump.wav")

# left_channel = y[:, 0]
# right_channel = y[:, 1]

# y = (left_channel + right_channel) / 2

# Frequência de corte
fc = round(4000)

# Design high-pass filter
b, a = butter(25, fc / (fs / 2), btype="high")


# def gerar_filtro_passa_alta(tamanho_fft, frequencia_corte):
#     coeficientes = np.zeros(tamanho_fft)
#     coeficientes[frequencia_corte:] = 1
#     return coeficientes


# tamanho_fft = len(y)
# fpa = gerar_filtro_passa_alta(tamanho_fft, fc)

# Y = fft(y)

# Y = Y * fpa * fpa[::-1]

# y_filtered = ifft(Y).real

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

sf.write("output/original.wav", y, fs)
sf.write("output/filtered.wav", y_filtered.real, fs)
