import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize


# Abaixo são definidas duas arrays com os valores medidos.  A
# primeira, RL, contém os valores medidos das resistências de carga
# usadas.  A segunda array, V, contém as tensões medidas em cima de
# cada RL.  As arrays devem ter as mesmas dimensões.
#
# Os valores abaixo são apenas um exemplo.  Você deve apagá-los e
# colocar os valores que você obteve.
RL_med = np.array([100, 500, 1000, 2000, 10000, 50000])
V_med = np.array([0.486527, 1.92541, 3.08569, 4.63854, 7.85423, 9.01642])

# VOCÊ NÃO PRECISA MODIFICAR NADA DO CÓDIGO ALÉM DOS VALORES ACIMA.

# Obtenção da corrente sobre a resistência de carga
I_med = V_med/RL_med

# Geração de um vetor de correntes com mais pontos
I = np.linspace(0, 0.0049)

# Definimos a matriz A e o vetor coluna B como especificado na ficha
# da prática.
#
# O valor de retorno da função lstsq() é uma array cujo primeiro
# elemento é uma outra array com os valores ótimos das incógnitas.
# Comoa ficha da prática menciona, estas incógnitas em nosso caso são
# Vth e Rth.
A, B = np.vstack([np.ones_like(V_med), -V_med/RL_med]).T, V_med
thevenin = np.linalg.lstsq(A, B, rcond=None)[0]

# Imprimimos o resultado
print(f"Vth = {thevenin[0]}")
print(f"Rth = {thevenin[1]}")

# Plotamos a curva da tensão de saída (a tensão em cima de RL) versus
# a corrente da carga.  Além disso, plotamos os valores medidos
# também. Observe que a curva é uma reta descrescente, como era
# esperado, já que a tensão de saída diminui à medida que a corrente
# aumenta devido à queda de tensão no resistor de Thevenin
plt.plot(I, thevenin[0] - thevenin[1]*I)
plt.scatter(I_med, V_med, color="red")
plt.title("Curva da tensão de saída Vo pela corrente Io")
plt.xlabel("Io (mA)")
plt.ylabel("Vo (V)")
plt.show()
