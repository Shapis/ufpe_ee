import librosa
import numpy as np
from scipy.fftpack import fft, ifft


# # Replace 'path/to/your/song.wav' with the actual path to your song
y, sr = librosa.load("/home/hpsilva/Music/musica.mp3")
