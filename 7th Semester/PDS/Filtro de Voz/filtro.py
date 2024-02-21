import matplotlib as mpl
import matplotlib.pyplot as plt
import librosa
import numpy as np
from scipy.fftpack import fft, ifft
import soundfile as sf

mpl.use("GTK3Agg")
# print(plt.rcsetup.all_backends)


# # Replace 'path/to/your/song.wav' with the actual path to your song
# y, fs = librosa.load("/home/hpsilva/Music/PDS.mp3")
# y, fs = librosa.load("/home/hpsilva/Music/Paciencia.wav")
y, fs = librosa.load("/home/hpsilva/Music/RingOfFire.wav")


# Frequência de corte
fc = round(25000)  # Ajuste como desejar

# Atraso do filtro (opcional)
tau = 10  # Defina o atraso se necessário

# Escolha a janela desejada
tipoJanela = "retangular"


# Número de amostras do filtro (deve ser par)
N = 64  # Ajuste o tamanho do filtro se desejar


def janela(tipo, N):
    """
    Calcula os coeficientes de uma janela.

    Args:
        tipo: Tipo da janela ("retangular", "hamming", "hann", "blackman").
        N: Número de pontos da janela (deve ser par).

    Returns:
        w: Coeficientes da janela.
    """
    if tipo == "retangular":
        w = np.ones(N)
    elif tipo == "hamming":
        w = 0.54 - 0.46 * np.cos(2 * np.pi * np.arange(N) / (N - 1))
    elif tipo == "hann":
        w = 0.5 - 0.5 * np.cos(2 * np.pi * np.arange(N) / (N - 1))
    elif tipo == "blackman":
        w = (
            0.42
            - 0.5 * np.cos(2 * np.pi * np.arange(N) / (N - 1))
            + 0.08 * np.cos(4 * np.pi * np.arange(N) / (N - 1))
        )
    else:
        raise ValueError("Tipo de janela inválido.")
    return w


def gerar_filtro_passa_alta(tamanho_fft, frequencia_corte):
    """
    Cria um filtro passa-alta ideal no domínio da frequência.

    Argumentos:
      tamanho_fft: O tamanho da transformada de Fourier rápida (FFT).
      frequencia_corte: A frequência de corte do filtro (em Hz).

    Retorna:
      Um array NumPy com os coeficientes do filtro passa-alta.
    """
    coeficientes = np.zeros(tamanho_fft)
    coeficientes[frequencia_corte:] = 1
    return coeficientes


# Exemplo de uso
tamanho_fft = len(y)
fpa = gerar_filtro_passa_alta(tamanho_fft, fc)

plt.plot(fpa)
plt.show()


# Função para projetar o filtro com a janela escolhida
def projetar_filtro(tipo, N, fc, fs):
    w = janela(tipo, N)
    divisor = np.pi * np.arange(N) / fs
    divisor[0] = 1e-10  # Evita divisão por zero
    h = w * np.sin(2 * np.pi * fc * np.arange(N) / fs) / divisor
    h[N // 2] = fc
    return h


# Projete o filtro
h = projetar_filtro(tipoJanela, N, fc, fs)


Y = fft(y)

plt.plot(Y)
plt.show()

# Passa baixa
# Y_filtered1 = Y * filtro_passa_alta
# Y_filtered2 = Y * filtro_passa_alta[::-1]
# Y_filtered = Y_filtered1 + Y_filtered2


Y_filtered = Y * fpa

plt.plot(Y_filtered)
plt.show()

y_filtered = ifft(Y_filtered, None)


# # Aplique o filtro na representação em frequência
# Y_filtered = Y * h

# # Transforme o sinal filtrado de volta para o domínio do tempo
# y_filtered = ifft(Y_filtered)

# sf.write("stereo_file1.wav", Y, 48000, "PCM_24")


sf.write("original.wav", y, fs)
sf.write("filtered.wav", y_filtered.real, fs)
sf.write("transformado.wav", Y.real, fs)
# # Reproduza ou salve o áudio original e filtrado para comparação
# librosa.output.write_wav("original.wav", y, fs, norm=False)
# librosa.output.write_wav(
#     "filtered.wav", y_filtered.real, fs, norm=False
# )  # Use apenas valores reais

# # Avalie a qualidade do filtro ouvindo os arquivos ou visualizando suas espectrogramas
