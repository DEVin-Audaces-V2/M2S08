USE LAB365;
GO

-- STORED PROCEDURES
CREATE PROCEDURE BuscaTodosHerois
AS
SELECT * FROM Heroi;

EXEC BuscaTodosHerois;

GO

CREATE PROCEDURE BuscaHeroiPorNivel
@nivel_desejado INT
AS
SELECT * FROM Heroi
WHERE nivel = @nivel_desejado;

EXEC BuscaHeroiPorNivel @nivel_desejado = 10;

GO

CREATE PROCEDURE ProcuraUsuarioPorNomeEModedas
	@nome_padrao VARCHAR(50),
	@minimo_moedas INT
AS
	SELECT * FROM Jogador
	WHERE nome LIKE @nome_padrao AND
	moedas >= @minimo_moedas;

GO

EXEC ProcuraUsuarioPorNomeEModedas @nome_padrao='Ava', @minimo_moedas=0;


-- VIEWS
GO

CREATE VIEW vwHeroiMaisExperiente
AS
	SELECT TOP 1
		j.nome AS nome_jogador,
		h.nome AS nome_heroi,
		h.classe,
		h.nivel
	FROM Jogador AS j
	INNER JOIN Heroi AS h
	ON j.id = h.jogador_id
	ORDER BY h.nivel DESC;

GO

SELECT * FROM vwHeroiMaisExperiente;

SELECT * FROM Heroi
WHERE classe = (SELECT classe FROM vwHeroiMaisExperiente);

-- EXPLAIN CALL
SELECT * FROM Heroi;
SELECT * FROM Heroi 
WHERE nivel > 10;

SELECT
	j.nome,
	h.nome
FROM Jogador AS j
INNER JOIN Heroi AS h
ON j.id = h.jogador_id;

-- VARIAVEIS
DECLARE @MinhaVariavel VARCHAR(100);
SET @MinhaVariavel = 'Olá mundo';
SELECT @MinhaVariavel;

DECLARE @NomeHeroi VARCHAR(50);
SELECT @NomeHeroi = nome
FROM Heroi
WHERE id = 1;

SELECT @NomeHeroi;

-- IF ELSE
DECLARE @Idade INT;
SET @Idade = 16;
IF @Idade >= 18
	PRINT 'Você pode tirar sua carteira!';
ELSE
	PRINT 'Você ainda é muito jovem!';

DECLARE @ClasseHeroi VARCHAR(50);
SET @ClasseHeroi = 'Paladino';
DECLARE @NumeroClasseHeroi INT;
SET @NumeroClasseHeroi = (SELECT COUNT(*) FROM Heroi WHERE classe = @ClasseHeroi);
IF @NumeroClasseHeroi > 0
BEGIN;
	PRINT 'Existem herois da classe selecionada';
	SELECT nome, classe FROM Heroi WHERE classe = @ClasseHeroi;
END;
ELSE
	PRINT 'Não existem herois da classe selecionada';

-- WHILE LOOP
DECLARE @Contador INT;
SET @Contador = 1;
WHILE (@Contador <= 5)
BEGIN;
	PRINT @Contador;
	SET @Contador = @Contador + 1;
END;

SELECT * FROM Jogador;


-- TRANSACTIONS

SELECT * INTO tTemp FROM Jogador;

BEGIN TRANSACTION;
DECLARE @JogadorPaganteId INT = 1;
DECLARE @JogadorRecebedorId INT = 2;
DECLARE @ValorTransferencia INT = 100;
DECLARE @JogadorPaganteMoedas INT;
SELECT @JogadorPaganteMoedas = 
	moedas FROM tTemp 
	WHERE id = @JogadorPaganteId;

IF (@JogadorPaganteMoedas > @ValorTransferencia)
BEGIN;
	UPDATE tTemp
	SET moedas = moedas - @ValorTransferencia
	WHERE id = @JogadorPaganteId;

	UPDATE tTemp
	SET moedas = moedas + @ValorTransferencia
	WHERE id = @JogadorRecebedorId;

	COMMIT TRANSACTION;
	PRINT 'Transferência realizada com sucesso';
END;
ELSE
BEGIN;
	ROLLBACK TRANSACTION;
	PRINT 'Transferência falhou por falta de fundos';
END;

SELECT * FROM tTemp;

-- TRIGGERS
DROP TABLE IF EXISTS temp_heroi_item;
DROP TABLE IF EXISTS temp_jogador;
DROP TABLE IF EXISTS temp_heroi;

SELECT * INTO temp_heroi_item FROM Heroi_Item;
SELECT * INTO temp_jogador FROM Jogador;
SELECT * INTO temp_heroi FROM Heroi;

GO;
CREATE OR ALTER TRIGGER CheckNivelMaximoHeroi
ON temp_heroi
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @NivelMaximo INT = 50;

	IF EXISTS(
		SELECT 1 FROM inserted WHERE nivel > @NivelMaximo
	)
	BEGIN
		RAISERROR('Nível do heroi não pode exceder o nivel maximo', 16, 1);
		ROLLBACK TRANSACTION;
	END
END;

INSERT INTO temp_heroi (jogador_id, nome, nivel)
VALUES
	(1, 'Invalido', 60);

SELECT * FROM temp_heroi;