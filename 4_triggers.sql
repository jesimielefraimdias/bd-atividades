---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION conta_vinhos(int)
RETURNS bigint AS $$
	select count(vinho_id) as cont from vinho where vinicola_id = $1;
$$ LANGUAGE SQL;
---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION conta_vinhos_plpsql(id int)
RETURNS bigint AS $$
DECLARE
	cont int;
BEGIN
	select count(vinho_id) 
		into cont
		from vinho
		where vinicola_id = id;
	RETURN cont;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------
DROP FUNCTION MyFunction_updIdade()
CREATE OR REPLACE FUNCTION MyFunction_updIdade()
RETURNS trigger AS $$
BEGIN
	IF(TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
		IF(NEW.ano_vinho IS NOT NULL) THEN
			NEW.idade_vinho = extract(YEAR FROM NOW()) - NEW.ano_vinho;
		end if;
	end if;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER calcula_idade ON vinho;
CREATE TRIGGER calcula_idade
	BEFORE INSERT or UPDATE ON vinho
	FOR EACH ROW EXECUTE PROCEDURE MyFunction_updIdade();
----------------------------------------------------------------------------
SELECT * FROM conta_vinhos_plpsql(3);
SELECT conta_vinhos_plpsql(3);