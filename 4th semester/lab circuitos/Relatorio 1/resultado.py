# Resultados teoricos

R1 = 15
R2 = 47
R3 = 22
R4 = 10
Vcc = 10

Vab = Vcc*((R3/(R1+R3)) - (R4/(R2+R4)))

print('Va =', Vcc*R3/(R1+R3))
print('Va =', Vcc*R4/(R2+R4))
print('Vab =', Vab)
print()


# Resultados experimentais com resistor R4 desconhecido

R1 = 14.907
R2 = 21.930
R3 = 48.600


Vcc = 9.985
Vab = 0.133

R4 = (R2 * (R3 * (Vcc - Vab) - R1 * Vab))/(R3 * Vab + R1 * (Vcc + Vab))
print(R4)

Vabteorico = Vcc*((R3/(R1+R3)) - (R4/(R2+R4)))

print(Vabteorico-Vab)
