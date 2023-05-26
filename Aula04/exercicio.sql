USE LAB365;
GO

-- EX1
CREATE PROCEDURE BuscaTotalMoedas
	@jogador_id INT
AS
	SELECT moedas FROM Jogador
	WHERE id = @jogador_id;

GO

EXEC BuscaTotalMoedas @jogador_id = 3;

GO

-- EX2

CREATE OR ALTER VIEW vwInfoHeroiNivelDez
AS
	SELECT
		j.nome AS nome_jogador,
		h.nome AS nome_heroi,
		nivel
	FROM Jogador AS j
	INNER JOIN Heroi AS h
	ON j.id = h.jogador_id
	WHERE h.nivel > 10;

GO

SELECT * FROM vwInfoHeroiNivelDez;

GO

-- EX3
CREATE VIEW vwHeroiItemQntd
AS
	SELECT
		h.nome AS nome_heroi,
		i.nome AS nome_item,
		hi.quantidade
	FROM Heroi AS h
	INNER JOIN Heroi_Item AS hi
	ON h.id = hi.heroi_id
	INNER JOIN Item AS i
	ON i.id = hi.item_id;

GO

SELECT * FROM vwHeroiItemQntd;

GO

-- EX4
CREATE OR ALTER PROCEDURE BuscaNrHeroisMissao
	@id_missao INT
AS
	SELECT
		COUNT(h.id)
	FROM Heroi AS h
	INNER JOIN Heroi_Missao AS hi
	ON h.id = hi.heroi_id
	INNER JOIN Missao AS m
	ON m.id = hi.missao_id
	WHERE hi.progresso = 1
	GROUP BY m.id
	HAVING m.id = @id_missao;


GO

EXEC BuscaNrHeroisMissao @id_missao = 4;

-- EX5
GO
CREATE PROCEDURE UpLevelHeroi
	@heroi_id INT
AS
BEGIN
	UPDATE Heroi
	SET nivel = nivel + 1
	WHERE id = @heroi_id
END;

SELECT * FROM Heroi WHERE id = 1;

EXEC UpLevelHeroi @heroi_id = 1;