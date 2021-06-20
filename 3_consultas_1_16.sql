-- 1. Liste a quantidade de vinhos que tem em cada vinícola
SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinho_id) AS quant_vinho FROM vinho vi, vinicola vl
	WHERE vi.vinicola_id = vl.vinicola_id
	GROUP BY vl.vinicola_id;
-- O mesmo, porém com INNER JOIN.
SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinho_id) AS quant_vinho 
	FROM vinho vi INNER JOIN vinicola vl ON(vi.vinicola_id = vl.vinicola_id)
	GROUP BY vl.vinicola_id;
-- O mesmo porém apenas com a tabela vinho. (melhor)
SELECT vi.vinicola_id, COUNT(vi.vinho_id) AS quant_vinho FROM vinho vi
	GROUP BY vi.vinicola_id
	ORDER BY vi.vinicola_id;

-- 2. Liste a quantidade de vinhos que tem em cada vinícola da região SUL
SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinicola_id) AS quant_vinho FROM vinho vi, vinicola vl, regiao re
	WHERE vi.vinicola_id = vl.vinicola_id AND vl.regiao_id = re.regiao_id AND re.nome_regiao LIKE 'Sul'
	GROUP BY vl.vinicola_id;
-- O mesmo porém com INNER JOIN.
SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinicola_id) AS quant_vinho FROM 
vinho vi INNER JOIN vinicola vl ON(vi.vinicola_id = vl.vinicola_id) INNER JOIN regiao re ON(re.regiao_id = vl.regiao_id)
WHERE re.nome_regiao LIKE 'Sul'
GROUP BY vl.vinicola_id;

-- 3. Liste a quantidade de vinhos que tem em cada vinícola da região SUL para as vinícolas que tem mais de 5 vinho (>5)
SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinicola_id) AS quant_vinho FROM vinho vi, vinicola vl, regiao re
	WHERE vi.vinicola_id = vl.vinicola_id AND vl.regiao_id = re.regiao_id AND re.nome_regiao LIKE 'Sul'
	GROUP BY vl.vinicola_id
	HAVING COUNT(*) > 5;

SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinicola_id) AS quant_vinho FROM 
	vinho vi INNER JOIN vinicola vl ON(vi.vinicola_id = vl.vinicola_id) INNER JOIN regiao re ON(re.regiao_id = vl.regiao_id)
	WHERE re.nome_regiao LIKE 'Sul'
	GROUP BY vl.vinicola_id
	HAVING COUNT(*) > 5;

-- 4. Liste as vinícolas que não tem cadastro de vinhos
SELECT * FROM vinicola vl2 
	WHERE vl2.vinicola_id NOT IN (SELECT vl.vinicola_id FROM vinho vi, vinicola vl, regiao re
									WHERE vi.vinicola_id = vl.vinicola_id
									GROUP BY vl.vinicola_id);

-- O mesmo resultado, porém usando LEFT JOIN.
SELECT vl.vinicola_id, vl.nome_vinicola, vl.descricao_vinicola, vl.fone_vinicola, vl.fax_vinicola, vl.regiao_id 
FROM vinicola vl LEFT JOIN vinho vi ON(vl.vinicola_id = vi.vinicola_id) WHERE vi.vinho_id IS NULL;

-- 5. Liste a(s) região com mais vinícolas
SELECT * FROM regiao re 
		WHERE re.regiao_id IN 
			(SELECT vl.regiao_id FROM vinicola vl
			GROUP BY vl.regiao_id
			HAVING COUNT(vl.regiao_id) >= ALL (SELECT COUNT(vl1.regiao_id) FROM vinicola vl1 GROUP BY vl1.regiao_id));

-- O mesmo resultado, porém usando INNER JOIN e MAX
SELECT MAX(aux.quantidade_vinicolas)
FROM
(SELECT re.regiao_id, re.nome_regiao, re.descricao_regiao, COUNT(vl.regiao_id) AS quantidade_vinicolas
	FROM regiao re INNER JOIN vinicola vl ON (re.regiao_id = vl.regiao_id)
	GROUP BY re.regiao_id) AS aux;

-- O mesmo resultado, porém usando INNER JOIN
SELECT re, COUNT(vl.regiao_id) FROM regiao re INNER JOIN vinicola vl ON (re.regiao_id = vl.regiao_id) 
 	GROUP BY re.regiao_id
	HAVING COUNT(vl.regiao_id) >= ALL
(SELECT COUNT(vl.regiao_id) FROM regiao re INNER JOIN vinicola vl ON (re.regiao_id = vl.regiao_id) 
 GROUP BY re.regiao_id);


-- 6. Qual a média de vinhos por vinícolas?
SELECT vl.vinicola_id, vl.nome_vinicola , AVG(vi.vinicola_id) AS quant_vinhos FROM vinicola vl, vinho vi
	WHERE vl.vinicola_id = vi.vinicola_id
	GROUP BY vl.vinicola_id;
SELECT AVG(tab.quant_vinhos) AS media FROM 
	(SELECT COUNT(vi.vinicola_id) AS quant_vinhos FROM vinicola vl, vinho vi
		WHERE vl.vinicola_id = vi.vinicola_id
		GROUP BY vl.vinicola_id) AS tab;
	-- Correto, os de cima não estão!
	SELECT AVG(aux.quant_vinho) FROM 
		(SELECT vi.vinicola_id, COUNT(vi.vinho_id) AS quant_vinho FROM vinho vi 
			GROUP BY vi.vinicola_id) AS aux;

-- 7. Liste as regiões que não têm vinícolas
SELECT * FROM regiao re 
	WHERE re.regiao_id NOT IN (SELECT re1.regiao_id FROM vinicola vl, regiao re1
									WHERE vl.regiao_id = re1.regiao_id
									GROUP BY re1.regiao_id);

-- O mesmo resultado, porém usando o LEFT JOIN.	
SELECT * FROM regiao re LEFT JOIN vinicola vl ON (re.regiao_id = vl.regiao_id)
	WHERE vl.regiao_id IS NULL;

-- 8. Liste o vinho de maior preço
SELECT * FROM vinho vi 
	WHERE vi.preco >= ALL (SELECT vi1.preco FROM vinho vi1)

-- 9. Liste os vinhos do tipo seco ou do ano 2000
SELECT * FROM vinho vi
	WHERE vi.tipo_vinho LIKE 'Seco' OR vi.ano_vinho = 2000;

-- 10. Liste os vinhos de tipo seco e do ano 2000
SELECT * FROM vinho vi
	WHERE vi.tipo_vinho LIKE 'Seco' AND vi.ano_vinho = 2000;

-- 11. Liste os vinhos de tipo seco que não são do ano 2000
SELECT * FROM vinho vi
	WHERE vi.tipo_vinho LIKE 'Seco' AND vi.ano_vinho != 2000;

-- 12. Refaça as consultas 9, 10, 11 com operadores de conjuntos (UNION, INTERSECT, EXCEPT)
    -- 12.9. Liste os vinhos do tipo seco ou do ano 2000
	SELECT * FROM vinho vi
		WHERE vi.tipo_vinho LIKE 'Seco' 
		UNION 
	SELECT * FROM vinho vi
		WHERE vi.ano_vinho = 2000;

    -- 12.10. Liste os vinhos de tipo seco e do ano 2000
	SELECT * FROM vinho vi
		WHERE vi.tipo_vinho LIKE 'Seco' 
		INTERSECT 
	SELECT * FROM vinho vi
		WHERE vi.ano_vinho = 2000;

    -- 12.11. Liste os vinhos de tipo seco que não são do ano 2000
	SELECT * FROM vinho vi
		WHERE vi.tipo_vinho LIKE 'Seco' 
		EXCEPT
	SELECT * FROM vinho vi
		WHERE vi.ano_vinho = 2000;

-- 13.Acrescente um atributo regiao na tabela de vinhos, que referencie a tabela de regiões, e responda:
    -- recupere os vinhos que sejam da mesma região da sua vinícola
ALTER TABLE vinho ADD COLUMN regiao_id smallint;	
ALTER TABLE vinho ADD CONSTRAINT regiao_id FOREIGN KEY (regiao_id) REFERENCES regiao(regiao_id);
UPDATE vinho SET regiao_id = vl.regiao_id FROM vinicola vl 
	WHERE vl.vinicola_id = vinho.vinicola_id;
	
SELECT * FROM vinho vi, vinicola vl
	WHERE vi.regiao_id = vl.regiao_id AND vi.vinicola_id = vl.vinicola_id;

-- O mesmo resultado usando INNER JOIN.
SELECT * FROM vinho vi INNER JOIN vinicola vl 
	ON(vi.regiao_id = vl.regiao_id AND vi.vinicola_id = vl.vinicola_id);

-- 14.Recupere a vinícola que tem o maior preço médio de vinhos
SELECT MAX(aux.preco_medio) FROM 
	(SELECT vi.vinicola_id, AVG(vi.preco) AS preco_medio FROM vinho vi 
	 	GROUP BY vi.vinicola_id) AS aux;
	

-- 15.Recupere a vinícola que tem apenas um vinho cadastrado. Responda usando:
    -- a cláusula UNIQUE
    -- Agregação
INSERT INTO vinicola VALUES (07, 'Vinícola Teste', 'Vinícola de Salto de Pirapora', '(15)3223-3683', '(15)3223-3683', 02);
INSERT INTO vinicola VALUES (08, 'Vinícola Projeto', 'Vinícola de Salto de Pirapora', '(15)3223-3683', '(15)3223-3683', 02);
INSERT INTO vinho VALUES (28, 'Fogo Do Inferno', 'Pinot', 2010, 'Vinho envelhecido', 07,2);

SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinho_id) AS quant_vinho FROM vinho vi, vinicola vl
	WHERE vl.vinicola_id = vi.vinicola_id
	GROUP BY vl.vinicola_id
	HAVING COUNT(*) = 3;

-- O mesmo usando INNER JOIN.
SELECT vl.vinicola_id, vl.nome_vinicola, COUNT(vi.vinho_id) AS quant_vinho 
	FROM vinho vi INNER JOIN vinicola vl ON(vi.vinicola_id = vl.vinicola_id)
	GROUP BY vl.vinicola_id
	HAVING COUNT(*) = 3;

-- 16.Recupere os vinhos que tenham preços maiores que ao menos um vinho da região SUL
SELECT vi.vinho_id, vi.nome_vinho, re.nome_regiao FROM vinho vi, regiao re
WHERE re.regiao_id = vi.regiao_id AND re.nome_regiao NOT LIKE 'Sul' 
	AND vi.preco > SOME (SELECT vi.preco FROM regiao re, vinho vi 
						 WHERE re.regiao_id = vi.regiao_id AND re.nome_regiao LIKE 'Sul')
						 ORDER BY vi.vinho_id;

-- O mesmo usando INNER JOIN.
SELECT vi.vinho_id, vi.nome_vinho, re.nome_regiao FROM vinho vi INNER JOIN regiao re
	ON(re.regiao_id = vi.regiao_id)
	WHERE re.nome_regiao NOT LIKE 'Sul' 
	AND vi.preco > SOME (SELECT vi.preco FROM regiao re INNER JOIN vinho vi
						ON(re.regiao_id = vi.regiao_id)
						WHERE re.nome_Regiao LIKE 'Sul')
						ORDER BY vi.vinho_id;

-- Correlatas

-- Vinhos com o maior preço da vinicola
SELECT vi.vinicola_id, vi.nome_vinho, vi.preco 
FROM vinho vi WHERE preco = (SELECT MAX(vi2.preco) FROM vinho vi2
								WHERE vi.vinicola_id = vi2.vinicola_id);
	
--Selecionando todos os vinhos que tem preço igual 897 usando correlatas
SELECT nome_vinho, preco FROM vinho vi
WHERE EXISTS (SELECT preco FROM vinho WHERE vi.preco = 897)