import soundfile as sf


class LeitorEscritor:

    soundPathRoot = "/home/hpsilva/Music/"
    outputPath = "output/"

    def __init__(self, nomeDoArquivo):
        self.y, self.fs = sf.read(self.soundPathRoot + nomeDoArquivo)

    @property
    def sinal(self):
        return self.y, self.fs

    def write_signal(self, nomeDoArquivo, y, fs):
        sf.write(self.outputPath + nomeDoArquivo, y, fs)
        return
