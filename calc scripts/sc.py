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


def form_Lp(_Dp, _tauP):
    DoForm()
    print("Lp = sqrt(Dp * tau P)")
    return (_Dp * _tauP)**(1/2)


def form_Ln(_Dn, _tauN):
    DoForm()
    print("Ln = sqrt(Dn * tau N)")
    return (_Dn * _tauN)**(1/2)


# Lista 3 - Questao 3
def form_Beta_Transitor(_Dp, _Na, _Lne, _Beta, _l, _Lp, _Dne):
    print("{cosh{1/Lp} + ([(Dne Nd Lp)/(Dp Na Lne)]*senh{1/Lp}) - 1}^1")
    print("Nd = [Dp Na Lne (1 + 1/Beta - cosh(l/Lp))]/(senh[l/Lp] Dne Lp)")
    return ((_Dp * _Na * _Lne)*(1 + (1/_Beta) - math.cosh(_l/_Lp)))/(math.sinh(_l/_Lp) * _Dne * _Lp)


def form_Alpha_Transistor(_Dp, _Na, _Lne, _Beta, _l, _Lp, _Dne, _Nd):
    print("{cosh{1/Lp} + ([(Dne Nd Lp)/(Dp Na Lne)]*senh{1/Lp})}^1")
    return (math.cosh(_l/_Lp) + (((_Dne * _Nd * _Lp)/(_Dp * _Na * _Lne)) * math.sinh(_l/_Lp)))**(-1)


# Lista 3 - Questao 4
def form_Tensao_Critica(_Nd, _a, _elemento):
    print("Vc = e Nd  a**2 / 2 epsilon")
    return (e * _Nd * _a**2) / (2 * _elemento.epsilon)


def form_Condutancia_Canal(_Nd, _a, _elemento, _L, _D):
    print("G_0 = 2 e Nd mu_n D a / L")
    return (2 * e * _Nd * (_elemento.ue*1E-4) * _D * _a) / _L


def form_Condutancia_Canal(_Nd, _a, _elemento, _L, _D):
    print("G_0 = 2 e Nd mu_n D a / L")
    return (2 * e * _Nd * (_elemento.ue*1E-4) * _D * _a) / _L


def form_IdSat(_G0, _Vc, _Vd, _Vp):
    print(
        "|Id_sat| = G_0 * Vc [(Vd/Vc) + (2/3)*(-Vp/Vc)^(3/2) - (2/3)((Vd-Vp)/Vc)^(3/2)]")
    return _G0 * _Vc * ((_Vd / _Vc) + (2/3)*((-_Vp/_Vc)**(3/2)) - (2/3)*(((_Vd - _Vp) / _Vc)**(3/2)))


def form_TensaoCriticaCasoReal(_Na, _elemento, _ei, _d, _D, _Qox):
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


def SolvePnpGain():
    print("Qual elemento do transistor?")
    print("1 - Ge")
    print("2 - Si")
    print("3 - GaAs")
    userInput = int(input())
    _elemento = 0
    match userInput:
        case 1:
            _elemento = Ge
        case 2:
            _elemento = Si
        case 3:
            _elemento = GaAs
        case _:
            EscolhaInvalida()
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
    print(_Nd, "m^-3")
    print("Beta = alpha / (alpha-1)")
    _alpha = _Nd = form_Alpha_Transistor(_elemento.Dp * 1E-4,
                                         _dopagem, _Ln, _B, _l, _Lp, _elemento.Dn * 1E-4, _Nd)
    print(_alpha)
    FimDoPrograma()


def SolveCanalJFET():
    print("Qual elemento do transistor?")
    print("1 - Ge")
    print("2 - Si")
    print("3 - GaAs")
    userInput = int(input())
    _elemento = 0
    match userInput:
        case 1:
            _elemento = Ge
        case 2:
            _elemento = Si
        case 3:
            _elemento = GaAs
        case _:
            EscolhaInvalida()
    print("Qual o Na e Nd em cm^-3?")
    # _Na = float(input()) * 1E6
    _Nd = float(input()) * 1E6
    print("Meia largura do canal(a) em micrometro?")
    _a = float(input()) * 1E-6
    print("Comprimento do canal(L) em micrometro?")
    _L = float(input()) * 1E-6
    print("Profundidade do canal(D) em milimetros?")
    _D = float(input()) * 1E-3
    print("Supondo que Vo = 0 temos... :")
    _Vc = form_Tensao_Critica(_Nd, _a, _elemento)
    print("Tensao critica: " + str(_Vc) + " V")
    _G0 = form_Condutancia_Canal(_Nd, _a, _elemento,  _L, _D)
    print("Condutancia do canal: " + str(_G0) + " S")
    print("Qual o Vp para saturacao?")
    _Vp = float(input())
    print("Vd = Vc + Vp")
    _Vd = _Vc + _Vp
    print("Vd = " + str(_Vd) + " V")
    _Idsat = form_IdSat(_G0, _Vc, _Vd, _Vp)
    print("Idsat = " + str(_Idsat) + " A")
    print("Idsat = " + str(_Idsat*1E3) + " mA")
    print("Para tensoes maior que Vsat a corrente continua Vsat")
    FimDoPrograma()


def SolveTransistorMOSFET():
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
    print("E qual o semicondutor?")
    print("1 - Ge")
    print("2 - Si")
    print("3 - GaAs")
    userInput = int(input())
    _elemento = 0
    match userInput:
        case 1:
            _elemento = Ge
        case 2:
            _elemento = Si
        case 3:
            _elemento = GaAs
        case _:
            EscolhaInvalida()
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

    print("Na condicao de inversao: l = ((4 Es PhiF)/(e Na))^(1/2)")
    _l = (((4 * _elemento.epsilon * _phiF) / (e * _Na))**(1/2))
    print("l = " + str(_l) + " m")
    print("C = A / ((d/ei + l/es))")
    _C = (_D*_L)/((_Espessura/(_EOxido*epsilon_0))+(_l / _elemento.epsilon))
    print("C = " + str(_C) + " F")
    print("C = " + str(_C*1E12) + " pF")
    FimDoPrograma()


def SolveTransistorPnp():
    print("Qual elemento do transistor?")
    print("1 - Ge")
    print("2 - Si")
    print("3 - GaAs")
    userInput = int(input())
    _elemento = 0
    match userInput:
        case 1:
            _elemento = Ge
        case 2:
            _elemento = Si
        case 3:
            _elemento = GaAs
        case _:
            EscolhaInvalida()
    print("Qual o Vbb?")
    _Vbb = float(input())
    print("Qual o Vcc?")
    _Vcc = float(input())
    print("Qual o R_L?")
    _Rl = float(input())
    print("Para achar o Rb e Vbe, insira o Ib em microampere")
    _Ib = float(input()) * 1E-6


# Inicio do programa
print("0 - Sair")
# print("1 - E_f: Energia de Fermi")
# print("2 - V_f: Velocidade de Fermi")
# print("3 - V_d: Velocidade de Deriva")
print("1 - Dopagem da base de transistor PNP e ganho de corrente em configuracao base comum")
print("2 - A tensao critica, condutancia do canal, valores de Vd e Id")
print("3 - A tensao critica MOSFET no caso real, Corrente de saturacao, capacitancia total da regiao do canal na condicao de inversao")
print("Que grandeza voce quer?")
userInput = int(input())
match userInput:
    case 0:
        FimDoPrograma()
    case 1:
        SolvePnpGain()
    case 2:
        SolveCanalJFET()
    case 3:
        SolveTransistorMOSFET()
    case 4:
        SolveTransistorPnp()
    case _:
        EscolhaInvalida()


FimDoPrograma()
