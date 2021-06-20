	-- Limitado a 5 o retorno (ordem de acordo com o armazenamento que está no SGBD)
    SELECT * FROM vinho LIMIT 5;
    
    -- Dizemos a ordem antes de imprimirmos.
    SELECT * FROM vinho ORDER BY vinho.vinho_id LIMIT 5;

    -- Dizemos a partir de qual registro queremos começar a selecionar
    SELECT * FROM vinho ORDER BY vinho.vinho_id LIMIT 5 OFFSET 0;
    -- Podemos ainda escrever omitindo o OFFSET (Observe que nesse caso o offset vem primeiro)
    SELECT * FROM vinho ORDER BY vinho.vinho_id LIMIT 0, 5; -- Não suportado no postgress.

    -- Deletando um registro da tabela.
    DELETE FROM vinho WHERE vinho_id = 28;
