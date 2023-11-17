-- 8 MÉDIA DE COMPRAS POR CLIENTE

SELECT
    AVG(total_compras) AS "media_compras_por_cliente"
FROM (
    SELECT
        fc.clienteid,
        COUNT(DISTINCT fc.cupomid) AS total_compras
    FROM fatocabecalho_dadosmodelagem fc
    GROUP BY fc.clienteid
) AS compras_por_cliente;