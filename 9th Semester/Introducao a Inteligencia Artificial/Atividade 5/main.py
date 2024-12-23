import os
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report
import warnings

warnings.filterwarnings("ignore")

# Paths to the folders containing the data and the labels
data_folder = "trec07p/data"
index_file = "trec07p/full/index"


# Function to load the dataset from the index file
def load_trec_spam_data(data_folder, index_file):
    texts = []
    labels = []

    # Open the index file to read labels and file paths
    with open(index_file, "r", encoding="latin-1") as f:
        for line in f:
            # Each line is of the format: label path/to/email.txt
            parts = line.strip().split()
            label = parts[0]  # 'spam' or 'ham'
            email_file = parts[1]  # Relative path to the email file

            # Construct the full path to the email file
            email_path = os.path.join(
                data_folder, email_file.lstrip("../data/")
            )  # Remove '../' from the relative path

            # Check if the email file exists
            if os.path.exists(email_path):
                # Read the email content
                with open(email_path, "r", encoding="latin-1") as email_f:
                    email_text = email_f.read().strip()

                # Append the email text and its corresponding label (1 for spam, 0 for ham)
                texts.append(email_text)
                labels.append(
                    1 if label == "spam" else 0
                )  # Label 1 for spam, 0 for ham
            else:
                print(f"Warning: Email file {email_file} does not exist. Skipping.")

    # Create a DataFrame
    df = pd.DataFrame({"texto": texts, "rotulo": labels})
    return df


# Load the dataset
df = load_trec_spam_data(data_folder, index_file)

# Check the first few rows of the dataframe
print(df.head())

# Dividir os dados em treino e teste
X = df["texto"]  # Textos (features)
y = df["rotulo"]  # Rótulos (spam ou ham)

# Dividir os dados em treino (80%) e teste (20%)
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Vetorização com TF-IDF
vectorizer = TfidfVectorizer(
    max_features=5000
)  # Usando as 5000 palavras mais frequentes
X_train_tfidf = vectorizer.fit_transform(X_train)
X_test_tfidf = vectorizer.transform(X_test)

# Criação e treinamento do modelo de Regressão Logística
model = LogisticRegression(max_iter=1000)
model.fit(X_train_tfidf, y_train)

# Fazer previsões no conjunto de teste
y_pred = model.predict(X_test_tfidf)

# Avaliar o modelo
accuracy = accuracy_score(y_test, y_pred)
print(f"Acurácia: {accuracy * 100:.2f}%")

# Relatório detalhado de desempenho
print("\nRelatório de Classificação:")
print(classification_report(y_test, y_pred))


# Agora, testando os arquivos nao_spam.txt e spam.txt
new_texts = []

# Carregar os textos de teste (nao_spam.txt e spam.txt)
with open("nao_spam.txt", "r", encoding="latin-1") as f:
    new_texts.append(f.read().strip())  # Adicionar conteúdo de nao_spam.txt

with open("spam.txt", "r", encoding="latin-1") as f:
    new_texts.append(f.read().strip())  # Adicionar conteúdo de spam.txt


# Função para carregar e testar novos arquivos de texto
def test_new_texts(model, vectorizer, texts):
    # Transformar os textos novos usando o mesmo TfidfVectorizer
    texts_tfidf = vectorizer.transform(texts)

    # Fazer previsões
    predictions = model.predict(texts_tfidf)

    # Exibir os resultados
    for i, text in enumerate(texts):
        print(f"Texto {i+1}: {'Spam' if predictions[i] == 1 else 'Ham'}")


# Testar os novos textos com o modelo
test_new_texts(model, vectorizer, new_texts)
