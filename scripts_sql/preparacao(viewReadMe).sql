/*
esse script sql deveria funcionar no postgres, mas o plpython3u não está habilitado e não encontrei nenhuma maneira factível, 
sem envolver muita complexidade e etapas ao teste do código, para habilita-lo e, pelo sql puro não conseguir fazer requisições https sem vias externas, 
como uso de bibliotecas baixáveis (que aumentaria a complexidade da testagem por parte da equipe),
além de usarem métodos não muito seguros quando se trata de banco de dados, eu optei pela abordagem de usar um script python,
que é o mesmo do plpython3u, mas com a diferença de que ele não está dentro do sql script, mas retorna o mesmo resultado. Porém,
vou deixar o código do plpython3u aqui, para caso for habilitado. Python script runnig good.
*/

-- Esse script (deprecated) tinha como objetivo baixar os arquivos necessários para a execução dos testes 3 e 4.
CREATE EXTENSION plpython3u;
CREATE OR REPLACE FUNCTION salvar_arquivos()
RETURNS void AS $$
    import requests
    import zipfile
    import os

    os.makedirs("scripts_sql/tabelas_csv", exist_ok=True)  
    for i in range(3, 5):  # Loop de anos 2023 e 2024
        for k in range(1, 5):  # Trimestres 1 a 4
            response = requests.get(f"https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/202{i}/{k}T202{i}.zip")
            with open(f"scripts_sql/tabelas_csv/{k}T202{i}.zip", "wb") as file:
                file.write(response.content)
            
            with zipfile.ZipFile(f"scripts_sql/tabelas_csv/{k}T202{i}.zip", "r") as zip_file:
                zip_file.extractall("scripts_sql/tabelas_csv/")  # Extrai todos os arquivos do zip para o diretório especificado
            

            os.remove(f"scripts_sql/tabelas_csv/{k}T202{i}.zip")

    requests.get("https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv",
                                "scripts_sql/tabelas_csv/Relatorio_cadop.csv")
                                
$$ LANGUAGE plpython3u;

SELECT salvar_arquivos();

