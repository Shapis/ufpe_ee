from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import pandas as pd
import numpy as np
import time

navegador = webdriver.Chrome()

navegador.get("https://accounts.google.com/servicelogin?hl=en-gb")
navegador.find_element("xpath", '//*[@id="identifierId"]').send_keys(
    "henrique.pedro@ufpe.br"
)

navegador.find_element("xpath", '//*[@id="identifierId"]').send_keys(Keys.ENTER)

time.sleep(8)

navegador.find_element(
    "xpath", '//*[@id="password"]/div[1]/div/div[1]/input'
).send_keys("senha")

navegador.find_element(
    "xpath", '//*[@id="password"]/div[1]/div/div[1]/input'
).send_keys(Keys.ENTER)

time.sleep(8)

navegador.get("https://gmail.com")

navegador.find_element(
    "xpath", "/html/body/div[8]/div[3]/div/div[2]/div[2]/div[1]/div[1]/div/div"
).click()

time.sleep(3)

# navegador.find_element("xpath", '//*[@id=":pd"]').send_keys(
#     "marcio.rodrigosantos@ufpe.br"
# )


time.sleep(50000)
