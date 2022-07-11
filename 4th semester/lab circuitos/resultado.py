R1 = 15
R2 = 47
R3 = 22
R4 = 10
Vcc = 10

print('Va =', Vcc*R3/(R1+R3))
print('Va =', Vcc*R4/(R2+R4))
print('Vab =', Vcc*((R3/(R1+R3)) - (R4/(R2+R4))))
