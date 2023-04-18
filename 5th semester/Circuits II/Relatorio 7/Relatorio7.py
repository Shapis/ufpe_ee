import sympy as smp

I1, I2, V1, V2, R1, R2, R3, Va = smp.symbols('I1 I2 V1 V2 R1 R2 R3 V_a')

eq1 = smp.Eq(-I1 + (V1-Va)/R1 + V1/R2, 0)
eq2 = smp.Eq((Va-V1)/R1 + (Va-V2)/R1 + Va/R2, 0)
eq3 = smp.Eq((V2-Va)/R1 + V2/R3 - I2, 0)

smp.pprint(eq1)

z11, z12, z21, z22 = smp.symbols('Z11 Z12 Z21 Z22')

sols = smp.solve([eq1, eq2, eq3], [V1, V2, Va])

R1 = 8200
R2 = 47000
R3 = 82000


z11 = (sols[V1]/I1)
z11 = z11.subs([(I2, 0)])
z12 = (sols[V1]/I2)

smp.pprint(z11)
