# PYTHON EXPORT FotoResistor()

import math

# Resolvedor de questoes de intruducao a semicondutores UFPE 2022.2

# Constantes Fisicas

Kb = 1.38 * 10**(-23)           # J/K
e = 1.6 * 10**-19               # C
KbTe = 0.026                    # V (T = 300K)
epsilon_0 = 8.85*(10**-12)      # F/m
h = 6.62 * 10**-34              # J*s
h_cortado = h / (2 * math.pi)   # J*s
m_0 = 9.11 * 10**-31             # Kg
c = 3 * 10**8                   # m/s

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
    print("Simplificando as equacoes e isolando " + _vars)


def SelectElemento():
    print("Qual elemento?")
    print("Digite um destes: Si , Ge , GaAs")
    userInput = input()
    if userInput == "Si":
        return Si
    elif userInput == "Ge":
        return Ge
    elif userInput == "GaAs":
        return GaAs
    else:
        EscolhaInvalida()


# Equacoes do formulario

def form_Condutividade(_elemento, _Nd, _Np):
    DoForm()
    print("sigma = Nd*e*un + Np*e*up")
    return (_Nd * e * _elemento.ue*1E-4 + _Np * e * _elemento.ub*1E-4)


# Lista 4 Questao 3


def SolveFotoResistor():
    # Entrada de dados
    _elemento = SelectElemento()
    print()
    _Nd = float(input("Qual o Nd em cm^-3: "))
    print()
    _Np = float(input("Qual o Np em cm^-3? Se nao foi dado eh 0 : "))
    print()
    _Tau_r = float(input("Qual o Tau_r em s: "))
    print()
    _Area = float(input("Qual a area em cm^2: "))
    print()
    _L = float(input("Qual o comprimento em micrometro: "))
    print()
    _V = float(input("Qual a tensao aplicada em Volts: "))
    print()
    _G = float(input("Qual a taxa de geracao de portadores em cm^-3 s^-1: "))
    print()

    # Conversoes para SI
    _L = _L * 10**-6
    _Nd = _Nd * 10**6
    _Area = _Area * 10**-4
    _G = _G * 10**6

    print("\nItem a) Corrente de escuro")
    _condutividade = form_Condutividade(_elemento, _Nd, _Np)

    print("I = V/R")
    print("R = L/(A*sigma)")
    print("Condutividade = ", _condutividade, " omega^-1")
    _I = _V/(_L/(_Area*_condutividade))
    print("Corrente I: ", _I*1E3, " mA")

    print("\nItem b) Concentracao de portadores em excesso")

    print("Taxao de geracao g = Numero de portadores / Tempo")
    print("Das equacoes adicionais: N_excesso = g * Tau_r")
    Nexcess = _G * _Tau_r
    print("N_excesso = ", Nexcess, " m^-3")

    print("\nItem c) Fotocondutividade")

    print("deltaSigma = g * Tau_r * e * (un + up)")
    _fotoCondutividade = _G * _Tau_r * e * \
        (_elemento.ue + _elemento.ub) * 1E-4
    print("Fotocondutividade = ", _fotoCondutividade, " omega^-1 m^-1")

    print("\nItem d) Fotocorrente")
    print("deltaI = V / deltaR = V * A * deltaSigma / L")
    _fotoCorrente = _V * _Area * _fotoCondutividade / _L
    print("Fotocorrente = ", _fotoCorrente * 1000, " mA")

    print("\nItem e) Ganho do dispositivo")

    DoForm()
    print("Ganho = deltaI / (e g b d l) = deltaI / (e g A L)")
    _ganho = _fotoCorrente / (e * _G * _Area * _L)
    print("Ganho = ", _ganho)

    print("\nItem e) Comprimento onda de corte do material")

    print("lambda_c = h * c / E_gap")
    _lambda_c = (h * c) / _elemento.E_Gap

    print("lambda_c = ", _lambda_c * 1E6, " micrometros")


SolveFotoResistor()
# END
