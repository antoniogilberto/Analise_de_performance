
-- 1) VALOR TOTAL DAS VENDAS E DOS FRETES POR PRODUTO E ORDEM DE VENDA.

    -- OBS: foi levado em consideração (total_vendas) para uma ordenação 
-- Seleciona o nome do produto e as somas do valor das vendas e valor do frete para cada produto
SELECT
	p.produto,
    SUM(d.valor) AS total_vendas,
    SUM(c.valorfrete) AS total_frete
FROM fatodetalhes_dadosmodelagem d
-- União das tabelas a esqueda pelas colunas (cupomid)
LEFT JOIN fatocabecalho_dadosmodelagem c ON c.cupomid = d.cupomid
    -- União das tabelas a esqueda pelas colunas (produtoid)
LEFT JOIN dim_produto p ON d.produtoid = p.produtoid
-- Agrupa os resultados pelo nome do produto
GROUP BY p.produto
-- Ordena os resultados em ordem decrescente
ORDER BY total_vendas DESC;


-- 2) VALOR DE VENDA POR TIPO DE PRODUTO
-- OBS: Na base de dados fornecida não tem a coluna "tipo de produto",
-- como referência foi usado a coluna "categoria"
-- A query calcula o total de vendas por categoria

SELECT 
    ca.categoria,
    SUM(d.valor) AS total_vendas
FROM fatodetalhes_dadosmodelagem d
-- Junta a tabela de detalhes com a tabela de produtos usando produtoid
LEFT JOIN dim_produto p ON d.produtoid = p.produtoid
-- Junta a tabela de produtos com a tabela de categorias usando categoriaid
LEFT JOIN dim_categoria ca ON ca.categoriaid = p.categoriaid
-- Agrupa os resultados pelo campo de categoria
GROUP BY ca.categoria
-- Ordena os resultados em ordem alfabética de categoria
ORDER BY ca.categoria;



-- 3) QUANTIDADE E VALOR DAS VENDAS POR DIA, MÊS E ANO.

-- Seleciona o dia, mês, ano, a quantidade de vendas e o valor bruto das vendas
SELECT 
    day(str_to_date(C.data, '%d/%m/%Y')) AS dia,
    month(str_to_date(C.data, '%d/%m/%Y')) AS mes,
    year(str_to_date(C.data, '%d/%m/%Y')) AS ano,
-- realiza uma contagem e uma soma das colunas (cupom e valor)
    count(C.cupomid) AS qtd_de_vendas,
    sum(D.valor) AS valor_bruto
FROM refera.fatocabecalho_dadosmodelagem C
-- Realiza um LEFT JOIN com a tabela fatodetalhes_dadosmodelagem usando a chave cupomid
LEFT JOIN
	refera.fatodetalhes_dadosmodelagem D ON C.cupomid = D.cupomid
-- Agrupa os resultados por ano, mês e dia para consolidar informações diárias
GROUP BY ano, mes, dia
-- Ordena o resultado pela data para facilitar a interpretação
ORDER BY ano, mes, dia;



-- 4) LUCRO DOS MESES 

-- Esta consulta calcula o lucro bruto mensal com base nas tabelas fornecidas.
SELECT 
    -- Extrai o mês da data (no formato '21/11/2016') usando a função STR_TO_DATE.
    MONTH(STR_TO_DATE(data, '%d/%m/%Y')) AS mes,
    -- Calcula o lucro bruto mensal somando os valores líquidos da tabela de detalhes.
    SUM(valorliquido) AS lucro_bruto
FROM 
    -- Tabela de detalhes é referenciada com o apelido 'd'.
    fatodetalhes_dadosmodelagem d
-- Realiza um LEFT JOIN com a tabela de cabeçalho usando a coluna 'cupomid'.
LEFT JOIN 
    fatocabecalho_dadosmodelagem c ON d.cupomid = c.cupomid
-- Agrupa os resultados pelo mês extraído da data e calcula a soma do valor líquido para cada mês.
GROUP BY mes
-- Ordena os resultados pelo mês.
ORDER BY mes;


-- 5) VENDA POR PRODUTO (QTDs)

-- Seleciona o nome do produto e a contagem de vendas para cada produto
SELECT 
    p.produto,
    COUNT(c.cupomid) AS "qtd_vendas"
FROM fatocabecalho_dadosmodelagem c
-- Faz um LEFT JOIN com a tabela de detalhes usando a chave cupomid
LEFT JOIN fatodetalhes_dadosmodelagem d ON c.cupomid = d.cupomid
-- Faz outro LEFT JOIN com a tabela de dimensão de produtos usando a chave produtoid
LEFT JOIN dim_produto p ON d.produtoid = p.produtoid
-- Agrupa os resultados pelo nome do produto
GROUP BY p.produto
-- Ordena os resultados pela contagem de vendas em ordem decrescente
ORDER BY COUNT(c.cupomid) DESC;



-- 6) VENDA POR CLIENTE, CIDADE E (ESTADO) / REGIÃO 

-- OBS: foi substituido a localidade Estado po Região
-- Seleciona as colunas cliente, cidade e região da tabela dim_cliente
-- e a contagem do número de cupons (vendas) da tabela fatocabecalho_dadosmodelagem
SELECT
    dc.cliente,
    dc.cidade,
    dc.regiao,
    COUNT(c.cupomid) AS "qtd_vendas"
-- Faz um LEFT JOIN para incluir todos os clientes da tabela dim_cliente
-- mesmo que não haja correspondência na tabela fatocabecalho_dadosmodelagem
FROM fatocabecalho_dadosmodelagem c
LEFT JOIN dim_cliente dc ON dc.clienteid = c.clienteid
-- Agrupa os resultados pelo nome do cliente, cidade e região
GROUP BY dc.cliente, dc.cidade, dc.Regiao
-- Ordena os resultados pela contagem de cupons (vendas) em ordem decrescente
ORDER BY COUNT(c.cupomid) DESC;



-- 7) MÉDIA DE PRODUTOS VENDIDOS

-- Seleciona o nome do produto e a média da quantidade de produtos vendidos
SELECT 
    dp.produto,
    -- Calcula a média da quantidade de produtos vendidos, arredondando para duas casas decimais
    ROUND(AVG(CAST(d.quantidade AS DECIMAL(10,2))), 2) AS media_por_produto
-- Define a tabela principal como fatodetalhes_dadosmodelagem com alias 'd'
FROM fatodetalhes_dadosmodelagem d
-- Faz um LEFT JOIN com a tabela de dimensão de produtos usando a chave produtoid
LEFT JOIN dim_produto dp ON d.produtoid = dp.produtoid
-- Agrupa os resultados pelo nome do produto
GROUP BY dp.produto
-- Ordena os resultados pela média de produtos vendidos em ordem decrescente
ORDER BY media_por_produto DESC;



-- 8) MÉDIA DE COMPRAS POR CLIENTE

SELECT
    AVG(total_compras) AS "media_compras_por_cliente"
FROM (
    -- Subconsulta que calcula o número total de compras por cliente
    SELECT
        fc.clienteid,
        COUNT(DISTINCT fc.cupomid) AS total_compras
    FROM fatocabecalho_dadosmodelagem fc
    -- Agrupa os resultados pelo clienteid
    GROUP BY
        fc.clienteid
) AS compras_por_cliente;
