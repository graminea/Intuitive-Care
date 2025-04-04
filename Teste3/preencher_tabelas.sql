/*
* Esse script popula as tabelas criadas anteriormente utilizando os csv baixados
* 
* O script utiliza caminho = tabelas_csv/, que teoricamente funcionam, mas o postgres algumas vezes não consegue acessar
* esses arquivos, mesmo o script estando no mesmo diretório dos arquivos. Se ocorrer esse problema, substituir pelo caminho absoluto
* onde foi baixado os arquivos (C:/...) corrige o problema, desde que o postgres tenha acesso a essa pasta.
*
*
* Ele cria também uma tabela temporária que é utilizada para conversão de ',' para '.', que o postgres reconhece. 
*
*
*/
SET client_encoding = 'UTF8';

-- 1T2023
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/1T2023.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "1T2023" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 2T2023
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/2T2023.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "2T2023" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 3T2023
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/3T2023.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "3T2023" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 4T2023
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/4T2023.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "4T2023" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 2024 -----------------------------------------
-- 1T2024
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/1T2024.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "1T2024" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 2T2024
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/2T2024.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "2T2024" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 3T2024
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/3T2024.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "3T2024" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- 4T2024
CREATE TEMP TABLE temp_import (data TEXT, reg_ans TEXT, cd_conta_contabil INT, descricao TEXT, vl_saldo_inicial TEXT, vl_saldo_final TEXT);
\copy temp_import FROM 'tabelas_csv/4T2024.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';
INSERT INTO "4T2024" SELECT 
    data, 
    reg_ans, 
    cd_conta_contabil, 
    descricao,
    REPLACE(vl_saldo_inicial::VARCHAR, ',', '.')::NUMERIC(18,2),
    REPLACE(vl_saldo_final::VARCHAR, ',', '.')::NUMERIC(18,2)
FROM temp_import;
DROP TABLE temp_import;

-- Relatorio_cadop
\copy "Relatorio_cadop" FROM 'tabelas_csv/Relatorio_cadop.csv' WITH CSV HEADER DELIMITER ';' NULL 'NULL';