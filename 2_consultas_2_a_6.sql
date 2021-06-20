-- 1.Seleciona todos os vinhos da região SUL
SELECT vi.nome_vinho, re.nome_regiao FROM vinho vi, vinicola vl, regiao re 
	WHERE re.nome_regiao LIKE 'Sul' AND re.regiao_id = vl.regiao_id AND vl.vinicola_id = vi.vinicola_id;
-- Usando o INNER JOIN para obter o mesmo resultado!
SELECT vi.nome_vinho, re.nome_regiao FROM 
	regiao re INNER JOIN vinicola vl ON(re.regiao_id = vl.regiao_id) 
		INNER JOIN vinho vi ON(vl.vinicola_id = vi.vinicola_id)
		WHERE re.nome_regiao LIKE 'Sul';

-- 2.Selecione todos os vinhos na faixa de preço [100,500]
    -- a.Antes, altere a tabela de vinhos para acrescentar o atributo preço do vinho
    ALTER TABLE vinho ADD COLUMN preco float DEFAULT floor((random()*1000));
SELECT nome_vinho as nome, preco FROM vinho vi WHERE vi.preco BETWEEN 100 AND 500;

-- 3.Seleciona todas as vinícolas cujo nome termina com ‘s’
SELECT nome_vinicola as nome FROM vinicola vl WHERE vl.nome_vinicola LIKE '%s';

-- 4.Aumenta o preço dos vinhos da região SUL em 10%
    -- Atualizando os dados. 
UPDATE vinho vi SET preco = floor(preco*1.1) FROM vinicola vl, regiao re 
WHERE re.nome_regiao LIKE 'Sul' AND re.regiao_id = vl.regiao_id AND vl.vinicola_id = vi.vinicola_id; 

	UPDATE vinho vi_s SET preco = floor(vi_s.preco*1.1) FROM regiao re INNER JOIN vinicola vl
    	ON(re.regiao_id = vl.regiao_id) INNER JOIN vinho vi ON(vl.vinicola_id = vi.vinicola_id)
        WHERE re.nome_regiao LIKE 'Sul';

    -- Apenas descrevendo.
    SELECT floor(vi.preco*1.1) FROM vinho vi, vinicola vl, regiao re 
        WHERE re.nome_regiao LIKE 'Sul' AND re.regiao_id = vl.regiao_id AND vl.vinicola_id = vi.vinicola_id;
