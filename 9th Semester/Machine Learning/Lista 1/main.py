import pandas as pd
import naive_bayes_classifier as nbc
from sklearn.model_selection import train_test_split
import model_evaluator as me
import least_squares as ls

# Substitua 'your_file.csv' pelo caminho do seu arquivo CSV
file_path = "dataset_ml20241212.csv"

# Lê o arquivo CSV e carrega os dados
data = pd.read_csv(file_path)

# Separa as variáveis independentes (x) e a variável dependente (y)
x = data.iloc[:, :-1].values
y = data.iloc[:, -1].values

# Divide os dados em conjuntos de treinamento (80%) e teste (20%)
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=42
)

# Treina o classificador Bayes
classificador_bayes = nbc.NaiveBayesClassifier()
classificador_bayes.fit(x_train, y_train)
y_prediction_bayes = classificador_bayes.predict(x_test)

# Avalia o desempenho do classificador Bayes
model_eval_bayes = me.ModelEvaluator(y_test, y_prediction_bayes)
bayes_results = model_eval_bayes.evaluate_model("Bayes")

# Treina o modelo de Mínimos Quadrados
classificador_least_squares = ls.LeastSquares()
classificador_least_squares.fit(x_train, y_train)
y_prediction_ls = classificador_least_squares.predict(x_test)

# Avalia o desempenho do modelo de Mínimos Quadrados
model_eval_ls = me.ModelEvaluator(y_test, y_prediction_ls)
ls_results = model_eval_ls.evaluate_model("Minimos Quadrados")
