USE LAB365;
GO

-- SELECT
SELECT * FROM Jogador;
SELECT nome, moedas FROM Jogador;

-- WHERE
SELECT * FROM Heroi
WHERE nivel > 10;

SELECT nome, nivel, classe FROM Heroi
WHERE classe = 'Paladino' AND nivel < 10;

-- LIKE
SELECT * FROM Jogador
WHERE nome LIKE 'a%';

SELECT * FROM Heroi
WHERE nome LIKE '%o';

-- SELECT DISTINCT
SELECT classe FROM Heroi;
SELECT DISTINCT classe FROM Heroi;
SELECT DISTINCT classe, nivel FROM Heroi;
SELECT DISTINCT nome, classe, nivel FROM Heroi;

-- ORDER BY
SELECT nome FROM Item;
SELECT nome FROM Item ORDER BY nome ASC;
SELECT nome, tipo, valor FROM Item ORDER BY valor DESC;

-- ALIAS
SELECT nome AS nome_da_missao FROM Missao;
SELECT 
	nome AS 'Nome da missão', 
	(nivel_requerido + 2) AS 'Nível recomendado' 
	FROM Missao;

-- FUNÇÕES DE AGREGAÇÃO
SELECT COUNT(*) AS 'Número de jogadores' FROM Jogador;
SELECT SUM(recompensa_moedas) AS 'Soma de moedas de todas as missões' FROM Missao;
SELECT AVG(nivel) AS 'Nível médio dos herois' FROM Heroi;
SELECT MIN(moedas) AS 'Número de moedas do jogador com menos moedas' FROM Jogador;
SELECT MAX(data_finalizacao) AS 'Data da última missão finalizada' FROM Heroi_Missao;

-- TOP
SELECT TOP 5 nome, nivel, classe FROM Heroi ORDER BY nivel DESC;
SELECT TOP 1 nome AS 'Item mais caro' FROM Item ORDER BY valor DESC;

-- GROUP BY
SELECT COUNT(id) AS 'Número de herois', classe 
FROM Heroi 
GROUP BY classe
ORDER BY COUNT(id) DESC;

SELECT 
	COUNT(id) AS 'Número de herois', 
	AVG(nivel) AS 'Média de nível',
	classe 
FROM Heroi 
GROUP BY classe
ORDER BY COUNT(id) DESC;

SELECT 
	MAX(valor) AS 'Máximo valor',
	MIN(valor) AS 'Mínimo valor',
	MAX(nivel_requerido) AS 'Nível requerido máximo',
	MIN(nivel_requerido) AS 'Nível requerido mínimo',
	tipo
FROM Item
GROUP BY tipo;

-- HAVING
SELECT 
	recompensa_moedas, 
	nivel_requerido 
FROM Missao 
ORDER BY nivel_requerido ASC;

SELECT 
	SUM (recompensa_moedas) AS 'Recompensa total',
	nivel_requerido	
FROM Missao
GROUP BY nivel_requerido;

SELECT 
	SUM (recompensa_moedas) AS 'Recompensa total',
	nivel_requerido	
FROM Missao
GROUP BY nivel_requerido
HAVING SUM(recompensa_moedas) > 500;

SELECT 
	SUM (recompensa_moedas) AS 'Recompensa total',
	nivel_requerido	
FROM Missao
WHERE recompensa_moedas < 600 -- Recomensas individuais
GROUP BY nivel_requerido
HAVING SUM(recompensa_moedas) > 500;