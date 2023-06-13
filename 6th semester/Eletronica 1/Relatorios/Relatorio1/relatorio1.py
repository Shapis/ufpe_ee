import sympy as smp
from sympy import *

# Definindo as variáveis simbólicas
Vo, Vi, Va, Vc, R1, R2, Rp, Cp, A, w, j, Hs = smp.symbols(
    'V_o V_i V_a V_c R_1 R_2 R_p C_p A w j H_s')

# Analise nodal do circuito

eq1 = smp.Eq((Va - Vi)/R1 + (Va - Vo)/R2 + Va/(Rp + (1/(j * w * Cp))), 0)
eq2 = smp.Eq(Va * ((1/(j * w * Cp)))/(((1/(j * w * Cp))) + Rp), -Vc)
eq3 = smp.Eq(A * Vc, Vo)


sols = smp.solve([eq1, eq2, eq3], [Va, Vc, Vo])

# Aqui fazemos a seguinte substituição:
# Rp >> R1 , Rp >> R2, e A >> 1

eqVo = (-A * R2 * Vi)/((Rp*(R1 + R2))*j*w*Cp + A*R1)

Hs = eqVo / Vi

# Agora vamos isolar j*w no denominador.

Hs = (-(A*R2)/(Cp*Rp*(R1+R2))) / (A*R1/(Cp*Rp*(R1+R2)) + j*w)

smp.pprint(Hs)
