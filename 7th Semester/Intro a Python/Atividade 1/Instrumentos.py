import random


class Instrumento:
    def __init__(self, nome):
        self.nome = nome

    def lerMedida(self):
        raise Exception("Leitor nao implementado!")


class Termometro(Instrumento):
    def lerMedida(self):
        return str(round(random.uniform(-100, 100), 2)) + "°C"


class Pressiometro(Instrumento):
    def lerMedida(self):
        return str(round(random.uniform(0, 100), 3)) + " bar"


class Vazometro(Instrumento):
    def lerMedida(self):
        return str(round(random.uniform(0, 10), 2)) + " m³/s"
