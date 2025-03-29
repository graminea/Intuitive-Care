import requests
import os
from bs4 import BeautifulSoup
import zipfile 

def get_website(url):
    response = requests.get(url) # pegar o conteudo do site
    return response.text # retorna em texto para facilitar o parser

def scrape(html):
    parsed_html = BeautifulSoup(html, 'html.parser') # fazer o parser do html
    
    anexo1 = parsed_html.find('a', string='Anexo I.').get('href') # encontrar a tag que contem "Anexo I." e pegarr o link
    
    anexo2 = parsed_html.find('a', string='Anexo II.').get('href') # encontrar a tag que contem "Anexo II." e pegar o link
    
    return anexo1, anexo2 # retorna os links

def save_and_compact(anexo1, anexo2):
    os.makedirs('data', exist_ok=True) # cria o diretórrio /data caso não exista para armazenar os arquivos auxiliares

    # salvar os anexos I e II em pdf
    anexo1_pdf = requests.get(anexo1, timeout=5) # pega o pdf do anexo I
    with open('data/anexo_I.pdf', 'wb') as file:
        file.write(anexo1_pdf.content) # salva em um pdf

    anexo2_pdf = requests.get(anexo2, timeout=5) # pega o pdf do anexo II
    with open('data/anexo_II.pdf', 'wb') as file:
        file.write(anexo2_pdf.content) # salva em um pdf
        
    # compactar os arquivos pdf em um arquivo .zip
    with zipfile.ZipFile('data/anexos.zip', 'w') as filezip:
        filezip.write('data/anexo_I.pdf')
        filezip.write('data/anexo_II.pdf')
        
    # remover os arquivos pdf
    os.remove('data/anexo_I.pdf')
    os.remove('data/anexo_II.pdf')


if __name__ == '__main__':
    content = get_website('https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos')
    anexo1, anexo2 = scrape(content)
    save_and_compact(anexo1, anexo2)
