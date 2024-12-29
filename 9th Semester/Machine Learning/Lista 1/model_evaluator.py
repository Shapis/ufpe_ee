from sklearn.metrics import accuracy_score
import numpy as np


class ModelEvaluator:
    def __init__(self, y_true, y_pred):
        self.y_true = y_true  # Verdadeiros valores das classes
        self.y_pred = y_pred  # Valores previstos pelo modelo

    def accuracy(self):
        return accuracy_score(
            self.y_true, self.y_pred
        )  # Calcula a precisão (acurácia) do modelo

    def mean_squared_error(self):
        return np.mean(
            (self.y_true - self.y_pred) ** 2
        )  # Calcula o erro quadrático médio (MSE)

    def standard_deviation(self):
        return np.std(
            self.y_true - self.y_pred
        )  # Calcula o desvio padrão dos erros de previsão

    def calculate_confusion_matrix(self):
        unique_labels = np.unique(
            self.y_true
        )  # Obtém as classes únicas (labels) dos dados reais
        conf_matrix = np.zeros(
            (len(unique_labels), len(unique_labels)), dtype=int
        )  # Inicializa a matriz de confusão

        label_to_index = {
            label: index for index, label in enumerate(unique_labels)
        }  # Mapeia as classes para índices

        for true, pred in zip(
            self.y_true, self.y_pred
        ):  # Percorre as observações reais e previstas
            conf_matrix[
                label_to_index[true], label_to_index[pred]
            ] += 1  # Preenche a matriz de confusão

        return conf_matrix  # Retorna a matriz de confusão

    def evaluate_model(self, model_name):
        print(f"\nAvaliador: {model_name}\n")
        # Calcula e imprime a acurácia do modelo
        accuracy = self.accuracy()
        print(f"Precisao: {accuracy:.4f}")

        # Calcula e imprime o erro quadrático médio (MSE)
        mse = self.mean_squared_error()
        print(f"Mean Squared Error(MSE): {mse:.2f}")

        # Calcula e imprime o desvio padrão dos erros de previsão
        std_dev = self.standard_deviation()
        print(f"Desvio Padrao: {std_dev:.2f}")

        # Calcula e imprime a matriz de confusão
        conf_matrix = self.calculate_confusion_matrix()
        print("Matriz Confusao:")
        print(conf_matrix)

        return {
            "accuracy": accuracy,  # Retorna a precisão
            "mean_squared_error": mse,  # Retorna o erro quadrático médio
            "standard_deviation": std_dev,  # Retorna o desvio padrão
            "confusion_matrix": conf_matrix,  # Retorna a matriz de confusão
        }
