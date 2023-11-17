SELECT 
    DAY(str_to_date(C.data, '%d/%m/%Y')) AS dia,
    MONTH(str_to_date(C.data, '%d/%m/%Y')) AS mes,
    YEAR(str_to_date(C.data, '%d/%m/%Y')) AS ano,
    COUNT(C.cupomid) AS qtd_de_vendas,
    SUM(D.valor) AS valor_bruto
FROM refera.fatocabecalho_dadosmodelagem C
LEFT JOIN
	refera.fatodetalhes_dadosmodelagem D ON C.cupomid = D.cupomid
GROUP BY ano, mes, dia
ORDER BY ano, mes, dia;