from instrumento import Termometro, Presenciometro


class CLP:
    instrumentos = [
        Termometro("Termometro 1"),
        Termometro("Termometro 2"),
        Presenciometro("Presenciometro 1"),
    ]

    def __init__(self, nome):
        self.nome = nome
