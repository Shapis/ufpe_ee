import matplotlib.pyplot as plt
import sympy as smp
from sympy import *
import numpy as np

# j = smp.symbols('j', imaginary=True)

# Vo, Vi, Vm, V_C0, V_D0, R_m, C, t, R, Vc = smp.symbols(
#     'V_o V_i V_m V_C0 V_D0 R_m C t R V_c', real=True)


def updateEqs(Vm, V_C0, V_D0, R_m, C, t, R):
    Vo1 = ((V_C0 + Vm + V_D0) * np.exp(-t/(R_m * C))) - V_D0
    Vc1 = (V_C0 + Vm + V_D0) * np.exp(-t/(R_m * C)) - Vm - V_D0
    Vo2 = (V_C0 + Vm) * np.exp(-t/(R * C))
    Vc2 = (V_C0 + Vm) * np.exp(-t/(R * C)) - Vm
    return Vo1, Vc1, Vo2, Vc2


# Vo1, Vc1, Vo2, Vc2 = updateEqs(Vm, V_C0, V_D0, R_m, C, t, R)


# estado 1: Vm + Vc0 < - Vd0
# estado 2: Vm + Vc0 > - Vd0

# Exemplo 2

# R = float("inf")
R = 4.7E3
Vm = 5

# Dados
V_D0 = 0.5
C = 100E-9
R_m = 330
V_C0 = 0

Ts = 500E-6
step = 1E-7
temp = 0

intervalos_tempo = np.arange(0, 4*Ts + step, step)
valores_de_Vo = []
valores_de_Vc = []

for t in intervalos_tempo:
    temp += step
    if temp >= Ts/2:
        Vm = -Vm
        temp = 0

    Vo1, Vc1, Vo2, Vc2 = updateEqs(Vm, V_C0, V_D0, R_m, C, step, R)

    if (Vm + V_C0) < -V_D0:  # estado 1
        Vo = Vo1
        Vc = Vc1
    else:                   # estado 2
        Vo = Vo2
        Vc = Vc2

    valores_de_Vo.append(Vo)
    valores_de_Vc.append(Vc)
    V_C0 = Vc


# smp.pprint(Vo)

# Plotando os graficos


plotH1 = valores_de_Vo
plotH2 = valores_de_Vc


fig, ax = plt.subplots()

ax.plot(intervalos_tempo, plotH1, color='blue', label='Exemplo 1')
ax.plot(intervalos_tempo, plotH2, color='orange', label='Exemplo 2')
ax.legend(['Exemplo 1', 'Exemplo 2'])
plt.xlabel('w rad/s')
plt.ylabel('|H(jw)|')
plt.title('Magnitude de H(jw)')
plt.show()


print(min(valores_de_Vo))
print(max(valores_de_Vo))
