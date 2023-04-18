# PYTHON EXPORT FotodiodoLaser()

import math

# Resolvedor de questoes de intruducao a semicondutores UFPE 2022.2

# Constantes Fisicas

Kb = 1.38 * 10**(-23)           # J/K
e = 1.6 * 10**-19               # C
KbTe = 0.026                    # V (T = 300K)
epsilon_0 = 8.85*(10**-12)      # F/m
h = 6.62 * 10**-34              # J*s
h_cortado = h / (2 * math.pi)   # J*s
m_0 = 9.11 * 10**-31            # Kg
c = 3E8                         # m/s

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

# Lista 3 Questao 3


def FotodiodoLaser():
    _elemento = SelectElemento()
    _area = float(input("Area (cm²): "))
    _area = _area*1E-4
    _intensidade = float(input("Intensidade do laser (W/cm²): "))
    _intensidade = _intensidade*1E4
    _lambda = float(input("Comprimento de onda (nm): "))
    _lambda = _lambda*1E-9
    _Is = float(input("Corrente de saturação reversa (pA): "))
    _Is = _Is*1E-12
    _n = float(input("Eficiência (%): "))
    _n = _n*1E-2

    _P_L = _intensidade*_area
    _I_L = _n*e*_P_L*_lambda/(h*c)
    print("a) A fotocorrente gerada.\nP_L = Io.A =", _intensidade, ".", _area, "=", _P_L,"W")
    print("I_L = n.e.P_L.lambda/h.c =", _I_L, "(A)")
    
    print("\nb) A responsividade do fotodiodo para este comprimento de onda.")
    print("r = I_L/P_L =", _I_L/_P_L, "(A/W)")
    
    print("\nc) A corrente de escuro.")
    print("Ie = Is(e^(eV/KbT) - 1), com V=0, Ie = Is.(1-1) = 0")
    
    print("\nd) A corrente de escuro se o fotodiodo for polarizado reversamente.")
    _tensaoReversa = float(input("Tensão reversa (V): "))
    _Ie = _Is*(math.exp(-_tensaoReversa/KbTe) - 1)
    print("Ie = Is(e^(eV/KbT) - 1), com V =", -_tensaoReversa, ", Ie =", _Ie, "(A)")
    
    print("\ne)Supondo agora que este diodo seja utilizado para detectar a luz de um laser de (?) (Lambda = (?)).")
    _lambda_2 = float(input("Comprimento de onda do novo laser (um):"))
    _lambda_2 = _lambda_2*1E-6
    _lambda_c = h*c/_elemento.E_Gap
    print("Lambda_c = h.c/Eg =", _lambda_c, "(m)")
    
    print("\nQual a fotocorrente gerada para este comprimento de onda?")
    if _lambda_2>_lambda_c:
        print("A fotocorrente é nula já que o Lambda do novo laser é maior que o Lambda_c")
    else:
        _I_L = _I_L*_lambda_2/_lambda
        print("I_L = n.e.P_L.lambda/h.c")
        print("A fotocorrente para este comprimento de onda é", _I_L)
FotodiodoLaser()

# END
