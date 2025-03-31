-- 1. Create a target table (match CSV structure)
CREATE TABLE imported_data (
    "DATA" TEXT,
    REG_ANS INTEGER,
    column3 DATE,
    -- Add more columns as needed
    "DATA";"REG_ANS";"CD_CONTA_CONTABIL";"DESCRICAO";"VL_SALDO_INICIAL";"VL_SALDO_FINAL"
);

-- 2. Import CSV using COPY command
COPY imported_data(column1, column2, column3)
FROM '/path/to/your/file.csv'
DELIMITER ',' 
CSV HEADER;  -- Use if CSV has header row
