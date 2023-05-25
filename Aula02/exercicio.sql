USE LAB365;
GO

-- EX1
SELECT * FROM Heroi WHERE nivel >= 10;

-- EX2
SELECT nome FROM Heroi WHERE classe = 'Mago' AND nome LIKE '_u%';

-- EX3
SELECT nome, moedas FROM Jogador ORDER BY moedas DESC;

-- EX4
SELECT
    nome AS 'Nome do jogador',
    (moedas * 0.35) AS 'Dinheiro gasto (R$)'
FROM Jogador

-- BÔNUS: Total de dinheiro arrecadado
SELECT SUM(dinheiro) AS 'Total de dinheiro arrecadado (R$)'
FROM (
    SELECT (moedas * 0.35) AS dinheiro
    FROM Jogador
) AS dinheiro_tabela;

-- EX5
SELECT COUNT(DISTINCT classe) FROM Heroi;

SELECT COUNT(*)
FROM (
    SELECT classe
    FROM Heroi
    GROUP BY classe
) AS classes;








-- EX6
SELECT classe, MIN(nivel) AS 'Nível mínimo'
FROM Heroi
GROUP BY classe;

-- EX7
SELECT 
	AVG(valor) AS 'Média de preço', 
	tipo 
FROM Item
GROUP BY tipo
HAVING COUNT(id) >= 3;

-- EX8
SELECT SUM(recompensa_moedas), nivel_requerido
FROM Missao
WHERE nome LIKE '%o'
GROUP BY nivel_requerido;

-- EX9
SELECT COUNT(*) FROM Heroi_Missao
GROUP BY progresso
HAVING progresso = 1;

--EX10
SELECT TOP 1 classe 
FROM Heroi
GROUP BY classe
ORDER BY COUNT(id) DESC;