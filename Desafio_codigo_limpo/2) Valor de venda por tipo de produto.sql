-- 2) VALOR DE VENDA POR TIPO DE PRODUTO
-- OBS: Na base de dados fornecida não tem a coluna "tipo de produto",
-- como referência foi usado a coluna "categoria"

SELECT 
    ca.categoria,
	SUM(d.valor) AS total_vendas
FROM fatodetalhes_dadosmodelagem d
LEFT JOIN dim_produto p ON d.produtoid = p.produtoid
LEFT JOIN dim_categoria ca ON ca.categoria = p.categoriaid
GROUP BY ca.categoria
ORDER BY ca.categoria;