import numpy as np


class NaiveBayesClassifier:
    def __init__(self):
        self.classes = None  # Armazena as classes únicas
        self.mean = {}  # Dicionário para armazenar a média de cada classe
        self.var = {}  # Dicionário para armazenar a variância de cada classe
        self.priors = (
            {}
        )  # Dicionário para armazenar as probabilidades a priori das classes

    def fit(self, x, y):
        self.classes = np.unique(y)  # Identifica as classes únicas nos dados
        for cls in self.classes:
            x_cls = x[y == cls]  # Filtra os dados para cada classe
            self.mean[cls] = np.mean(x_cls, axis=0)  # Calcula a média de cada classe
            self.var[cls] = np.var(x_cls, axis=0)  # Calcula a variância de cada classe
            self.priors[cls] = (
                x_cls.shape[0] / x.shape[0]
            )  # Calcula a probabilidade a priori da classe

    def _calculate_likelihood(self, mean, var, x):
        eps = 1e-6  # Constante pequena para evitar problemas numéricos por divisao por zero.
        coeff = 1.0 / np.sqrt(
            2.0 * np.pi * var + eps
        )  # Cálculo do coeficiente da distribuição normal
        exponent = np.exp(
            -((x - mean) ** 2) / (2 * var + eps)
        )  # Cálculo do expoente da distribuição normal
        return coeff * exponent  # Retorna a verossimilhança

    def _calculate_posterior(self, x):
        posteriors = {}  # Dicionário para armazenar os posteriors das classes
        for cls in self.classes:
            prior = np.log(self.priors[cls])  # Calcula o log da probabilidade a priori
            likelihood = np.sum(
                np.log(
                    self._calculate_likelihood(self.mean[cls], self.var[cls], x)
                )  # Calcula o log da verossimilhança
            )
            posteriors[cls] = (
                prior + likelihood
            )  # Calcula o posterior somando o log da prior e da verossimilhança
        return posteriors  # Retorna o dicionário com os posteriors para cada classe

    def predict(self, X):
        y_pred = [
            max(
                self._calculate_posterior(x), key=self._calculate_posterior(x).get
            )  # Previsão baseada no maior posterior
            for x in X
        ]
        return np.array(y_pred)  # Retorna as previsões como um array numpy
