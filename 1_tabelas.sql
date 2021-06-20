-- Database: vinicola_estudo

-- DROP DATABASE vinicola_estudo;
	
CREATE TABLE regiao(
    regiao_id 		    int PRIMARY KEY,
    nome_regiao		    varchar(100) NOT NULL,
    descricao_regiao	text
);

CREATE TABLE vinicola(
    vinicola_id		    smallint PRIMARY KEY,
    nome_vinicola		varchar(50) NOT NULL,
    descricao_vinicola	text,
    fone_vinicola		varchar(15),
    fax_vinicola		varchar(15),
    regiao_id		    smallint, 
    FOREIGN KEY(regiao_id) REFERENCES regiao(regiao_id) ON DELETE SET NULL
);


CREATE TABLE vinho(
    vinho_id 		    smallint PRIMARY KEY,
    nome_vinho 		    varchar(50) NOT NULL,
    tipo_vinho		    varchar(10) DEFAULT 'seco' NOT NULL,
    ano_vinho		    int DEFAULT 2000 CHECK (ano_vinho < 2020),
    descricao_vinho 	text,
    vinicola_id		    smallint NOT NULL,
    FOREIGN KEY (vinicola_id) REFERENCES vinicola(vinicola_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

-- Método 1 de inserção.
INSERT INTO regiao (regiao_id, nome_regiao, descricao_regiao) VALUES (04, 'Nordeste', 'Aracaju'); 		    

-- Método 2 de inserção
INSERT INTO regiao VALUES (01, 'Sao Roque', 'Regiao entre Sorocaba e Sao Paulo');
INSERT INTO regiao VALUES (02, 'Sul', 'Sul do Brasil');
INSERT INTO regiao VALUES (03, 'Norte', 'Amazonas');

INSERT INTO vinicola VALUES (01, 'Vinícola Palmeiras', 'Vinícola de Sao Roque', '(15)3388-5269', '(15)3388-5269', 01);
INSERT INTO vinicola VALUES (02, 'Vinícola Góes', 'Vinícola de Sao Roque', '(15)3223-3683', '(15)3223-3683', 01);
INSERT INTO vinicola VALUES (03, 'Vinícola Tche', 'Vinícola de Porto Alegre', '(51)3229-3783', '(15)9322-3683', 02);
INSERT INTO vinicola VALUES (04, 'Vinícola Kelly', 'Vinícola de Salto de Pirapora', '(15)3223-3683', '(15)3223-3683', 02);
INSERT INTO vinicola VALUES (05, 'Vinícola Bundao', 'Vinícola de Salto de Pirapora', '(15)3223-3683', '(15)3223-3683', 02);

INSERT INTO vinho VALUES (01, 'Palmeiras', 'Branco', 1997, 'Vinho da minha tia', 01);
INSERT INTO vinho VALUES (02, 'Góes', 'Suave', 2001, 'Vinho barato', 02);
INSERT INTO vinho VALUES (03, 'Fogo Vermelho', 'Pinot', 2010, 'Vinho envelhecido', 03);
INSERT INTO vinho VALUES (04, 'Fogo do Inferno', 'Merlot', 2015, 'Vinho tinto', 1);
INSERT INTO vinho VALUES (05, 'Fogão', 'Pinot', 2010, 'Vinho envelhecido', 2);
INSERT INTO vinho VALUES (06, 'Fogo Norte', 'Merlot', 2015, 'Vinho tinto', 2);
INSERT INTO vinho VALUES (07, 'Fogo Negro', 'Pinot', 2010, 'Vinho envelhecido', 04);
INSERT INTO vinho VALUES (08, 'Fogo Sol', 'Merlot', 2015, 'Vinho tinto', 4);
INSERT INTO vinho VALUES (09, 'Fogo Branco', 'Pinot', 2010, 'Vinho envelhecido', 05);
INSERT INTO vinho VALUES (10, 'Fogo Azul', 'Merlot', 2015, 'Vinho tinto', 5);
INSERT INTO vinho VALUES (11, 'Fogo Gelado', 'Pinot', 2010, 'Vinho envelhecido', 05);
INSERT INTO vinho VALUES (12, 'Fogo Verde', 'Merlot', 2015, 'Vinho tinto', 2);
INSERT INTO vinho VALUES (13, 'Fogo Vermelho', 'Pinot', 2010, 'Vinho envelhecido', 03);
INSERT INTO vinho VALUES (14, 'Fogo do Inferno', 'Merlot', 2015, 'Vinho tinto', 1);
INSERT INTO vinho VALUES (15, 'Fogão', 'Pinot', 2010, 'Vinho envelhecido', 2);
INSERT INTO vinho VALUES (16, 'Fogo Norte', 'Merlot', 2015, 'Vinho tinto', 2);
INSERT INTO vinho VALUES (17, 'Fogo Tche', 'Cabernet', 2019, 'Vinho barato', 03);
INSERT INTO vinho VALUES (18, 'Fogo Negro', 'Pinot', 2010, 'Vinho envelhecido', 03);
INSERT INTO vinho VALUES (19, 'Fogo Sul', 'Merlot', 2015, 'Vinho tinto', 1);
INSERT INTO vinho VALUES (20, 'Fogo Negro', 'Pinot', 2010, 'Vinho envelhecido', 04);
INSERT INTO vinho VALUES (21, 'Fogo Sol', 'Merlot', 2015, 'Vinho tinto', 4);
INSERT INTO vinho VALUES (22, 'Fogo Branco', 'Pinot', 2010, 'Vinho envelhecido', 05);
INSERT INTO vinho VALUES (23, 'Fogo Azul', 'Merlot', 2015, 'Vinho tinto', 5);
INSERT INTO vinho VALUES (24, 'Fogo Gelado', 'Pinot', 2010, 'Vinho envelhecido', 05);
INSERT INTO vinho VALUES (25, 'Fogo Verde', 'Merlot', 2015, 'Vinho tinto', 2);
INSERT INTO vinho VALUES (26, 'Fogo Norte', 'Merlot', 2015, 'Vinho tinto', 2);
INSERT INTO vinho VALUES (27, 'Fogo Negro', 'Pinot', 2010, 'Vinho envelhecido', 04);
INSERT INTO vinho VALUES (28, 'Fogo Sol', 'Merlot', 2015, 'Vinho tinto', 4);
INSERT INTO vinho VALUES (29, 'Fogo Branco', 'Pinot', 2010, 'Vinho envelhecido', 05);
INSERT INTO vinho VALUES (30, 'Fogo Azul', 'Merlot', 2015, 'Vinho tinto', 5);
INSERT INTO vinho VALUES (31, 'Fogo Gelado', 'Pinot', 2010, 'Vinho envelhecido', 05);