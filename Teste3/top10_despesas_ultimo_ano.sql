/*
 * CONSULTA SQL PARA IDENTIFICAR AS 10 OPERADORAS COM MAIORES DESPESAS EM EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR 
 * 
 * 
 * LÓGICA DA CONSULTA:
 * 1. Combina dados cadastrais das operadoras (Relatorio_cadop) com:
 *    - Dados financeiros consolidados de todos os trimestres de 2024 (1T2024 a 4T2024)
 * 
 * 2. Filtra especificamente por:
 *    - Eventos/sinistros conhecidos de assistência médico-hospitalar
 *    - Onde houve consumo real (saldo inicial > saldo final)
 * 
 * 3. Calcula:
 *    - Soma total das despesas por operadora (diferença entre saldos)
 * 
 * 4. Ordenação:
 *    - Ranking das 10 operadoras com maiores despesas
 * 
 */

SELECT 
    relatorio.reg_ans, 
    relatorio.razao_social, 
    SUM(ano.VL_SALDO_INICIAL - ano.VL_SALDO_FINAL) AS total_despesa
FROM 
    "Relatorio_cadop" relatorio
JOIN (
    SELECT * FROM "1T2024"
    UNION ALL
    SELECT * FROM "2T2024"
    UNION ALL
    SELECT * FROM "3T2024"
    UNION ALL
    SELECT * FROM "4T2024"
) ano ON relatorio.reg_ans = ano.reg_ans
WHERE 
    ano.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' and ano.VL_SALDO_INICIAL > ano.VL_SALDO_FINAL
GROUP BY 
    relatorio.reg_ans, relatorio.razao_social
ORDER BY 
    total_despesa DESC
LIMIT 10;
