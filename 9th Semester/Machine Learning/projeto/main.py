import os
import cv2
import numpy as np
import tensorflow as tf
from sklearn.model_selection import KFold
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt
from matplotlib import cm
from scipy.ndimage import center_of_mass

# Constantes
IMG_SIZE = 64
NUM_CLASSES = 3
CLASS_NAMES = ["tubarao", "mar", "naoSei"]
BATCH_SIZE = 32
EPOCHS = 10
K = 5


# Função para carregar imagens e labels
def carregar_dados(diretorio):
    X, y = [], []
    for label, nome_classe in enumerate(CLASS_NAMES):
        pasta_classe = os.path.join(diretorio, nome_classe)
        for img_nome in os.listdir(pasta_classe):
            img_path = os.path.join(pasta_classe, img_nome)
            img = cv2.imread(img_path)
            if img is not None:
                img = cv2.resize(img, (IMG_SIZE, IMG_SIZE))
                X.append(img)
                y.append(label)
    return np.array(X), np.array(y)


# Aumento de dados
def augmentar(imagem):
    rows, cols, _ = imagem.shape
    # Rotação
    M_rot = cv2.getRotationMatrix2D((cols / 2, rows / 2), np.random.uniform(-30, 30), 1)
    imagem = cv2.warpAffine(imagem, M_rot, (cols, rows))

    # Espelhamento
    if np.random.rand() > 0.5:
        imagem = cv2.flip(imagem, 1)

    # Ruído gaussiano
    ruido = np.random.normal(0, 10, imagem.shape).astype(np.uint8)
    imagem = cv2.add(imagem, ruido)

    return imagem


# Modelo
def criar_modelo(input_shape):
    inputs = tf.keras.Input(shape=input_shape)
    x = tf.keras.layers.Flatten()(inputs)
    x = tf.keras.layers.Dense(
        64, activation="relu", kernel_regularizer=tf.keras.regularizers.l2(0.001)
    )(x)
    x = tf.keras.layers.Dropout(0.3)(x)
    outputs = tf.keras.layers.Dense(NUM_CLASSES, activation="softmax")(x)
    model = tf.keras.Model(inputs=inputs, outputs=outputs)
    model.compile(
        optimizer="adam", loss="sparse_categorical_crossentropy", metrics=["accuracy"]
    )
    return model


# Treinamento com K-Fold
def treinar_kfold(X, y):
    kf = KFold(n_splits=K, shuffle=True)
    accs = []
    for train_idx, val_idx in kf.split(X):
        model = criar_modelo(X.shape[1:])
        X_train, y_train = X[train_idx], y[train_idx]
        X_val, y_val = X[val_idx], y[val_idx]
        model.fit(X_train, y_train, epochs=EPOCHS, batch_size=BATCH_SIZE, verbose=0)
        y_pred = np.argmax(model.predict(X_val), axis=1)
        acc = accuracy_score(y_val, y_pred)
        accs.append(acc)
    print(f"Acurácia média: {np.mean(accs):.4f} ± {np.std(accs):.4f}")
    return model


# Gerar heatmap de uma imagem
def gerar_heatmap(modelo, imagem):
    h, w, _ = imagem.shape
    heatmap = np.zeros((h, w))
    step = IMG_SIZE
    for y in range(0, h - step, step):
        for x in range(0, w - step, step):
            patch = imagem[y : y + step, x : x + step]
            patch = cv2.resize(patch, (IMG_SIZE, IMG_SIZE))
            patch = patch.astype(np.float32) / 255.0
            patch = np.expand_dims(patch, axis=0)
            pred = modelo.predict(patch, verbose=0)
            prob = pred[0][0]  # probabilidade da classe "tubarao"
            heatmap[y : y + step, x : x + step] = prob
    return heatmap


# Salvar heatmap
def salvar_heatmap(heatmap, original_img, path):
    plt.imshow(original_img)
    plt.imshow(heatmap, cmap=cm.jet, alpha=0.5)
    plt.axis("off")
    plt.savefig(path, bbox_inches="tight", pad_inches=0)
    plt.close()


# Centro de massa
def calcular_centro_massa(heatmap):
    mascara = heatmap > 0.75
    if np.sum(mascara) == 0:
        return None
    return center_of_mass(mascara)


# Main
if __name__ == "__main__":
    print("Carregando imagens...")
    X, y = carregar_dados("frames_treinamento")
    print(f"Total de imagens: {len(X)}")

    # Pré-processamento
    X = np.array([augmentar(img) for img in X]).astype("float32") / 255.0

    print("Treinando modelo...")
    modelo = treinar_kfold(X, y)

    # Teste com imagem de exemplo
    img_path = "teste/teste.jpg"
    imagem = cv2.imread(img_path)
    heatmap = gerar_heatmap(modelo, imagem)
    salvar_heatmap(heatmap, imagem, "saida_heatmap.png")
    centro = calcular_centro_massa(heatmap)
    print("Centro de massa (>75%):", centro)

    imagem_resized = cv2.resize(imagem, (IMG_SIZE, IMG_SIZE))
    imagem_norm = imagem_resized.astype("float32") / 255.0
    imagem_input = np.expand_dims(imagem_norm, axis=0)
    pred = modelo.predict(imagem_input, verbose=0)
    classe_idx = np.argmax(pred)
    classe_nome = CLASS_NAMES[classe_idx]
    prob = pred[0][classe_idx]

    print(f"Classe prevista para a imagem de teste: {classe_nome} ({prob*100:.2f}%)")

# Criar pasta de saída
os.makedirs("frames_resolvidos", exist_ok=True)

# Mapas de cores por classe: BGR
cores = {
    "tubarao": (0, 0, 255),  # Vermelho
    "mar": (255, 0, 0),  # Azul
    "naoSei": (0, 255, 0),  # Verde
}

print("Classificando frames e salvando com coloração...")

for nome_arquivo in sorted(os.listdir("frames")):
    if not nome_arquivo.lower().endswith((".jpg", ".png", ".jpeg")):
        continue

    caminho_img = os.path.join("frames", nome_arquivo)
    img = cv2.imread(caminho_img)
    if img is None:
        continue

    # Preprocessamento
    img_resized = cv2.resize(img, (IMG_SIZE, IMG_SIZE)).astype("float32") / 255.0
    img_input = np.expand_dims(img_resized, axis=0)

    # Predição
    pred = modelo.predict(img_input, verbose=0)
    classe_idx = np.argmax(pred)
    classe_nome = CLASS_NAMES[classe_idx]

    # Criar overlay colorido
    overlay = np.full_like(img, cores[classe_nome])  # BGR
    img_colorido = cv2.addWeighted(img, 0.5, overlay, 0.5, 0)

    # Salvar
    caminho_saida = os.path.join("frames_resolvidos", nome_arquivo)
    cv2.imwrite(caminho_saida, img_colorido)

print("Todos os frames resolvidos foram salvos em 'frames_resolvidos/'.")
