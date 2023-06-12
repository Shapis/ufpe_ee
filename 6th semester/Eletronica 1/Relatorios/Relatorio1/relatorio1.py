import sympy as smp
from sympy import *

# Definindo as variáveis simbólicas
Vo, Vi, Va, Vc, R1, R2, Rp, Cp, A, w, j = smp.symbols(
    'V_o V_i V_a V_c R_1 R_2 R_p C_p A w j')

# Analise nodal do circuito

eq1 = smp.Eq((Va - Vi)/R1 + (Va - Vo)/R2 + Va/(Rp + (1/(j * w * Cp))), 0)
eq2 = smp.Eq(Va * (Rp)/(((1/(j * w * Cp))) + Rp), Vc)
eq3 = smp.Eq(A * Vc, Vo)


solution = smp.solve([eq1, eq2, eq3], [Va, Vc, Vo])

smp.pprint(eq1)
smp.pprint(eq2)
smp.pprint(eq3)


smp.pprint(solution)
