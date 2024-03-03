import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from scipy.fftpack import fft, ifft
from scipy.signal import butter, lfilter, spectrogram, cheby1, cheby2
from LeitorEscritor import LeitorEscritor
from Filtro import Filtro, TipoDeFiltro, MetodoDeFiltro

mpl.use("GTK3Agg")

leitor = LeitorEscritor("Sobrepos.wav")

y, fs = leitor.sinal

fc = 5000

# filtro = Filtro(fs, len(y))

b, a = butter(25, fc / (fs / 2), btype="high")


def gerar_filtro_passa_alta(tamanho_fft, frequencia_corte):
    coeficientes = np.zeros(tamanho_fft)
    coeficientes[frequencia_corte:] = 1
    return coeficientes


tamanho_fft = len(y)
fpa = gerar_filtro_passa_alta(tamanho_fft, 47500)

Y = fft(y)

Y = Y * fpa * fpa[::-1]

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

leitor.write_signal("filtrado.wav", y_filtered, fs)
leitor.write_signal("original.wav", y, fs)
