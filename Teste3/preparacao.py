import requests
import zipfile
import os
import pandas as pd

os.makedirs("tabelas_csv", exist_ok=True)  
for i in range(3, 5):  # Loop de anos 2023 e 2024
    for k in range(1, 5):  # Trimestres 1 a 4
        response = requests.get(f"https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/202{i}/{k}T202{i}.zip", stream=True)
        with open(f"tabelas_csv/{k}T202{i}.zip", "wb") as file:
            file.write(response.content)
        
        with zipfile.ZipFile(f"tabelas_csv/{k}T202{i}.zip", "r") as zip_file:
            zip_file.extractall("tabelas_csv/")  # Extrai todos os arquivos do zip para o diretório especificado
        

        os.remove(f"tabelas_csv/{k}T202{i}.zip")

response = requests.get("https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv", stream=True)
with open("tabelas_csv/Relatorio_cadop.csv", "wb") as file:
    file.write(response.content)
