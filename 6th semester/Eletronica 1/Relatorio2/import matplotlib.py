import matplotlib.pyplot as plt
import sympy as smp
from sympy import *
import numpy as np

# j = smp.symbols('j', imaginary=True)

# Vo, Vi, Vm, V_C0, V_D0, R_m, C, t, R, Vc = smp.symbols(
#     'V_o V_i V_m V_C0 V_D0 R_m C t R V_c', real=True)


# Vo1, Vc1, Vo2, Vc2 = updateEqs(Vm, V_C0, V_D0, R_m, C, t, R)


# estado 1: Vm + Vc0 < - Vd0
# estado 2: Vm + Vc0 > - Vd0

# Exemplo 2

R = 4.7E3
Vm = 5

# Dados
V_D0 = 0.5
C = 100E-9
R_m = 330
V_C0 = 0

Ts = 1E-6
step = Ts/1000
temp = 0
tPeriodico = 0

intervalos_tempo = np.arange(0, 10*Ts, step)
valores_de_Vm = []
valores_de_Vc = []

for t in intervalos_tempo:
    temp += step
    if temp >= Ts/2:
        Vm = -Vm
        temp = 0

    Vc = (V_C0 - Vm) * np.exp(-(step)/(R_m * C)) + Vm

    valores_de_Vc.append(Vc)
    valores_de_Vm.append(Vm)
    V_C0 = Vc


# smp.pprint(Vo)

# Plotando os graficos


plotH1 = valores_de_Vm
plotH2 = valores_de_Vc


fig, ax = plt.subplots()

ax.plot(intervalos_tempo, plotH2, color='orange', label='Exemplo 2')
ax.plot(intervalos_tempo, plotH1, color='blue', label='Exemplo 1')
ax.legend(['Exemplo 1'])
plt.xlabel('w rad/s')
plt.ylabel('|H(jw)|')
plt.title('Magnitude de H(jw)')
plt.show()
