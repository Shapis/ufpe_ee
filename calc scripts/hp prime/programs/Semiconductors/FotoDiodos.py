# PYTHON EXPORT FotoDiodos()

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
    me = 0                      # Massa efetiva de eletrons (me*/mo)
    mc = 0                      # Massa efetiva de eletrons (mc*/mo)
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

# Lista 4 Questao 9


def FotoDiodos():
    print("a) Obtenha Vca, Icc e Is de cada dispositivo a temperatura ambiente.")

    print("do Formulario:")
    print("I = Is(e^(Vca.e/KbT) - 1) - I_L, onde I_L = Icc")
    print("Fazendo I = 0 e isolando Is")
    print("Is = Icc/(e^(Vca.e/KbT) - 1)")
    print()

    Vca1 = float(input("Vca do LS222 (V): "))
    print()
    Icc1 = float(input("Icc do LS222 (mA): "))
    print()
    Is1 = Icc1/(math.exp(Vca1/KbTe) - 1)
    print("Is do LS222 (pA): ", round(Is1*10**9, 2))
    print()
    Vca2 = float(input("Vca do LS223 (V): "))
    print()
    Icc2 = float(input("Icc do LS223 (mA): "))
    print()
    Is2 = Icc2/(math.exp(Vca2/KbTe) - 1)
    print("Is do LS223 (pA): ", round(Is2*10**9, 2))
    print()

    print("b) Escolher um conjunto para operar como fotodetetor e outro para celula solar")
    R = {}
    V = {}
    I = {}
    for i in range(3):
        R[i] = int(input("Resistencia: "))
        print()
    j = 0
    maiorI = 0
    R_L = 0
    print()
    print("fotodiodo LS222:")
    for i in range(6):
        if i == 3:
            j = i
            print()
            print("fotodiodo LS223:")
        print("Para a resistencia de ", R[i-j], "ohms")
        V[i] = float(input("Tensao (V): "))
        print()
        I[i] = float(input("Corrente (mA): "))
        print()
        if I[i] > maiorI:
            maiorI = I[i]
            index = i
            if index < 3:
                diodo = "LS222"
            else:
                diodo = "LS223"
            R_L = R[i-j]
    j = 0
    maiorP = 0
    print("fotodiodo LS222:")
    for i in range(6):
        if i == 3:
            j = i
            print()
            print("fotodiodo LS223:")
        print("R_L = ", R[i-j])
        P = V[i]*I[i]
        if P > maiorP:
            maiorP = P
            index = i
            if index < 3:
                diode = "LS222"
            else:
                diode = "LS223"
            R_l = R[i-j]
        print("Potencia: P = ", V[i], "(V).", I[i], "(mA)=", round(P, 3), "mW")
    print()
    print("Para a celula solar, que tem o objetivo de gerar energia para uma dada potencia luminosa, queremos a maior potencia no ponto de operaçao. Logo, podemos escolher o fotodiodo ",
          diode, "e o resistor de carga de ", R_l, "ohms")
    print()
    print("Para o fotodetetor, cujo objetivo e obter um maior sinal de corrente para uma dada iluminaçao, escolhe-se:")
    print("R_L =", R_L, "e o dispositivo", diodo)
    print()
    print("c)", maiorI)
    print()
    if diode == "LS222":
        print("d) P =", maiorP, ", FF = (Vm.Im)/(Icc.Vca) = P/(Icc.Vca) =",
              maiorP, "/(", Vca1, ".", Icc1, ") =", maiorP/(Vca1*Icc1))
    else:
        print("d) P =", maiorP, "(mW), FF = (Vm.Im)/(Icc.Vca) = P/(Icc.Vca) =",
              maiorP, "/(", Vca2, ".", Icc2, ") =", round(maiorP/(Vca2*Icc2), 3))


FotoDiodos()

# END
