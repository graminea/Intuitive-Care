import urllib.request
import zipfile

urllib.request.urlretrieve("https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/2024/1T2024.zip", "dados.zip")

with zipfile.ZipFile("dados.zip", "r") as zip_ref:
    zip_ref.extractall("dados.csv")