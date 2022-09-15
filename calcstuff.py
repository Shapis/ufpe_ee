import math


# Matematica Discreta

def mdc(a, b):
    if b > a:
        a, b = b, a
    if b == 0:
        return a
    x = [1, 0]
    y = [0, 1]
    r = [b, b]
    print('\n a\tb\tr\tq\txn\tyn')
    while (r[1] != 0):
        q = a // b
        r[1] = a % b
        xn = x[0] - (q * x[1])
        yn = y[0] - (q * y[1])
        print('', a, '\t', b, '\t', r[1], '\t', q, '\t', xn, '\t', yn)
        x[0] = x[1]
        x[1] = xn
        y[0] = y[1]
        y[1] = yn
        a = b
        b = r[1]
        if (r[1] != 0):
            r[0] = r[1]
    return r[0], x[0], y[0]


def lincong(a, b, n):
    aOrig = a
    bOrig = b

    a = a % n
    b = b % n

    euclidesExtendido = mdc(a, n)
    d = euclidesExtendido[0]
    u = euclidesExtendido[2]
    # v = euclidesExtendido[2]

    # Nao tem solucao!
    if (b % d != 0):
        print('Nao existe solucao pra essa congruencia linear')
        return 0

    x0 = (u * (b/d)) % n

    if (x0 < 0):
        x0 += n

    resultados = []
    for i in range(0, d):
        an = (x0 + (i * (n/d))) % n
        resultados.append(an)

    print(aOrig, 'x =', bOrig, '(mod ', n, ') | x: ', resultados)
    return resultados


# Circuitos 1

def para(list):
    sum = 0
    for i in list:
        sum += 1/i
    return 1/sum


def deltay(Ra, Rb, Rc):
    print(Ra, ' |', ' ', '-- ', Rb, '--', ' ', '| ', Rc)

    sum = (Ra+Rb+Rc)
    R1 = Ra * Rb / sum
    R2 = Rb * Rc / sum
    R3 = Rc * Ra / sum

    print(R1, ' \\', ' ', '|', R3, '|', ' ', '/ ', R2)

    return [R1, R3, R2]


def ydelta(Ra, Rb, Rc):
    print(Ra, ' \\', ' ', '|', Rb, '|', ' ', '/ ', Rc)

    sum = (Ra*Rb + Rb*Rc + Rc*Ra)

    R1 = sum / Rc
    R2 = sum / Rb
    R3 = sum / Ra

    print(R1, ' |', ' ', '-- ', R2, '--', ' ', '| ', R3)
    return [R1, R3, R2]


def rcserie(R, C):
    Xc = 1 / (2 * math.pi * C)
    return Xc


def rlcserie(R, L, C):
    Xc = 1 / (2 * math.pi * C)
    Xl = 2 * math.pi * L
    X = Xc * Xl / (Xc + Xl)
    return X


# caso 1,2,3 , superamortecido, critico, subamortecido
def rlcpara(r, l, c):
    alpha = 1 / (2 * r * c)
    omega = 1 / math.sqrt(l * c)

    if abs(alpha-omega) < alpha*0.01:
        print('Se alpha:', alpha, '= omega:', omega,
              'entao o sistema é criticamente amortecido')
        print('v(t) = D1*t*e^(', -alpha, 't) + D2*e^(', -alpha, 't)')
        print('v(0) = D2')
        print('dv(0)/dt = D1 + ', -alpha, '*D2')
        print('C dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    elif alpha > omega:
        raiz1 = -alpha + math.sqrt((alpha**2) - (omega**2))
        raiz2 = -alpha - math.sqrt((alpha**2) - (omega**2))
        print('Se alpha:', alpha, '> omega:', omega,
              'entao o sistema é superamortecido')
        print('v(t) = A1*e^(', raiz1, 't) + A2*e^(', raiz2, 't)')
        print('v(0) = A1 + A2')
        print('dv(0)/dt = A1*(', raiz1, ') + A2*(', raiz2, ')')
        print('C dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    elif alpha < omega:
        raiz = math.sqrt((omega**2) - (alpha**2))
        print('Se alpha:', alpha, '< omega:', omega,
              'entao o sistema é subamortecido')
        print('v(t) = B1*cos(', raiz, 't)*e^(', -alpha,
              't) + B2*sin^(', raiz, 't)*e^(', -alpha, 't)')
        print('v(0) = B1')
        print('dv(0)/dt =  -', alpha, '*B1 + ', raiz, '*B2')
        print('C dv/dt  = Ic/C')
        print('Ic = -IL - Ir')

    return


def rlcserie(r, l, c):
    alpha = r / (2*l)
    omega = 1 / math.sqrt(l * c)

    if abs(alpha-omega) < alpha*0.01:
        print('Se alpha:', alpha, '= omega:', omega,
              'entao o sistema é criticamente amortecido')
        print('v(t) = D1*t*e^(', -alpha, 't) + D2*e^(', -alpha, 't)')
        print('v(0) = D2')
        print('dv(0)/dt = D1 + ', -alpha, '*D2')
        print('C dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    elif alpha > omega:
        raiz1 = -alpha + math.sqrt((alpha**2) - (omega**2))
        raiz2 = -alpha - math.sqrt((alpha**2) - (omega**2))
        print('Se alpha:', alpha, '> omega:', omega,
              'entao o sistema é superamortecido')
        print('v(t) = A1*e^(', raiz1, 't) + A2*e^(', raiz2, 't)')
        print('v(0) = A1 + A2')
        print('dv(0)/dt = A1*(', raiz1, ') + A2*(', raiz2, ')')
        print('C dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    elif alpha < omega:
        raiz = math.sqrt((omega**2) - (alpha**2))
        print('Se alpha:', alpha, '< omega:', omega,
              'entao o sistema é subamortecido')
        print('v(t) = B1*cos(', raiz, 't)*e^(', -alpha,
              't) + B2*sin^(', raiz, 't)*e^(', -alpha, 't)')
        print('v(0) = B1')
        print('dv(0)/dt =  -', alpha, '*B1 + ', raiz, '*B2')
        print('C dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    return


rlcserie(9, 0.5, 0.02)
