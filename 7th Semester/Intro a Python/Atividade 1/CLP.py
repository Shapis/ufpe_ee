from Instrumentos import Termometro
from Instrumentos import Pressiometro
from Instrumentos import Vazometro


class CLP:
    instrumentos = [
        Termometro("Termometro Interno"),
        Termometro("Termometro Externo"),
        Pressiometro("Pressiometro Interno"),
        Pressiometro("Pressiometro Externo"),
        Vazometro("Vazometro"),
    ]

    def __init__(self, nome):
        self.nome = nome
