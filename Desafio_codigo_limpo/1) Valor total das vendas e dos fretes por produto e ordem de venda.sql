-- 1) VALOR TOTAL DAS VENDAS E DOS FRETES POR PRODUTO E ORDEM DE VENDA.
-- OBS: foi levado em consideração (total_vendas) para uma ordenação 

SELECT
	p.produto,
    SUM(d.valor) AS total_vendas,
    SUM(c.valorfrete) AS total_frete
FROM fatodetalhes_dadosmodelagem d
LEFT JOIN fatocabecalho_dadosmodelagem c ON c.cupomid = d.cupomid
LEFT JOIN dim_produto p ON d.produtoid = p.produtoid
GROUP BY p.produto
ORDER BY total_vendas DESC;