import math

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


def rlcpara(r, l, c):
    alpha = 1 / (2 * r * c)
    omega = 1 / math.sqrt(l * c)

    if abs(alpha-omega) < alpha*0.01:
        print('Se alpha:', alpha, '= omega:', omega,
              'entao o sistema é criticamente amortecido')
        print('v(t) = D1*t*e^(', -alpha, 't) + D2*e^(', -alpha, 't)')
        print('v(0) = D2')
        print('dv(0)/dt = D1 + ', -alpha, '*D2')
        print('dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    elif alpha > omega:
        raiz1 = -alpha + math.sqrt((alpha**2) - (omega**2))
        raiz2 = -alpha - math.sqrt((alpha**2) - (omega**2))
        print('Se alpha:', alpha, '> omega:', omega,
              'entao o sistema é superamortecido')
        print('v(t) = A1*e^(', raiz1, 't) + A2*e^(', raiz2, 't)')
        print('v(0) = A1 + A2')
        print('dv(0)/dt = A1*(', raiz1, ') + A2*(', raiz2, ')')
        print('dv/dt  = Ic/C')
        print('Ic = -IL - Ir')
    elif alpha < omega:
        raiz = math.sqrt((omega**2) - (alpha**2))
        print('Se alpha:', alpha, '< omega:', omega,
              'entao o sistema é subamortecido')
        print('v(t) = B1*cos(', raiz, 't)*e^(', -alpha,
              't) + B2*sin^(', raiz, 't)*e^(', -alpha, 't)')
        print('v(0) = B1')
        print('dv(0)/dt =  ', -alpha, '*B1 + ', raiz, '*B2')
        print('dv/dt  = Ic/C')
        print('Ic = -IL - Ir')

    return


def rlc():
    print('Responda as perguntas com o numero correspondente.')
    print('O sistema esta em resposta natural ou forcada?')
    print('1 - Resposta natural')
    print('2 - Resposta forcada')
    resposta = int(input())

    if (resposta == 1):
        print('here')
    else:
        print('Numero invalido')
        return


def rlcserie(r, l, c):
    alpha = r / (2*l)
    omega = 1 / math.sqrt(l * c)

    if abs(alpha-omega) < alpha*0.01:
        print('Se alpha:', alpha, '= omega:', omega,
              'entao o sistema é criticamente amortecido')
        print('v(t) = D1*t*e^(', -alpha, 't) + D2*e^(', -alpha, 't)')
        print('I(0) = D2')
        print('dI(0)/dt = D1 + ', -alpha, '*D2')
        print('dI/dt  = V(L) / L')
        print('V(R) + V(C) + V(L) = 0')
    elif alpha > omega:
        raiz1 = -alpha + math.sqrt((alpha**2) - (omega**2))
        raiz2 = -alpha - math.sqrt((alpha**2) - (omega**2))
        print('Se alpha:', alpha, '> omega:', omega,
              'entao o sistema é superamortecido')
        print('v(t) = A1*e^(', raiz1, 't) + A2*e^(', raiz2, 't)')
        print('I(0) = A1 + A2')
        print('dI(0)/dt = A1*(', raiz1, ') + A2*(', raiz2, ')')
        print('dI/dt  = V(L) / L')
        print('V(R) + V(C) + V(L) = 0')
    elif alpha < omega:
        parteImaginaria = math.sqrt((omega**2) - (alpha**2))
        print('Se alpha:', alpha, '< omega:', omega,
              'entao o sistema é subamortecido')
        print('v(t) = B1*cos(', parteImaginaria, 't)*e^(', -alpha,
              't) + B2*sin^(', parteImaginaria, 't)*e^(', -alpha, 't)')
        print('I(0) = B1')
        print('dI(0)/dt =  ', -alpha, '*B1 + ', parteImaginaria, '*B2')
        print('dI/dt  = V(L) / L')
        print('V(R) + V(C) + V(L) = 0')
    return


rlc()
