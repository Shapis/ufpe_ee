# PYTHON EXPORT PNPJFETGAIN()

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


def form_Beta_Transitor(_Dp, _Na, _Lne, _Beta, _l, _Lp, _Dne):
    DoForm()
    print("{cosh{1/Lp} + ([(Dne Nd Lp)/(Dp Na Lne)]*senh{1/Lp}) - 1}^1")
    IsolaVars("Nd")
    print("Nd = [Dp Na Lne (1 + 1/Beta - cosh(l/Lp))]/(senh[l/Lp] Dne Lp)")
    return ((_Dp * _Na * _Lne)*(1 + (1/_Beta) - math.cosh(_l/_Lp)))/(math.sinh(_l/_Lp) * _Dne * _Lp)


def form_Alpha_Transistor(_Dp, _Na, _Lne, _Beta, _l, _Lp, _Dne, _Nd):
    DoForm()
    print("alpha = {cosh{1/Lp} + ([(Dne Nd Lp)/(Dp Na Lne)]*senh{1/Lp})}^1")
    return (math.cosh(_l/_Lp) + (((_Dne * _Nd * _Lp)/(_Dp * _Na * _Lne)) * math.sinh(_l/_Lp)))**(-1)

# Lista 3 Questao 3


def SolvePnpGain():
    _elemento = SelectElemento()
    print("Qual a espessura da base em micrometro?")
    _l = float(input())
    _l = _l * 1E-6
    print("Qual a dopagem do emissor? em cm^-3?")
    _dopagem = float(input())
    _dopagem = _dopagem * 1E6
    print("Quais os tempos de recombinacao de buracos, e eletrons nesta ordem em microsegundo?")
    _tauP = float(input())
    _tauN = float(input())
    _tauP = _tauP * 1E-6
    _tauN = _tauN * 1E-6
    print("Qual o ganho Beta (Ic/Ie)?")
    _B = float(input())
    _Ln = form_Ln(_elemento.Dn * 1E-4, _tauN)
    _Lp = form_Lp(_elemento.Dp * 1E-4, _tauP)
    _Nd = form_Beta_Transitor(_elemento.Dp * 1E-4,
                              _dopagem, _Ln, _B, _l, _Lp, _elemento.Dn * 1E-4)
    print("Nd = ", _Nd, "m^-3")

    _alpha = _Nd = form_Alpha_Transistor(_elemento.Dp * 1E-4,
                                         _dopagem, _Ln, _B, _l, _Lp, _elemento.Dn * 1E-4, _Nd)
    print("Beta = alpha / (1-alpha)")
    print("alpha = ", _alpha)
    FimDoPrograma()


SolvePnpGain()

# END
