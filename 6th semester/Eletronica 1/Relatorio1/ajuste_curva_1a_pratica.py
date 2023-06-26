import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


##
# 1ª parte do programa onde devem ser colocados os valores medidos.
# As variáveis com sufixo 1 referem-se aos valores medidos para o 1º
# circuito, e as terminando com 2, aos do 2º circuito.
##
# A variável freq é um array com as frequências em Hz do sinal
# senoidal de entrada. A variável vin contém os valores medidos da
# amplitude da entrada, e a vout, os valores da amplitude da saída.
##

fc1 = 210000
fc2 = 11800

# Medições do 1º circuito
freqs1 = np.array([0.002*fc1, 0.01*fc1, 0.05*fc1, 0.2*fc1, 0.5*fc1,
                   0.8*fc1, fc1, 2*fc1, 4*fc1, 10*fc1, 20*fc1, 40*fc1])
vin1 = np.array([0.2975, 0.297, 0.298, 0.297, 0.298,
                0.301, 0.297, 0.297, 0.3, 0.302, 0.301, 0.315])
vout1 = np.array([1.404, 1.405, 1.403, 1.393, 1.306, 1.124,
                 0.975, 0.54, 0.276, 0.114, 0.057, 0.031])

# Medições do 2º circuito
freqs2 = np.array([0.05*fc2, 0.1*fc2, 0.2*fc2, 0.5*fc2, 0.8*fc2, fc2,
                   2*fc2, 5*fc2, 20*fc2, 50*fc2, 200*fc2, 500*fc2, 1000*fc2])
vin2 = np.array([0.1191, 0.1199, 0.12, 0.121, 0.122, 0.122,
                0.1218, 0.123, 0.123, 0.121, 0.121, 0.125, 0.151])
vout2 = np.array([14.01, 13.95, 13.77, 12.61, 10.85, 9.8, 5.92,
                 2.548, 0.645, 0.258, 0.0652, 0.0205, 0.0122])

##
# NÃO É PRECISO MODIFICAR MAIS NADA A PARTIR DAQUI
##


def mag_sqr_fun(f, K, fc):
    return (K*fc)**2/(f**2 + fc**2)


def dB(m):
    return 20*np.log10(m)

# Cálculo para o 1º circuito


(K1, fc1), _ = curve_fit(lambda f, K, fc: dB(mag_sqr_fun(f, K, fc)),
                         freqs1, 2*dB(vout1/vin1))

print("Resultados para o 1º circuito:\n")
print(f"""O ganho K é {round(K1, 1)}
A frequência de corte é {round(fc1, 1)} Hz""")

f1 = np.logspace(np.log10(freqs1[0]) - 1, np.log10(freqs1[-1]) + 0.3)
mag1 = dB(mag_sqr_fun(f1, K1, fc1))/2

plt.semilogx(f1, mag1)
plt.semilogx(freqs1, dB(vout1/vin1), "*")
plt.xlabel("Freq (Hz)")
plt.ylabel("Mag(H) (dB)")
plt.title("Gráfico de Bode de magnitude para o 1º circuito")
plt.grid()
plt.savefig("figura1.png")
plt.show()

# Cálculo para o 2º circuito

(K2, fc2), _ = curve_fit(lambda f, K, fc: dB(mag_sqr_fun(f, K, fc)),
                         freqs2, 2*dB(vout2/vin2))

print("\n\nResultados para o 2º circuito:\n")
print(f"""O ganho K é {round(K2, 1)}
A frequência de corte é {round(fc2, 1)} Hz""")

f2 = np.logspace(np.log10(freqs2[0]) - 1, np.log10(freqs2[-1]) + 0.3)
mag2 = dB(mag_sqr_fun(f2, K2, fc2))/2

plt.semilogx(f2, mag2)
plt.semilogx(freqs2, dB(vout2/vin2), "*")
plt.xlabel("Freq (Hz)")
plt.ylabel("Mag(H) (dB)")
plt.title("Gráfico de Bode de magnitude para o 2º circuito")
plt.grid()
plt.savefig("figura2.png")
plt.show()


# Gráfico de ambos os circuitos juntos

plt.semilogx(f1, mag1)
plt.semilogx(f2, mag2)
plt.semilogx(freqs1, dB(vout1/vin1), "*")
plt.semilogx(freqs2, dB(vout2/vin2), "*")
plt.xlabel("Freq (Hz)")
plt.ylabel("Mag(H) (dB)")
plt.title("Gráfico de Bode de magnitude para ambos os circuitos")
plt.grid()
plt.savefig("figura3.png")
plt.show()
