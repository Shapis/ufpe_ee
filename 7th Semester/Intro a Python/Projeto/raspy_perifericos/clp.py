from instrumento import Termometro, Presenciometro


class CLP:
    instrumentos = [
        Termometro("Termometro_1", "codigo_aqui"),
        # Termometro("Termometro_2", "codigo_aqui"),
        Presenciometro("Presenciometro_1"),
    ]

    def __init__(self, nome):
        self.nome = nome
