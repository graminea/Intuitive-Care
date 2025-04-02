DO $$ 
DECLARE 
    sem INTEGER;
    ano INTEGER;
    table_name TEXT;
    file_path TEXT;
BEGIN
    FOR sem IN 1..4 LOOP
        FOR ano IN 3..4 LOOP
            table_name := 'S' || sem || 'T202' || ano;
            file_path := 'C:\Users\gabri\OneDrive\Documentos\Git\Intuitive-Care\scripts_sql\tabelas_csv\' || sem || 'T202' || ano || '.csv';

            -- Criar uma tabela temporária para importar os dados brutos (como texto)
            EXECUTE format(
                'CREATE TEMP TABLE temp_import (
                    data TEXT,
                    reg_ans TEXT,
                    cd_conta_contabil INT,
                    descricao TEXT,
                    vl_saldo_inicial TEXT,
                    vl_saldo_final TEXT
                )'
            );

            -- Importar os dados CSV para a tabela temporária
            EXECUTE format(
                'COPY temp_import (data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final) 
                 FROM %L 
                 WITH CSV HEADER DELIMITER '';'' NULL ''NULL'' ENCODING ''UTF8''',
                file_path
            );

            -- Converter os valores de vírgula para ponto e inserir na tabela correta
            EXECUTE format(
                'INSERT INTO "%s" (data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
                 SELECT data, reg_ans, cd_conta_contabil, descricao,
                        REPLACE(vl_saldo_inicial, '','', ''.'')::NUMERIC(18,2),
                        REPLACE(vl_saldo_final, '','', ''.'')::NUMERIC(18,2)
                 FROM temp_import',
                table_name
            );

            -- Apagar a tabela temporária
            EXECUTE 'DROP TABLE temp_import';

        END LOOP;
    END LOOP;
END $$;
