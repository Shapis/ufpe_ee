import numpy as np


class LeastSquares:
    def fit(self, X, y):
        # Adiciona uma coluna de uns aos dados de entrada para o termo de interceptação
        X_b = np.c_[np.ones((X.shape[0], 1)), X]
        # Calcula os pesos ótimos utilizando a equação normal
        self.theta = np.linalg.inv(X_b.T.dot(X_b)).dot(X_b.T).dot(y)

    def predict(self, X):
        # Adiciona uma coluna de uns aos dados de entrada para o termo de interceptação
        X_b = np.c_[np.ones((X.shape[0], 1)), X]
        predictions = X_b.dot(
            self.theta
        )  # Calcula as previsões usando os pesos obtidos
        # Retorna a classe 1 se a previsão for <= 1.5, caso contrário retorna a classe 2
        return np.where(predictions <= 1.5, 1, 2)
