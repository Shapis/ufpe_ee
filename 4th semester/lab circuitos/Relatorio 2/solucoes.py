Vcc = 10
R1 = 220
R2 = 1500
Re = 150
Rc = 1500
beta = 250
Vbe0 = 0.68

Rth = Rc
Rno = Rth

Vc = (R1 * Rc * Vcc * beta - R2 * Rc * Vbe0 * beta - R1 * Rc * Vbe0 *
      beta) / (R2 * (Re * beta + Re + R1) + R1 * (Re * beta + Re))

Vb = (R2 * Vcc * (Re * beta + Re + R1) - R1 * R2 * Vbe0) / \
    (R2 * (Re * beta + Re + R1) + R1 * (Re * beta + Re))

Ve = (R2 * (Re * Vbe0 * beta + Re * Vbe0) +
      R1 * (Re * Vbe0 * beta + Re * Vbe0) + R2 * Vcc * (Re*beta + Re + R1)) / (R2 * (Re * beta + Re + R1) + R1 * (Re * beta + Re))

Ib = (R1 * Vcc - R2 * Vbe0 - R1 * Vbe0) / \
    (R2 * (Re * beta + Re + R1) + R1 * (Re * beta + Re))

Vth = Vc

Ino = Vth/Rth

Icc = (Vcc - Vb)/R1 + (Vcc - Ve)/Re

print(f'Vth = {Vth:.2f}\nRth = {Rth:.2f}\nIno = {Ino:.5f}\nRno = {Rno:.5f}\nGno = {1/Rno:.5f}\nResistencia para carga maxima eh Rth = {Rth:.2f}\nPotencia dissipada pela carga: {(Vth**2/4)/Rth:.5f}\nPotencia da fonte para potencia maxima de Thevenin: {Vcc*Icc:0.2f}')
