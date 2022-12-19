import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize


# Abaixo são definidas duas arrays com os valores medidos.  A
# primeira, RL, contém os valores medidos das resistências de carga
# usadas.  A segunda array, V, contém as tensões medidas em cima de
# cada RL.  As arrays devem ter as mesmas dimensões.
#
# Os valores abaixo são apenas um exemplo.  Você deve apagá-los e
# colocar os valores que você obteve.  A variável Vi_med refere-se às
# tensões de entrada medidas, onde o 1o elemento é referente a V1 e o
# 2o, a V2 (assim, o exemplo abaixo tem o primeiro ponto com V1 = -0.4
# e V2 = -0.2 e o último ponto com V1 = 0.4 e V2 = 0.2).  A variável
# Vo_med refere-se à tensão de saída medida.
R1, R2, R3 = 100380, 46760, 1040000
Vi_med = np.array([[-1.2, -1.2], [-1.2, -0.6], [-1.2, 0], [-1.2, 0.6], [-1.2, 1.2],
                   [-0.6, -1.2], [-0.6, -0.6], [-0.6, 0], [-0.6, 0.6], [-0.6, 1.2],
                   [0, -1.2], [0, -0.6], [0, 0], [0, 0.6], [0, 1.2],
                   [0.6, -1.2], [0.6, -0.6], [0.6, 0], [0.6, 0.6], [0.6, 1.2],
                   [1.2, -1.2], [1.2, -0.6], [1.2, 0], [1.2, 0.6], [1.2, 1.2],
                   ])
Vo_med = np.array([8.37, 5.48, 2.67, -0.21, -3.03,
                   7.03, 4.18, 1.36, -1.54, -4.36,
                   5.72, 2.85, 0.04, -2.84, -5.67,
                   4.31, 1.45, -1.31, -4.18, -7,
                   3.01, 0.23, -2.62, -5.53, -8.32, ]).reshape((25, 1))

# Você não precisa modificar nada do código além dos valores acima.

# Geração de vetores de tensões de entrada com mais pontos
V1_min, V2_min = Vi_med.min(axis=0)
V1_max, V2_max = Vi_med.max(axis=0)
V1 = np.linspace(V1_min, V1_max)
V2 = np.linspace(V2_min, V2_max)

# Cálculo dos ganhos teóricos
A1, A2 = -R3/R1, -R3/R2

# Definimos a matriz A e o vetor coluna B como especificado na ficha
# da prática.
#
# O valor de retorno da função lstsq() é uma array cujo primeiro
# elemento é uma outra array com os valores ótimos das incógnitas.
# Comoa ficha da prática menciona, estas incógnitas em nosso caso são
# Vth e Rth.
A, B = Vi_med, Vo_med
ganhos = np.linalg.lstsq(A, B, rcond=None)[0]

# Imprimimos o resultado
print(f"A1 experimental = {ganhos.flatten()[0]:6.3f}")
print(f"A2 experimental = {ganhos.flatten()[1]:6.3f}")

# Plotamos a curva da tensão de saída (a tensão em cima de RL) versus
# a corrente da carga.  Além disso, plotamos os valores medidos
# também. Observe que a curva é uma reta descrescente, como era
# esperado, já que a tensão de saída diminui à medida que a corrente
# aumenta devido à queda de tensão no resistor de Thevenin
plt.plot(V1, ganhos[0]*V1 + ganhos[1] *
         Vi_med[0, 1], label=f"V2 = {Vi_med[0, 1]}")
plt.scatter(Vi_med[0:5, 0], Vo_med[0:5], color="red")
plt.plot(V1, ganhos[0]*V1 + ganhos[1] *
         Vi_med[5, 1], label=f"V2 = {Vi_med[5, 1]}")
plt.scatter(Vi_med[5:10, 0], Vo_med[5:10], color="red")
plt.plot(V1, ganhos[0]*V1 + ganhos[1]*Vi_med[10, 1],
         label=f"V2 = {Vi_med[10, 1]}")
plt.scatter(Vi_med[10:, 0], Vo_med[10:], color="red")
plt.legend()
plt.title("Tensão de saída Vo versus tensão de entrada V1")
plt.xlabel("Tensão de entrada V1 (V)")
plt.ylabel("Tensão de saída Vo (V)")
plt.show()

plt.plot(V2, ganhos[0]*Vi_med[0, 0] + ganhos[1]
         * V2, label=f"V1 = {Vi_med[0, 0]}")
plt.scatter(Vi_med[::5, 1], Vo_med[::5], color="red")
plt.plot(V2, ganhos[0]*Vi_med[1, 0] + ganhos[1]
         * V2, label=f"V1 = {Vi_med[1, 0]}")
plt.scatter(Vi_med[1::5, 1], Vo_med[1::5], color="red")
plt.plot(V2, ganhos[0]*Vi_med[2, 0] + ganhos[1]
         * V2, label=f"V1 = {Vi_med[2, 0]}")
plt.scatter(Vi_med[2::5, 1], Vo_med[2::5], color="red")
plt.plot(V2, ganhos[0]*Vi_med[3, 0] + ganhos[1]
         * V2, label=f"V1 = {Vi_med[3, 0]}")
plt.scatter(Vi_med[3::5, 1], Vo_med[3::5], color="red")
plt.plot(V2, ganhos[0]*Vi_med[4, 0] + ganhos[1]
         * V2, label=f"V1 = {Vi_med[4, 0]}")
plt.scatter(Vi_med[4::5, 1], Vo_med[4::5], color="red")
plt.legend()
plt.title("Tensão de saída Vo versus tensão de entrada V2")
plt.xlabel("Tensão de entrada V2 (V)")
plt.ylabel("Tensão de saída Vo (V)")
plt.show()
