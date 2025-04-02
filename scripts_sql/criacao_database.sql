DO $$ 
DECLARE 
    sem INTEGER;
    ano INTEGER;
    table_name TEXT;
BEGIN
    FOR sem IN 1..4 LOOP
        FOR ano IN 3..4 LOOP
            table_name := 'S' || sem || 'T202' || ano;
            EXECUTE 'CREATE TABLE "' || table_name || '" ( 
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
