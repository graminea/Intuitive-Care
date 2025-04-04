/*
 * CONSULTA SQL PARA IDENTIFICAR TOP 10 OPERADORAS COM MAIORES DESPESAS EM EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR NO ULTIMO TRIMESTRE
 * 
 * DETALHAMENTO DA CONSULTA:
 * 1. TABELAS UTILIZADAS:
 *    - "Relatorio_cadop": Contém os dados cadastrais das operadoras (razão social e registro ANS)
 *    - "4T2024": Armazena os dados financeiros do 4º trimestre de 2024
 * 
 * 2. FILTROS APLICADOS:
 *    - Considera apenas eventos/sinistros médico-hospitalares conhecidos
 *    - Inclui somente registros onde houve efetivo consumo (saldo inicial > saldo final)
 * 
 * 3. CÁLCULO REALIZADO:
 *    - Para cada operadora, soma a diferença entre saldo inicial e final (VL_SALDO_INICIAL - VL_SALDO_FINAL)
 *    - Resulta no valor total de despesas médico-hospitalares no período
 * 
 * 4. ORDENAÇÃO E LIMITE:
 *    - Resultados ordenados por valor total de despesas em ordem decrescente fazendo um top 10
 *    - Limite de 10 registros para identificar apenas as maiores despesas
 */


SELECT 
    relatorio.reg_ans, 
    relatorio.razao_social, 
    SUM(trimestre.VL_SALDO_INICIAL - trimestre.VL_SALDO_FINAL) AS total_despesa
FROM 
    "Relatorio_cadop" relatorio
JOIN 
    "4T2024" trimestre ON relatorio.reg_ans = trimestre.reg_ans
WHERE 
    trimestre.descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' and (trimestre.VL_SALDO_INICIAL > trimestre.VL_SALDO_FINAL)
GROUP BY 
    relatorio.reg_ans, relatorio.razao_social
ORDER BY 
    total_despesa DESC LIMIT 10;