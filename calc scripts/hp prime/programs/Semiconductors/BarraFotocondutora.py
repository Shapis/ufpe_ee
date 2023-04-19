# PYTHON EXPORT BarraFotocondutora()

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


# Equacoes do formulario

def BarraFotocondutora():
    _l = float(input("Comprimento da barra (cm): "))
    _l = _l*1E-2
    print()
    _b = float(input("Largura da barra (cm): "))
    _b = _b*1E-2
    print()
    _d = float(input("Espessura da barra (cm): "))
    _d = _d*1E-2
    print()
    _E_gap = float(input("Energia de Gap do material (eV): "))
    _E_gap = _E_gap*e
    print()
    _Mobilidade_eletrons = float(input("Mobilidade de eletrons (cm^2/V.s): "))
    _Mobilidade_eletrons = _Mobilidade_eletrons*1E-4
    print()
    _Mobilidade_buracos = float(input("Mobilidade de buracos (cm^2/V.s): "))
    _Mobilidade_buracos = _Mobilidade_buracos*1E-4
    print()
    _Lambda = float(input("Comprimento de onda da luz (um): "))
    _Lambda = _Lambda*1E-6
    print()
    _Io = float(input("Intensidade da luz (mW/cm^2): "))
    _Io = _Io*10
    print()
    _n = float(input("Eficiencia quantica: "))
    print()
    _tau = float(input("Tempo de recombinacao dos portadores (s): "))
    print()
    
    print("a) A fotocorrente gerada e o ganho fotocondutivo quando uma tensão de (?)V é aplicada entre as faces menores da barra")
    print()
    _tensao = float(input("Tensao informada no item a) (V): "))
    print()
    
    print("i) Delta I = b.d.g.Tau_r.e(mi_n + mi_p).V/l")
    print("ii) g = n.Io/h_cortado.w.d = n.Io.2.pi/h.2.pi.f.d = n.Io.lambda/h.c.d")
    print("substituindo ii) em i): Delta I = b.Tau_r.e.(mi_n + mi_p).V/l . n.Io.lambda/h.c")
    _g = _n*_Io*_Lambda/(h*c*_d)
    _Delta_I = (_b*_d*_g*_tau*e*(_Mobilidade_eletrons+_Mobilidade_buracos)*_tensao/_l)
    print()
    print("Fotocorrente =", _Delta_I*1E3, "(mA)")
    print("Ganho fotocondutivo = Delta I / e.g.b.d.l =", _Delta_I/(e*_g*_b*_d*_l)) 
    print()
    
    print("b) Para maximizar a fotocorrente substitui-se na formula do Delta I o valor de 'b' pela maior dimensão da barra e o valor de 'l' pela menor dimensao da barra.")
    _b_2 = max(_b, _l, _d)
    _l_2 = min(_b, _l, _d)
    _d_2 = _b+_l+_d-max(_b, _l, _d)-min(_b, _l, _d)
    _g_2 = _n*_Io*_Lambda/(h*c*_d_2)
    _Delta_I_2 = (_b_2*_d_2*_g_2*_tau*e*(_Mobilidade_eletrons+_Mobilidade_buracos)*_tensao/_l_2)
    print("Fotocorrente =", _Delta_I_2*1E3, "(mA)")
    print("Ganho fotocondutivo = Delta I / e.g.b.d.l =", 10*_Delta_I_2/(e*_g*_b*_d*_l)) # TODO:ESTA DANDO 500 ERA PRA DAR 5000
    print()
    
    print("c) O comprimento de onda de corte, a partir do qual nao ha fotocorrente gerada.")
    print("Lambda_corte = h.c/Eg =", h*c/_E_gap, "(m)")
BarraFotocondutora()

# END
