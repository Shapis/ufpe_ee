# PYTHON EXPORT LaserDiodo()

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

def form_Lp(_Dp, _tauP):
    DoForm()
    print("Lp = sqrt(Dp * tau P)")
    return (_Dp * _tauP)**(1/2)


def form_Ln(_Dn, _tauN):
    DoForm()
    print("Ln = sqrt(Dn * tau N)")
    return (_Dn * _tauN)**(1/2)


def form_Is(I_L, Is):
    DoForm()
    print("I = Is(e^(eV/KbT) - 1) - I_L = 0")
    IsolaVars("V")
    print("e^(eV/KbT) = (I_L/Is) + 1")
    print("V = 0.026 * ln((I_L/Is) + 1)")
    return (KbTe * math.log((I_L / Is) + 1))


# Lista 4 Questao 6


def SolveLaserDiodo():
    # Entrada de dados
    _elemento = SelectElemento()
    _I = float(input("Insira a corrente de operacao em A: "))
    print()
    _n = float(input("Insira a eficiencia n de conversao em %: "))
    print()
    _W = float(input("Insira a potencia de entrada em mW: "))
    print()

    _W = _W * 10**-3
    _n = _n / 100

    # Calculos
    print("Item a) Resistencia em Serie R")
    DoForm()
    print("n = Psaida / Pentrada")
    print("PL = Pele / n")
    _PL = _W / _n
    print("A corrente de entrada P_L eh: ", _PL, "W")
    print("P = VI, V = P/I")
    _V = _PL / _I
    print("A tensao de entrada V eh: ", _V, "V")

    print("")
    print("Utilize a equacao dada pelo enunciado.")
    print("No caso especifico de V = Eg/q + I Rs...")
    _Rs = (_V - (_elemento.E_Gap / e)) / _I

    print("A resistencia em serie eh: ", _Rs, "Ohms")


SolveLaserDiodo()
# END
