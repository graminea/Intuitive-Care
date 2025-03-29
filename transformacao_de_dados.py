import zipfile
import pdfplumber
import pandas as pd
import re

def extrair(zip_path):
    """
    Extrai o zip dos anexos.

    Parametros:
    path(str): Caminho do arquivo zip. (anexos.zip nesse caso expecifico)

    ele será extraido para o diretorio do programa para arquivos (/data).

    Returns:
    None
    """
    with zipfile.ZipFile('data/anexos.zip', 'r') as zip_ref:
        zip_ref.extractall()
        
def extrair_legenda(texto_pagina):
    """
    Procura no rodapé da página palavras-chave que indicam o significado das siglas.
    Retorna um dicionário de substituições encontradas.
    """
    legenda = {}

    if "OD" in texto_pagina:
        match_od = re.search(r"OD\s*-\s*(.+)", texto_pagina)
        if match_od:
            legenda["OD"] = match_od.group(1).strip()

    if "AMB" in texto_pagina:
        match_amb = re.search(r"AMB\s*-\s*(.+)", texto_pagina)
        if match_amb:
            legenda["AMB"] = match_amb.group(1).strip()

    return legenda
def ler_e_salvar_tabelas(path, csv_path):
    """
    Lê as tabelas de um arquivo PDF.

    Parametros:
    path(str): Caminho do arquivo PDF.

    Returns:
    list: Lista de DataFrames com as tabelas lidas.
    """
    with pdfplumber.open(path) as pdf:
        tabelas = []

        for pagina in pdf.pages:
            texto_pagina = pagina.extract_text()  # Extrai o texto completo da página
            legenda_pagina = extrair_legenda(texto_pagina)  # Obtém a legenda específica da página
            
            tabelas_extraidas = pagina.extract_tables()
            
            for tabela in tabelas_extraidas:
                df = pd.DataFrame(tabela)

                # Se houver legenda nesta página, substituímos os valores na tabela
                if legenda_pagina:
                    df.replace(legenda_pagina, inplace=True)

                tabelas.append(df)

    if tabelas:
        resultado = pd.concat(tabelas, ignore_index=True)
        resultado.to_csv(csv_path, index=False, header=False)  # Salva sem índice e sem cabeçalho
    else:
        print("Nenhuma tabela encontrada.")

if __name__ == '__main__':
    extrair('data/anexos.zip')
    ler_e_salvar_tabelas('data/anexo_I.pdf', 'data/anexo_I.csv')