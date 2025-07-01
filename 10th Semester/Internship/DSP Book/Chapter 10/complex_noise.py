import numpy as np
import matplotlib.pyplot as plt

N = 1024
n = (np.random.randn(N) + 1j * np.random.randn(N)) / np.sqrt(2)
plt.plot(np.real(n), ".-")
plt.plot(np.imag(n), ".-")
plt.legend(["real", "imag"])
plt.show()

plt.plot(np.real(n), np.imag(n), ".")
plt.grid(True, which="both")
plt.axis([-2, 2, -2, 2])
plt.show()
