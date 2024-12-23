from enum import Enum, auto
from scipy.signal import butter, lfilter, spectrogram, cheby1, cheby2

import numpy as np
import scipy.signal


class MetodoDeFiltro(Enum):
    IDEAL = auto()
    BUTTERWORTH = auto()
    CHEBYSHEV = auto()
    KAISER = auto()


class TipoDeFiltro(Enum):
    PASSA_BAIXA = auto()
    PASSA_ALTA = auto()
    PASSA_FAIXA = auto()
    REJEITA_FAIXA = auto()


class Filtro:
    def __init__(self, fs, leng):
        self.fs = fs
        self.leng = leng
        metodoDeFiltro = input(
            "Digite o método de filtro (IDEAL, BUTTERWORTH, CHEBYSHEV, KAISER): "
        )
        tipoDeFiltro = input(
            "Digite o tipo de filtro (PASSA_BAIXA, PASSA_ALTA, PASSA_FAIXA, REJEITA_FAIXA): "
        )

        match metodoDeFiltro:
            case "IDEAL":
                self.metodoDeFiltro = MetodoDeFiltro.IDEAL
            case "BUTTERWORTH":
                self.metodoDeFiltro = MetodoDeFiltro.BUTTERWORTH
            case "CHEBYSHEV":
                self.metodoDeFiltro = MetodoDeFiltro.CHEBYSHEV
            case "KAISER":
                self.metodoDeFiltro = MetodoDeFiltro.KAISER
            case _:
                print("Método de filtro inválido")
                return

        match tipoDeFiltro:
            case "PASSA_BAIXA":
                self.tipoDeFiltro = TipoDeFiltro.PASSA_BAIXA
            case "PASSA_ALTA":
                self.tipoDeFiltro = TipoDeFiltro.PASSA_ALTA
            case "PASSA_FAIXA":
                self.tipoDeFiltro = TipoDeFiltro.PASSA_FAIXA
            case "REJEITA_FAIXA":
                self.tipoDeFiltro = TipoDeFiltro.REJEITA_FAIXA
            case _:
                print("Tipo de filtro inválido")
                return

        if (
            self.tipoDeFiltro == TipoDeFiltro.PASSA_BAIXA
            or self.tipoDeFiltro == TipoDeFiltro.PASSA_ALTA
        ):
            self.frequenciaDeCorte = float(
                input("Digite a frequência de corte em Hertz: ")
            )
        else:
            self.frequenciaDeCorteBaixa = float(
                input("Digite a frequência de corte baixa em Hertz: ")
            )
            self.frequenciaDeCorteAlta = float(
                input("Digite a frequência de corte alta em Hertz: ")
            )
        self.gerar_filtro()

    def gerar_filtro(self):
        if self.metodoDeFiltro == MetodoDeFiltro.IDEAL:
            return self.gerar_filtro_ideal()
        elif self.metodoDeFiltro == MetodoDeFiltro.BUTTERWORTH:
            return self.gerar_filtro_butterworth()
        elif self.metodoDeFiltro == MetodoDeFiltro.CHEBYSHEV:
            return self.gerar_janela_chebyshev()
        elif self.metodoDeFiltro == MetodoDeFiltro.KAISER:
            return self.gerar_janela_kaiser()

    def gerar_filtro_ideal(self):
        coeficientes = np.zeros(self.leng)
        if self.tipoDeFiltro == TipoDeFiltro.PASSA_BAIXA:
            coeficientes[: self.frequenciaDeCorte] = 1
        elif self.tipoDeFiltro == TipoDeFiltro.PASSA_ALTA:
            coeficientes[self.frequenciaDeCorte :] = 1
        elif self.tipoDeFiltro == TipoDeFiltro.PASSA_FAIXA:
            coeficientes[self.frequenciaDeCorteBaixa : self.frequenciaDeCorteAlta] = 1
        elif self.tipoDeFiltro == TipoDeFiltro.REJEITA_FAIXA:
            coeficientes[: self.frequenciaDeCorteBaixa] = 1
            coeficientes[self.frequenciaDeCorteAlta :] = 1
        return coeficientes, 0

    def gerar_filtro_butterworth(self):
        ordem = int(input("Digite a ordem do filtro: "))
        match self.tipoDeFiltro:
            case TipoDeFiltro.PASSA_BAIXA:
                self.b, self.a = butter(
                    ordem, self.frequenciaDeCorte / (self.fs / 2), btype="low"
                )
            case TipoDeFiltro.PASSA_ALTA:
                self.b, self.a = butter(
                    ordem, self.frequenciaDeCorte / (self.fs / 2), btype="high"
                )
            case TipoDeFiltro.PASSA_FAIXA:
                self.b, self.a = butter(
                    25,
                    [
                        self.frequenciaDeCorteBaixa / (self.fs / 2),
                        self.frequenciaDeCorteAlta / (self.fs / 2),
                    ],
                    btype="band",
                )
            case TipoDeFiltro.REJEITA_FAIXA:
                self.b, self.a = butter(
                    25,
                    [
                        self.frequenciaDeCorteBaixa / (self.fs / 2),
                        self.frequenciaDeCorteAlta / (self.fs / 2),
                    ],
                    btype="bandstop",
                )
            case _:
                print("Tipo de filtro inválido")
                return

    def gerar_janela_chebyshev(self):
        delta = input("Digite o valor de delta: ")
        deltaOmega = input("Digite o valor de deltaOmega: ")

        A = -20 * np.log10(delta)
        if A < 21:
            B = 0
        elif A <= 50:
            B = 0.5842 * (A - 21) ^ (0.4) + 0.07886 * (A - 21)
        else:
            B = 0.1102 * (A - 8.7)
        M = np.ceil((A - 8) / (2.285 * deltaOmega))

        return scipy.signal.windows.chebwin(M, 60), 0

    def gerar_janela_kaiser(self):
        delta = input("Digite o valor de delta: ")
        deltaOmega = input("Digite o valor de deltaOmega: ")

        A = -20 * np.log10(delta)
        if A < 21:
            B = 0
        elif A <= 50:
            B = 0.5842 * (A - 21) ^ (0.4) + 0.07886 * (A - 21)
        else:
            B = 0.1102 * (A - 8.7)
        M = np.ceil((A - 8) / (2.285 * deltaOmega))

        return scipy.signal.windows.kaiser(M, B), 0

    @property
    def filtro(self):
        return self.b, self.a
