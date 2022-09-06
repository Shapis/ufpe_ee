import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize


# Abaixo são definidas duas arrays com os valores medidos.  A
# primeira, RL, contém os valores medidos das resistências de carga
# usadas.  A segunda array, V, contém as tensões medidas em cima de
# cada RL.  As arrays devem ter as mesmas dimensões.
#
# Os valores abaixo são apenas um exemplo.  Você deve apagá-los e
# colocar os valores que você obteve.  A variável RL_med é um array
# com os valores medidos das resistências de carga, e a variável V_med
# contém os valores das respectivas tensões de saída.
RL_med = np.array([217, 470, 1000, 3260, 6670])
V_med = np.array([0.86, 1.64, 2.71, 4.69, 5.59])

# Você não precisa modificar nada do código além dos valores acima.

# Obtenção da corrente sobre a resistência de carga
I_med = V_med/RL_med

# Geração de um vetor de correntes com mais pontos
I = np.linspace(0, 0.0045)

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
plt.show()
