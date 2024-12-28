import numpy as np


class NaiveBayesClassifier:
    def __init__(self):
        self.classes = None
        self.mean = {}
        self.var = {}
        self.priors = {}

    def fit(self, x, y):
        self.classes = np.unique(y)
        for cls in self.classes:
            x_cls = x[y == cls]
            self.mean[cls] = np.mean(x_cls, axis=0)
            self.var[cls] = np.var(x_cls, axis=0)
            self.priors[cls] = x_cls.shape[0] / x.shape[0]
            print(x_cls.shape[0] / x.shape[0])

    def _calculate_likelihood(self, mean, var, x):
        eps = 1e-6  # to avoid division by zero
        coeff = 1.0 / np.sqrt(2.0 * np.pi * var + eps)
        exponent = np.exp(-((x - mean) ** 2) / (2 * var + eps))
        return coeff * exponent

    def _calculate_posterior(self, x):
        posteriors = {}
        for cls in self.classes:
            prior = np.log(self.priors[cls])
            likelihood = np.sum(
                np.log(self._calculate_likelihood(self.mean[cls], self.var[cls], x))
            )
            posteriors[cls] = prior + likelihood
        return posteriors

    def predict(self, X):
        y_pred = [
            max(self._calculate_posterior(x), key=self._calculate_posterior(x).get)
            for x in X
        ]
        return np.array(y_pred)
