import sympy as smp
# from sympy import I

# Definindo as variáveis simbólicas
Vo, Vi, Va, Vc, R1, R2, Rp, Cp, A, w, j, Hjw, wp, wc, K = smp.symbols(
    'V_o V_i V_a V_c R_1 R_2 R_p C_p A w j H_jw w_p, w_c, K')

# Analise nodal do circuito

eq1 = smp.Eq((Va - Vi)/R1 + (Va - Vo)/R2 + Va/(Rp + (1/(j * w * Cp))), 0)
eq2 = smp.Eq(Va * ((1/(j * w * Cp)))/(((1/(j * w * Cp))) + Rp), -Vc)
eq3 = smp.Eq(A * Vc, Vo)


sols = smp.solve([eq1, eq2, eq3], [Va, Vc, Vo])

# Aqui fazemos a seguinte substituição:
# Rp >> R1 , Rp >> R2, e A >> 1

Vo = (-A * R2 * Vi)/((Rp*(R1 + R2))*j*w*Cp + A*R1)

eqHjw = smp.Eq(Hjw, Vo/Vi)

# Resolvendo a equacao Hjw e colocando no formato canonico da um fitro passa baixa (-K wp / (jw + wp)) obtemos o seguinte:

eqwp = smp.Eq(wp, 1/(Rp*Cp))

eqK = smp.Eq(K, R2/R1)

eqwc = smp.Eq(wc, (A*wp)/(1 + K))


# Exemplo 1

print("Exemplo 1")
print("Para R1 = 4.7E4 ohms, R2 = 2.2E5 ohms, wp = 2E1 pi e A = 1E5")

eqK1 = eqK.subs({R1: 4.7E4, R2: 2.2E5})
# smp.pprint(eqK)
smp.pprint(eqK1.evalf())

K1 = smp.solve(eqK1, K)[0]

smp.pprint(eqwc)
smp.pprint(eqwc.subs({A: 1E5, wp: 20 * smp.pi, K: K1}).evalf())


