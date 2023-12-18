# PYTHON EXPORT Cascode()

import math

# Resolvedor de questoes de intruducao a semicondutores UFPE 2022.2

# Constantes Fisicas

Kb = 1.38 * 10 ** (-23)  # J/K
e = 1.6 * 10**-19  # C
KbTe = 0.026  # V (T = 300K)
epsilon_0 = 8.85 * (10**-12)  # F/m
h = 6.62 * 10**-34  # J*s
h_cortado = h / (2 * math.pi)  # J*s
m_0 = 9.11 * 10**-31  # Kg

# Classe para representar cada um dos elementos importantes e suas grandezas fisicas


class Elemento:
    E_Gap = 0  # Energia de Gap em Joules
    atomos = 0  # Atomos por cm^3
    parametroDeRede = 0  # Metro
    epsilon = 0  # Constante dieletrica do elemento * epsilon_0
    ni = 0  # Concentracao intrinseca cm^-3
    Nc = 0  # Concentracao efetiva Nc cm^-3
    Nv = 0  # Concentracao efetiva Nv cm^-3
    ue = 0  # Mobilidade de eletrons cm^2 / V*s
    ub = 0  # Mobilidade de buracos cm^2 / V*s
    Dn = 0  # Coeficiente de difusao cm^2 / s
    Dp = 0  # Coeficiente de difusao cm^2 / s
    me = 0  # Massa efetiva de elétrons (me*/mo)
    mc = 0  # Massa efetiva de elétrons (mc*/mo)
    mb = 0  # Massa efetiva de buracos (mb*/mo)
    mv = 0  # Massa efetiva de buracos (mv*/mo)


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


def form_Tensao_Critica(_Nd, _a, _elemento):
    print("Vc = e Nd  a**2 / 2 epsilon")
    return (e * _Nd * _a**2) / (2 * _elemento.epsilon)


def form_Condutancia_Canal(_Nd, _a, _elemento, _L, _D):
    print("G_0 = 2 e Nd mu_n D a / L")
    return (2 * e * _Nd * (_elemento.ue * 1e-4) * _D * _a) / _L


def form_Condutancia_Canal(_Nd, _a, _elemento, _L, _D):
    print("G_0 = 2 e Nd mu_n D a / L")
    return (2 * e * _Nd * (_elemento.ue * 1e-4) * _D * _a) / _L


def form_IdSat(_G0, _Vc, _Vd, _Vp):
    print(
        "|Id_sat| = G_0 * Vc [(Vd/Vc) + (2/3)*(-Vp/Vc)^(3/2) - (2/3)((Vd-Vp)/Vc)^(3/2)]"
    )
    return (
        _G0
        * _Vc
        * (
            (_Vd / _Vc)
            + (2 / 3) * ((-_Vp / _Vc) ** (3 / 2))
            - (2 / 3) * (((_Vd - _Vp) / _Vc) ** (3 / 2))
        )
    )


# Lista 3 Questao 4


def Cascode():
    _elemento = SelectElemento()
    print("Qual o Nd em cm^-3?")
    _Nd = float(input()) * 1e6
    print("Meia largura do canal(a) em micrometro?")
    _a = float(input()) * 1e-6
    print("Comprimento do canal(L) em micrometro?")
    _L = float(input()) * 1e-6
    print("Profundidade do canal(D) em milimetros?")
    _D = float(input()) * 1e-3
    print("Supondo que Vo = 0 temos... :")
    _Vc = form_Tensao_Critica(_Nd, _a, _elemento)
    print("Tensao critica: " + str(_Vc) + " V")
    _G0 = form_Condutancia_Canal(_Nd, _a, _elemento, _L, _D)
    print("Condutancia do canal: " + str(_G0) + " S")
    print("Qual o Vp para saturacao?")
    _Vp = float(input())
    print("Vd = Vc + Vp")
    _Vd = _Vc + _Vp
    print("Vd = " + str(_Vd) + " V")
    _Idsat = form_IdSat(_G0, _Vc, _Vd, _Vp)
    print("Idsat = " + str(_Idsat) + " A")
    print("Idsat = " + str(_Idsat * 1e3) + " mA")
    print("Para tensoes maior que Vsat a corrente continua Vsat")
    FimDoPrograma()


Cascode()

# END
