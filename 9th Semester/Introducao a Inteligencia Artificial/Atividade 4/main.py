import nltk
from nltk.tokenize import WhitespaceTokenizer
from nltk import FreqDist
from nltk import pos_tag
import random

# Baixar os recursos necessários
nltk.download("averaged_perceptron_tagger")
nltk.download("punkt")

# Abrir o arquivo e carregar o conteúdo em uma variável
with open("corpus.txt", "r", encoding="utf-8") as file:
    text = file.read()

# Exibir uma amostra do conteúdo do arquivo
print(
    "Conteúdo do arquivo:\n", text[:500]
)  # Exibe os primeiros 500 caracteres para evitar sobrecarga

# Tokenização do texto
tokenizador = WhitespaceTokenizer()
WORDS = tokenizador.tokenize(text)

print(
    "\nTokens:", WORDS[:10]
)  # Exibindo apenas os primeiros 10 tokens para visualização

# Exibindo o tamanho do texto e número de tokens
print("\nTamanho do texto (em caracteres):", len(text))
print("Número de tokens:", len(WORDS))

# Etiquetagem de partes do discurso (POS tagging)
tags = pos_tag(WORDS)

# Frequência das palavras (em minúsculas)
freq_dist = FreqDist(token.lower() for token in WORDS)

# Exibindo as 10 palavras mais frequentes
print("\n10 palavras mais frequentes:")
print(freq_dist.most_common(10))

# Exibindo as 10 tags mais comuns
tags_freq = FreqDist(tag for word, tag in tags)
print("\n10 tags mais comuns:")
print(tags_freq.most_common(10))


# Função para prever a próxima palavra após um ciclo de palavras dado
def prever_palavra(ciclo, texto):
    tokens = tokenizador.tokenize(texto.lower())
    lwords = []
    for i in range(len(tokens) - len(ciclo)):
        if tokens[i : i + len(ciclo)] == ciclo:
            lwords.append(tokens[i + len(ciclo)])

    if lwords:
        return random.choice(lwords)
    else:
        return None


# Testando a previsão de palavra após o ciclo
ciclo = ["point", "of"]
proxima_palavra = prever_palavra(ciclo, text)
print(f"\nA próxima palavra após o ciclo {ciclo} é: {proxima_palavra}")


# Função para classificar palavras em substantivos, adjetivos e verbos
def classificar_palavras(texto):
    # Etiquetando as palavras no texto
    tags = pos_tag(WORDS)

    # Filtrando substantivos (NN), adjetivos (JJ) e verbos (VB)
    substantivos = [word for word, tag in tags if tag.startswith("NN")]
    adjetivos = [word for word, tag in tags if tag.startswith("JJ")]
    verbos = [word for word, tag in tags if tag.startswith("VB")]

    return substantivos, adjetivos, verbos


# Classificando as palavras do texto
substantivos, adjetivos, verbos = classificar_palavras(text)

print("\nSubstantivos:", substantivos[:10])  # Exibindo apenas as 10 primeiras palavras
print("Adjetivos:", adjetivos[:10])  # Exibindo apenas as 10 primeiras palavras
print("Verbos:", verbos[:10])  # Exibindo apenas as 10 primeiras palavras
