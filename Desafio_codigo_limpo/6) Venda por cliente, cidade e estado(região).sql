-- 6 VENDA POR CLIENTE, CIDADE E (ESTADO) / REGIÃO 
-- OBS: foi substituido a localidade Estado po Região

SELECT
    dc.cliente,
    dc.cidade,
    dc.regiao,
    COUNT(c.cupomid) AS "qtd_vendas"
FROM fatocabecalho_dadosmodelagem c
LEFT JOIN dim_cliente dc ON dc.clienteid = c.clienteid
GROUP BY dc.cliente, dc.cidade, dc.Regiao
ORDER BY COUNT(c.cupomid) DESC;