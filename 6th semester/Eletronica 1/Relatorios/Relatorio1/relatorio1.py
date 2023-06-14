import sympy as smp
from sympy import *

# Definindo as variáveis simbólicas
Vo, Vi, Va, Vc, R1, R2, Rp, Cp, A, w, j, Hjw, wp, wc, K = smp.symbols(
    'V_o V_i V_a V_c R_1 R_2 R_p C_p A w j H_jw w_p, w_c, K', real=True)

# Analise nodal do circuito

eq1 = smp.Eq((Va - Vi)/R1 + (Va - Vo)/R2 + Va/(Rp + (1/(j * w * Cp))), 0)
eq2 = smp.Eq(Va * ((1/(j * w * Cp)))/(((1/(j * w * Cp))) + Rp), -Vc)
eq3 = smp.Eq(A * Vc, Vo)

print("Equações do circuito:")
print("Equacao 1:")
smp.pprint(eq1)
print("Equacao 2:")
smp.pprint(eq2)
print("Equacao 3:")
smp.pprint(eq3)
print("")


sols = smp.solve([eq1, eq2, eq3], [Va, Vc, Vo])

print("Soluçao para Vo:")
smp.pprint(sols[Vo])
print("")

print("Aqui fazemos a seguinte simplificacao:")
print("Rp >> R1 , Rp >> R2, e A >> 1")

Vo = (-A * R2 * Vi)/((Rp*(R1 + R2))*j*w*Cp + A*R1)

print("Equacao de Vo simplificada:")
smp.pprint(Vo)
print("")

eqHjw = smp.Eq(Hjw, Vo/Vi)

print("Equacao de Hjw:")
smp.pprint(eqHjw)
print("")

print("Resolvendo a equacao Hjw e colocando no formato canonico da um fitro passa baixa (-K wp / (jw + wp)) obtemos o seguinte:")

eqHjw = smp.Eq(Hjw, -(K * wc) / (I * w + wc))

Hjw = -(K * wc) / (I * w + wc)

smp.pprint(eqHjw)

print("")


eqwp = smp.Eq(wp, 1/(Rp*Cp))
smp.pprint(eqwp)

eqK = smp.Eq(K, R2/R1)
smp.pprint(eqK)

eqwc = smp.Eq(wc, (A*wp)/(1 + K))
smp.pprint(eqwc)

print("")

# Hjw = Hjw.subs({K: R2/R1, wc: A*wp/(1+K)})

print("Valor absoluto de Hjw:")
smp.pprint(smp.Abs(Hjw))
print("")


print("Exemplo 1:")
print("Para R1 = 4.7E4 ohms, R2 = 2.2E5 ohms, wp = 2E1 pi e A = 1E5\n")

eqK1 = eqK.subs({R1: 4.7E4, R2: 2.2E5})
smp.pprint(eqK1)
# smp.pprint(eqK1.evalf())

K1 = smp.solve(eqK1, K)[0]

eqwc1 = eqwc.subs({A: 1E5, wp: 20 * smp.pi, K: K1}).evalf()

# smp.pprint(eqwc1)

wc1 = smp.solve(eqwc1, wc)[0]

Hjw1 = -(K1 * wc1) / (I * w + wc1)

# smp.pprint(Hjw1)

# smp.pprint(eqHjw)

# eqHjw1 = eqHjw.Eq(Hjw, -K1)
