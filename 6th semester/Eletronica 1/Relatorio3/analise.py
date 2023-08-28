import matplotlib.pyplot as plt
import sympy as smp
from sympy import *

# Definindo as variáveis simbólicas
Vc, Vo, Vp, Vm, Vm1, Vm2, VD0, GND, Vcc, R1, R2, R3, R4, R5, C, t, s, IL = smp.symbols(
    'V_c V_o V_p V_m V_m1 V_m2, V_D0, GND, VCC, R_1, R_2, R_3, R_4, R_5, C, t, s I_L', real=True)

# Analise nodal do circuito

eq1 = smp.Eq((Vp - Vo)/R3 + (Vp - Vcc)/R1 + (Vp/R2), 0)
eq2 = smp.Eq(-Vm2 + C * Derivative(Vc, t) + Vc, 0)
eq3 = smp.Eq(Vm2, Vo)
eq4 = IL

dVc = Derivative(Vc, t)

smp.pprint(smp.solve([eq1, eq3], Vp))

smp.latex(eq1)

# eq2 = smp.Eq(Va * ((1/(j * w * Cp)))/(((1/(j * w * Cp))) + Rp), -Vc)
# eq3 = smp.Eq(A * Vc, Vo)
# # print('Equacoes em latex:')
# # smp.pprint(smp.latex(eq1))
# # smp.pprint(smp.latex(eq2))
# # smp.pprint(smp.latex(eq3))
# # print("")

# print("Equações do circuito:")
# print("Equacao 1:")
# smp.pprint(eq1)
# print("Equacao 2:")
# smp.pprint(eq2)
# print("Equacao 3:")
# smp.pprint(eq3)
# print("")

# sols = smp.solve([eq1, eq2, eq3], [Va, Vc, Vo])

# print("Soluçao para Vo:")
# smp.pprint(sols[Vo])
# # print("")
# # smp.pprint(smp.latex(sols[Vo]))
# print("")

# print("Aqui fazemos a seguinte simplificacao:")
# print("Rp >> R1 , Rp >> R2, e A >> 1")

# Vo = (-A * R2 * Vi)/((Rp*(R1 + R2))*j*w*Cp + A*R1)

# print("Equacao de Vo simplificada:")
# smp.pprint(Vo)
# # smp.pprint(smp.latex(Vo))
# print("")

# eqHjw = smp.Eq(Hjw, Vo/Vi)

# print("Equacao de Hjw:")
# smp.pprint(eqHjw)
# print("")

# print("Resolvendo a equacao Hjw e colocando no formato canonico da um fitro passa baixa (-K wp / (jw + wp)) obtemos o seguinte:")

# eqHjw = smp.Eq(Hjw, -(K * wc) / (I * w + wc))

# Hjw = -(K * wc) / (I * w + wc)

# smp.pprint(eqHjw)

# print("")

# eqwp = smp.Eq(wp, 1/(Rp*Cp))
# smp.pprint(eqwp)

# eqK = smp.Eq(K, R2/R1)
# smp.pprint(eqK)

# eqwc = smp.Eq(wc, (A*wp)/(1 + K))
# smp.pprint(eqwc)

# print("")

# # Hjw = Hjw.subs({K: R2/R1, wc: A*wp/(1+K)})

# print("Valor absoluto de Hjw:")
# Hjw_abs = smp.Abs(Hjw)
# smp.pprint(Hjw_abs)
# # smp.pprint(smp.latex(Hjw_abs))
# print("")


# print("Exemplo 1:")
# print("Para R1 = 4.7E3 ohms, R2 = 2.2E4 ohms, wp = 2E1 pi e A = 1E5\n")

# eqK1 = eqK.subs({R1: 4.7E3, R2: 2.2E4})
# K1 = smp.solve(eqK1, K)[0]
# smp.pprint(eqK1)
# print("")

# eqwc1 = eqwc.subs({A: 1E5, wp: 20 * smp.pi, K: K1}).evalf()
# wc1 = smp.solve(eqwc1, wc)[0]
# smp.pprint(eqwc1)
# print("")

# print("Valores absolutos para w = [0.5, 1, 2, 4, 10, 20, 40]*wc:")

# # ex1interval = [0.02, 0.01, 0.05, 0.2, 0.5, 1, 2, 4, 10, 20, 40]
# ex1interval = [0.5, 1, 2, 4, 10, 20, 40]

# ex1Vals = []

# for val in ex1interval:
#     temp = Hjw_abs.subs({w: wc1 * val, wc: wc1, K: K1})
#     ex1Vals.append(temp)
#     print('para freq:', round(((val*wc1)/(2*smp.pi)).evalf(), 2),
#           '\ttemos:', round(temp, 2))

# print("")

# print("Exemplo 2:")
# print("Para R1 = 4.7E3 ohms, R2 = 5.6E5 ohms, wp = 2E1 pi e A = 1E5\n")

# eqK2 = eqK.subs({R1: 4.7E3, R2: 5.6E5})
# K2 = smp.solve(eqK2, K)[0]
# smp.pprint(eqK2)
# print("")

# eqwc2 = eqwc.subs({A: 1E5, wp: 20 * smp.pi, K: K2}).evalf()
# wc2 = smp.solve(eqwc2, wc)[0]
# smp.pprint(eqwc2)
# print("")

# ex2interval = [0.5, 1, 5, 20, 50, 200, 500, 1000]
# ex2Vals = []

# for val in ex2interval:
#     temp = Hjw_abs.subs({w: wc2 * val, wc: wc2, K: K2})
#     ex2Vals.append(temp)
#     print('para freq:', round(((val*wc2)/(2*smp.pi)).evalf(), 2),
#           '\ttemos:', round(temp, 2))
# print("")


# # Plotando os graficos

# frequencias_plot = [i for i in range(1, 100000, 100)]

# plotH1 = [Hjw_abs.subs({w: i, wc: wc1, K: K1}) for i in frequencias_plot]
# plotH2 = [Hjw_abs.subs({w: i, wc: wc2, K: K2}) for i in frequencias_plot]

# fig, ax = plt.subplots()

# ax.plot(frequencias_plot, plotH1, color='blue', label='Exemplo 1')
# ax.plot(frequencias_plot, plotH2, color='orange', label='Exemplo 2')
# ax.legend(['Exemplo 1', 'Exemplo 2'])
# plt.xlabel('w rad/s')
# plt.ylabel('|H(jw)|')
# plt.title('Magnitude de H(jw)')


# plt.show()

# # Medicoes na pratica

# # Exemplo1
