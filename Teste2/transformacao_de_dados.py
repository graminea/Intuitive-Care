import zipfile
import pdfplumber
import pandas as pd

def compactar(csv_path):
    """
    Compacta o arquivo CSV em um zip.

    Parametros:
    path(str): Caminho do arquivo CSV. (anexo_I.csv nesse caso expecifico)

    Returns:
    None
    """
    with zipfile.ZipFile('data/Teste_Gabriel_Sagas_da_Silva.zip.', 'w') as zip_csv:
        zip_csv.write(csv_path, arcname='anexo_I.csv') # compacta o arquivo CSV
        
def ler_e_salvar_tabelas(path, csv_path):
    """
    Lê as tabelas de um arquivo PDF, transforma em DataFrame e salva como CSV. 

    Parametros:
    path(str): Caminho do arquivo PDF.

    Returns:
    None
    """
    with pdfplumber.open(path) as pdf:
        i = 0
        tabelas = []
        
        for pagina in pdf.pages:
            tabelas_extraidas = pagina.extract_tables() # extrai as tabelas da pagina
            
            for tabela in tabelas_extraidas:
                df = pd.DataFrame(tabela[1:], columns=tabela[0])   # transforma a tabela em DataFrame
                tabelas.append(df)
            if i == 8:
                break
            i += 1
                
    if tabelas:
        resultado = pd.concat(tabelas, ignore_index=True) # concatena todas as tabelas em um unico DataFrame
        resultado.to_csv(csv_path, index=False)  # salva o DataFrame em um arquivo CSV
    else:
        print("Nenhuma tabela encontrada.")

def modificar_tabela(csv_path):
    """
    Modifica o arquivo CSV para substituir OD e AMB pelos valores da legenda.

    Parametros:
    path(str): Caminho do arquivo CSV.

    Returns:
    None
    """
    df = pd.read_csv(csv_path)
    
    df.replace({ 
        'OD': 'Seg. Odontológica', # substitui OD por Seg. Odontológica
        'AMB': 'Seg. Ambulatorial' # substitui AMB por Seg. Ambulatorial
        }, inplace=True)
    
    df.to_csv(csv_path, index=False)  # Salva as modificações no mesmo arquivo CSV
if __name__ == '__main__':
    csv = ler_e_salvar_tabelas('data/anexo_I.pdf', 'data/anexo_I.csv')
    compactar('data/anexo_I.csv')
    modificar_tabela('data/anexo_I.csv')