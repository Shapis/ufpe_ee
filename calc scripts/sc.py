import math

# Resolvedor de questoes de intruducao a semicondutores UFPE 2022.2

# Constantes Fisicas

Kb = 1.38 * 10**(-23)           # J/K
e = 1.6 * 10**-19               # C
KbTe = 0.026                    # V (T = 300K)
epsilon_0 = 8.85*10**-12        # F/m
h = 6.62 * 10**-34              # J*s
h_cortado = h / (2 * math.pi)   # J*s
m_0 = 9.11 * 10**-31             # Kg

# Classe para representar cada um dos elementos importantes e suas grandezas fisicas


class Elemento:
    E_Gap = 0                   # Energia de Gap em Joules
    atomos = 0                  # Atomos por cm^3
    parametroDeRede = 0         # Metro
    epsilon = 0                 # Constante dieletrica do elemento * epsilon_0
    ni = 0                      # Concentracao intrinseca cm^-3
    Nc = 0                      # Concentracao efetiva Nc cm^-3
    Nv = 0                      # Concentracao efetiva Nv cm^-3
    ue = 0                      # Mobilidade de eletrons cm^2 / V*s
    ub = 0                      # Mobilidade de buracos cm^2 / V*s
    Dn = 0                      # Coeficiente de difusao cm^2 / s
    Dp = 0                      # Coeficiente de difusao cm^2 / s
    me = 0                      # Massa efetiva de elétrons (me*/mo)
    mc = 0                      # Massa efetiva de elétrons (mc*/mo)
    mb = 0                      # Massa efetiva de buracos (mb*/mo)
    mv = 0                      # Massa efetiva de buracos (mv*/mo)


# Criacao dos objetos elementos e definicao de suas grandezas fisicas a 300K
Ge = Elemento()
Si = Elemento()
GaAs = Elemento()
Ge.E_Gap = 0.66 * e
Si.E_Gap = 1.12 * e
GaAs.E_Gap = 1.43 * e
Ge.atomos = 4.42 * 10**22
Si.atomos = 5 * 10**22
GaAs.atomos = 2.21 * 10**22
Ge.parametroDeRede = 5.658 * 10**-10
Si.parametroDeRede = 5.431 * 10**-10
GaAs.parametroDeRede = 5.654 * 10**-10
Ge.epsilon = 16 * epsilon_0
Si.epsilon = 11.8 * epsilon_0
GaAs.epsilon = 10.9 * epsilon_0
Ge.ni = 2.5 * 10**13
Si.ni = 1.5 * 10**10
GaAs.ni = 10**7
Ge.Nc = 1.04 * 10**19
Si.Nc = 2.8 * 10**19
GaAs.Nc = 4.7 * 10**17
Ge.Nv = 6.1 * 10**18
Si.Nv = 1.02 * 10**19
GaAs.Nv = 7 * 10**18
Ge.ue = 3900
Si.ue = 1350
GaAs.ue = 8600
Ge.ub = 1900
Si.ub = 480
GaAs.ub = 400
Ge.Dn = 100
Si.Dn = 35
GaAs.Dn = 220
Ge.Dp = 50
Si.Dp = 12.5
GaAs.Dp = 10

# Funcoes auxilares


def FimDoPrograma():
    print("Fim do programa")
    quit()


def EscolhaInvalida():
    print("Escolha invalida, saindo do programa...")
    quit()


def DoForm():
    print("Do formulario:")


def DoProb():
    print("Do problema:")


def IsolaVars(_vars):
    print("Simplifiando as equacoes e isolando " + _vars)

# Equacoes dos formularios


# Energia de Fermi
def form_E_f(_N):
    DoForm()
    print("(((3 * (math.pi**2) * N)**(2/3)) * h_cortado**2) / (2 * m0)")
    DoProb()
    print("N = " + str(_N))
    return (((3 * (math.pi**2) * _N)**(2/3)) * h_cortado**2) / (2 * m_0)

# Velocidade em ffuncao da Energia, util pra calcular velocidade de Fermi


def form_V_f(_E_f):
    print("Da equacao de energia cinetica:")
    print("V_f = sqrt((2 * E_f) / m_0)")
    return math.sqrt((2 * _E_f) / m_0)


def form_V_x(_I, _A, _N):
    DoForm()
    print("V_x = e*E*tau/m*")
    form_J()
    form_sigma()
    IsolaVars("V_x")
    print("V_x = I / (A*N*e)")

    return _I / (_A*_N*e)


def form_J():
    DoForm()
    print("J = sigma * E")
    print("J = I / A")


def form_sigma():
    DoForm()
    print("(sigma = N * e^2 * tau)/m*")


# Resolvedores de problemas


# Energia de Fermi
def Solve_E_f():
    print("Insira a concentracao em cm^-3")
    _N = float(input())
    _N = _N * 1E6
    _E_f = form_E_f(_N)          # Convertendo de cm^-3 para m^-3
    print("Energia de Fermi:")
    print(str(_E_f) + ' J')
    print(str(_E_f / e) + ' eV')
    print("Digite 1 para calcular a V_f: Velocidade de Fermi, 0 para Sair")
    userInput = int(input())
    match userInput:
        case 0:
            FimDoPrograma()
        case 1:
            Solve_V_f(_E_f, _N)
        case _:
            EscolhaInvalida()


# Velocidade de Fermi
def Solve_V_f(_E_f, _N):
    if _E_f == 0:
        print("Insira a energia de Fermi em J")
        _E_f = float(input())
    _V_f = form_V_f(_E_f)
    print("Velocidade de Fermi:")
    print(str(_V_f) + 'm/s')
    print("Digite 1 para calcular a V_x: Velocidade de deriva, 0 para Sair")
    userInput = int(input())
    match userInput:
        case 0:
            FimDoPrograma()
        case 1:
            Solve_V_x(0, 0, _N)
        case _:
            EscolhaInvalida()

# Velocidade de deriva


def Solve_V_x(_I, _A, _N):
    if _I == 0:
        print("Insira a corrente em Ampere")
        _I = float(input())
    if _A == 0:
        print("Insira a area em mm^2")
        _A = float(input())
        _A = _A * 1E-6
    if _N == 0:
        print("Insira a concentracao em cm^-3")
        _N = float(input())
        _N = _N * 1E6

    print(_I, _A, _N)
    _V_d = form_V_x(_I, _A, _N)
    print("Velocidade de deriva:")
    print(str(_V_d) + ' m/s')
    FimDoPrograma()


# Inicio do programa


print("0 - Sair")
print("Que grandeza voce quer?")
print("1 - E_f: Energia de Fermi")
print("2 - V_f: Velocidade de Fermi")
print("3 - V_d: Velocidade de Deriva")
userInput = int(input())
match userInput:
    case 0:
        FimDoPrograma()
    case 1:
        Solve_E_f()
    case 2:
        Solve_V_f(0, 0)
    case 3:
        Solve_V_x(0, 0, 0)
    case _:
        EscolhaInvalida()

FimDoPrograma()
