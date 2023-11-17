-- 4) LUCRO DOS MESES 

-- Esta consulta calcula o lucro bruto mensal com base nas tabelas fornecidas.
SELECT 
    MONTH(STR_TO_DATE(data, '%d/%m/%Y')) AS mes,
    SUM(valorliquido) AS lucro_bruto
FROM fatodetalhes_dadosmodelagem d
LEFT JOIN fatocabecalho_dadosmodelagem c ON d.cupomid = c.cupomid
GROUP BY mes
ORDER BY mes;