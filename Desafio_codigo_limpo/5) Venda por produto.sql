-- 5 VENDA POR PRODUTO (QTDs)

SELECT 
    p.produto,
    COUNT(c.cupomid) AS "qtd_vendas"
FROM fatocabecalho_dadosmodelagem c
LEFT JOIN fatodetalhes_dadosmodelagem d ON c.cupomid = d.cupomid
LEFT JOIN dim_produto p ON d.produtoid = p.﻿produtoid
GROUP BY p.produto
ORDER BY COUNT(c.cupomid) DESC;
