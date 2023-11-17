SELECT 
    dp.produto,
    ROUND(AVG(CAST(d.quantidade AS DECIMAL(10,2))), 2) AS media_por_produto
FROM fatodetalhes_dadosmodelagem d
LEFT JOIN dim_produto dp ON d.produtoid = dp.produtoid
GROUP BY dp.produto
ORDER BY media_por_produto DESC;