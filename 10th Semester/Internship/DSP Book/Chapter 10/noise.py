import numpy as np
import matplotlib.pyplot as plt

N = 1024  # number of samples to simulate, choose any number you want
x = np.random.randn(N)
plt.plot(x, ".-")
plt.show()

X = np.fft.fftshift(np.fft.fft(x))
X = X[
    N // 2 :
]  # only look at positive frequencies.  remember // is just an integer divide
plt.plot(np.real(X), ".-")
plt.show()
