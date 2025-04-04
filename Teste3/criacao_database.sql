CREATE DATABASE intuitive_care
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt-BR'
    LC_CTYPE = 'pt-BR'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\c intuitive_care

DO $$ 
DECLARE 
    sem INTEGER;
    ano INTEGER;
    table_name TEXT;
BEGIN
    FOR sem IN 1..4 LOOP
        FOR ano IN 3..4 LOOP
            table_name := sem || 'T202' || ano;
            EXECUTE 'CREATE TABLE "' || "table_name" || '" ( 
                data TEXT NOT NULL,
                reg_ans TEXT NOT NULL,
                cd_conta_contabil INT NOT NULL,
                descricao TEXT NOT NULL,
                vl_saldo_inicial NUMERIC(18,2) NOT NULL,
                vl_saldo_final NUMERIC(18,2) NOT NULL
            )';
        END LOOP;
    END LOOP;
END $$;

CREATE TABLE "Relatorio_cadop"
    (
        reg_ans TEXT NOT NULL PRIMARY KEY,
        cnpj CHAR(14) NOT NULL,
        razao_social TEXT NOT NULL,
        nome_fantasia TEXT,
        modalidade TEXT NOT NULL,
        logradouro TEXT NOT NULL,
        numero TEXT NOT NULL,
        complemento TEXT,
        bairro TEXT NOT NULL,
        cidade TEXT NOT NULL,
        uf CHAR(2) NOT NULL,
        cep CHAR(8) NOT NULL,
        ddd CHAR(2),
        telefone TEXT,
        fax TEXT,
        endereco_eletronico TEXT,
        representante TEXT NOT NULL,
        cargo_representante TEXT NOT NULL,
        regiao_de_comercializacao TEXT,
        data_reg_ans DATE NOT NULL
    )
