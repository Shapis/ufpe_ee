# PYTHON EXPORT MOSFETTransistor()

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

def form_TensaoCriticaCasoReal(_Na, _elemento, _ei, _d, _D, _Qox):
    DoForm()
    print("Vc = ((Qd - Qox) / Ci) + 2phi_F = phi_ms")

    print(
        "2phiF = 2 (KbT / e) * ln (Na/ni)")
    _phiFtimesTwo = 2 * KbTe * math.log(_Na / (_elemento.ni * 1E6))
    print("Qd = 2 * (E_s * e * Na * phiF)^2 *A")
    Qd = 2 * ((_elemento.epsilon * e * _Na * (_phiFtimesTwo/2))
              ** (1/2))
    print("Ci = Ei * A / d")
    _Ci = ((_ei * epsilon_0) / _d)
    print("((Qd - Qox) / Ci) + 2phiF + phiMs")
    _phims = -1.1
    return [((Qd - _Qox) / _Ci) + _phiFtimesTwo + _phims, _Ci, _phiFtimesTwo/2]

# Lista 3 Questao 3


def SolveMOSFETTransistor():
    print("Qual o Na em cm^-3?")
    _Na = float(input()) * 1E6
    print("Qual espessura da camada de oxido em nanometro?")
    _Espessura = float(input()) * 1E-9
    print("Qual a carga por unidade da area de interface? em C/cm^2")
    _densidadeQ = float(input()) * 1E4
    print("Qual comprimento em micrometro?")
    _L = float(input()) * 1E-6
    print("Qual profundidade em micrometro?")
    _D = float(input()) * 1E-6
    print("Qual a constante de permissividade eletrica para o oxido?")
    _EOxido = float(input())
    _elemento = SelectElemento()
    sols = form_TensaoCriticaCasoReal(
        _Na, _elemento, _EOxido, _Espessura, _D, _densidadeQ)
    tccr = sols[0]
    _phiF = sols[2]
    print("Tensao critica caso real: " + str(tccr) + " V")
    print("Insira o Vp para achar a corrente de saturacao")
    _Vp = float(input())
    print("Vsat = Vp - Vc")
    _VSat = _Vp - tccr
    print("VSat = " + str(_VSat) + " V")
    _Ci = sols[1]
    _Ci = _Ci * _D*_L
    print("Isat = un Ci Vsat^2 / 2 L^2")

    _Isat = ((_elemento.ue*1E-4) * _Ci * (_VSat**2)) / (2 * _L**2)
    print("Isat = " + str(_Isat) + " A")
    print("Isat = " + str(_Isat*1E3) + " mA")
    print("Na condicao de inversao: l = ((4 Es PhiF)/(e Na))^(1/2)")
    _l = (((4 * _elemento.epsilon * _phiF) / (e * _Na))**(1/2))
    print("l = " + str(_l) + " m")
    print("C = A / ((d/ei + l/es))")
    _C = (_D*_L)/((_Espessura/(_EOxido*epsilon_0))+(_l / _elemento.epsilon))
    print("C = " + str(_C) + " F")
    print("C = " + str(_C*1E12) + " pF")
    FimDoPrograma()


SolveMOSFETTransistor()

# END
