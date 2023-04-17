# PYTHON EXPORT CelulaSolar()

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

def form_Is(I_L, V_CA):
    DoForm()
    print("I = Is(e^(ev/KbT) - 1) - I_L")
    IsolaVars("Is")
    print("Is = I_L/(e^(ev/KbT) - 1)")
    return (I_L/(math.exp(V_CA/KbTe) - 1))

# Lista 4 Questao 2

def SolveCelulaSolar():
    print("Item a) caso em série")
    _VCA1 = float(input("V_CA1 em Volt: "))
    _IL1 = float(input("I_L1 em Ampére: "))
    _VCA2 = float(input("V_CA2 em Volt: "))
    _IL2 = float(input("I_L2 em Ampére: "))

    I_s1 = form_Is(_IL1, _VCA1)
    I_s2 = form_Is(_IL2, _VCA2)
    print("I_s1 = " , I_s1 , "A")
    print("I_s2 = " , I_s2 , "A")
    
    if I_s1<=I_s2:
        Icc = -_IL1
    else:
        Icc = -_IL2
    
    V = _VCA1 + _VCA2
    P1 = V*Icc
    
    print("Icc = " , round(Icc, 2) , "A")
    print("V = ", round(V, 2), "V")
    print("P = ", round(P1, 2), "W")

    print("Item b) caso em paralelo")
    I = _IL1 + _IL2
    print("I = ", I, "A")
    print("I = I1 + I2 = Is1(e^(ev/KbT) - 1) - I_L1 + Is2(e^(ev/KbT) - 1) - I_L2 = 0")
    print("(Is1+Is2)(e^(ev/KbT) - 1) = ", I)
    print("do item a): Is1+Is2 = ", I_s1+I_s2, "A")
    print("V = ln(", I, "/", I_s1+I_s2, "+1).0,026")
    V = math.log((I/(I_s1+I_s2))+1)*0.026
    print("V =", round(V, 3), "V")
    P2 = -V*I
    print("P =", round(P2, 3), "W")
    
    print("Item c) conclusão")
    if P1<P2:
        print("Como ", round(-P1, 3), ">", round(-P2, 3), ", a conexão em série é melhor, pois concede mais energia.")
    else:
        print("Como ", round(-P2, 3), ">", round(-P1, 3), ", a conexão em paralelo é melhor, pois concede mais energia.")
        
SolveCelulaSolar()
# END
