import matplotlib.pyplot as plt
import sympy as smp
from sympy import *

# Definindo as variáveis simbólicas
Vi, R1, R2,  Rc, Re, Vcc, Vee, Vb, Ve, Vc, Ib, Ic, Ie, Beta, Rpi, gm, Vbe, Vo = smp.symbols(
    'V_i R_1 R_2 R_c R_e Vcc Vee V_b V_e V_c I_b I_c I_e Beta Rpi gm V_be V_o', real=True)

# Equações para grandes sinais

eq1 = smp.Eq(((Vb - Vee)/R2) + ((Vb - Vcc)/R1) + Ib, 0)
eq2 = smp.Eq((Vb-Ve), 0.7)
eq3 = smp.Eq((Vee-Ve)/Re, Ie)
eq4 = smp.Eq((Vcc-Vc)/Rc, Ic)
eq5 = smp.Eq(Ic, Beta*Ib)
eq6 = smp.Eq(Ie, Ic+Ib)

sols_grandes_sinais = smp.solve(
    [eq1, eq2, eq3, eq4, eq5, eq6], [Vc, Ve, Vb, Ie, Ib, Ic])

eq11 = smp.Eq(Vi/Rpi - Ib, 0)
eq12 = smp.Eq(Vo/Rc + Ic, 0)
eq13 = smp.Eq(Ic - gm * Vbe, 0)
eq14 = smp.Eq(Ie - Ic - Ib, 0)
eq15 = smp.Eq((Ib * Rpi) - Vbe, 0)

sols_ganho = smp.solve([eq11, eq12, eq13, eq14, eq15], [Vo, Vi, gm, Ic, Ib])

smp.pprint(sols_ganho[Vo]/sols_ganho[Vi])

smp.pprint(sols_ganho[Vi]/sols_ganho[Ib])
