import numpy as np
import matplotlib.pyplot as plt

H = np.hstack((np.zeros(20), np.arange(10) / 10, np.zeros(20)))
w = np.linspace(-0.5, 0.5, 50)
plt.plot(w, H, ".-")
plt.show()

h = np.fft.ifftshift(np.fft.ifft(np.fft.ifftshift(H)))

# After creating h using the previous code, create and apply the window
window = np.hamming(len(h))
h = h * window

# Option 2: We re-generate our impulse response using more points so that it has time to decay. We need to add resolution to our original frequency domain array (called interpolating).

# H = np.hstack((np.zeros(200), np.arange(100)/100, np.zeros(200)))
# w = np.linspace(-0.5, 0.5, 500)
# plt.plot(w, H, '.-')
# plt.show()
# # (the rest of the code is the same)


plt.plot(np.real(h))
plt.plot(np.imag(h))
plt.legend(["real", "imag"], loc=1)
plt.show()

H_fft = np.fft.fftshift(np.abs(np.fft.fft(h, 1024)))
plt.plot(H_fft)
plt.show()
