from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import pandas as pd
import numpy as np

navegador = webdriver.Chrome()

# Obtenha a cotacao do dolar.

navegador.get("https://www.google.com.br/")

navegador.find_element("xpath", '//*[@id="APjFqb"]').send_keys("cotação dólar")

navegador.find_element("xpath", '//*[@id="APjFqb"]').send_keys(Keys.ENTER)

dolar = navegador.find_element(
    "xpath",
    '//*[@id="knowledge-currency__updatable-data-column"]/div[1]/div[2]/span[1]',
).get_attribute("data-value")

# Obtenha a cotacao do euro.

navegador.get("https://www.google.com.br/")

navegador.find_element("xpath", '//*[@id="APjFqb"]').send_keys("cotação euro")

navegador.find_element("xpath", '//*[@id="APjFqb"]').send_keys(Keys.ENTER)

euro = navegador.find_element(
    "xpath",
    '//*[@id="knowledge-currency__updatable-data-column"]/div[1]/div[2]/span[1]',
).get_attribute("data-value")

# Obtenha a cotacao do ouro.

navegador.get("https://www.melhorcambio.com/ouro-hoje")

# obtendo o valor do ouro
ouro = navegador.find_element("xpath", '//*[@id="comercial"]').get_attribute("value")

ouro = ouro.replace(",", ".")

print(dolar)
print(euro)
print(ouro)

tabela = pd.read_excel("Produtos.ods")

print(tabela)

# Passo 5: Recalcular o preço de cada produto
# atualizar a cotação
# nas linhas onde na coluna "Moeda" = Dólar
tabela.loc[tabela["Moeda"] == "Dólar", "Cotação"] = float(dolar)
tabela.loc[tabela["Moeda"] == "Euro", "Cotação"] = float(euro)
tabela.loc[tabela["Moeda"] == "Ouro", "Cotação"] = float(ouro)

# atualizar o preço base reais (preço base original * cotação)
tabela["Preço de Compra"] = tabela["Preço Original"] * tabela["Cotação"]

# atualizar o preço final (preço base reais * Margem)
tabela["Preço de Venda"] = tabela["Preço de Compra"] * tabela["Margem"]

# tabela["Preço de Venda"] = tabela["Preço de Venda"].map("R${:.2f}".format)

print(tabela)

tabela.to_excel("Produtos Novo.xlsx", index=False)

navegador.get("https://www.gmail.com.br/")

navegador.find_element("xpath", '//*[@id="APjFqb"]')
