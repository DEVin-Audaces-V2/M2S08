USE LAB365;
GO

-- INNER JOIN
SELECT Jogador.nome, Heroi.nome
FROM Jogador
INNER JOIN Heroi
ON Jogador.id = Heroi.jogador_id;

SELECT Heroi.nome, Missao.nome
FROM Heroi
INNER JOIN Heroi_Missao AS hm
ON Heroi.id = hm.heroi_id
INNER JOIN Missao
ON Missao.id = hm.missao_id;

SELECT h.nome, i.nome, i.valor
FROM Heroi AS h
INNER JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
INNER JOIN Item AS i
ON i.id = hi.item_id
WHERE i.valor > 100;

SELECT 
	h.nome, 
	COUNT(m.nome) AS 'Número de missões'
FROM Heroi AS h
INNER JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
INNER JOIN Missao AS m
ON m.id = hm.missao_id
GROUP BY h.nome;

-- LEFT JOIN
SELECT Jogador.nome, Heroi.nome
FROM Jogador
LEFT JOIN Heroi
ON Jogador.id = Heroi.jogador_id;

SELECT Heroi.nome, Missao.nome
FROM Heroi
LEFT JOIN Heroi_Missao AS hm
ON Heroi.id = hm.heroi_id
LEFT JOIN Missao
ON Missao.id = hm.missao_id;

SELECT 
	h.nome, 
	COUNT(m.nome) AS 'Número de missões'
FROM Heroi AS h
LEFT JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
LEFT JOIN Missao AS m
ON m.id = hm.missao_id
GROUP BY h.nome
ORDER BY COUNT(m.nome) DESC;

-- RIGHT JOIN
SELECT h.nome, m.nome
FROM Heroi AS h
RIGHT JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
RIGHT JOIN Missao AS m
ON m.id = hm.missao_id;

SELECT h.nome, i.nome, i.valor
FROM Heroi AS h
RIGHT JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
RIGHT JOIN Item AS i
ON i.id = hi.item_id
WHERE i.valor > 100;

-- OUTER JOIN
SELECT h.nome, m.nome
FROM Heroi AS h
FULL OUTER JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
FULL OUTER JOIN Missao AS m
ON m.id = hm.missao_id;

SELECT h.nome, i.nome
FROM Heroi AS h
FULL OUTER JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
FULL OUTER JOIN Item AS i
ON i.id = hi.item_id;

-- LEFT EXCLUDING JOIN
SELECT h.nome, m.nome
FROM Heroi AS h
LEFT JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
LEFT JOIN Missao AS m
ON m.id = hm.missao_id
WHERE m.id IS NULL;

SELECT h.nome, i.nome
FROM Heroi AS h
FULL OUTER JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
FULL OUTER JOIN Item AS i
ON i.id = hi.item_id
WHERE i.id IS NULL;

-- RIGHT EXCLUDING JOIN
SELECT h.nome, m.nome
FROM Heroi AS h
RIGHT JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
RIGHT JOIN Missao AS m
ON m.id = hm.missao_id
WHERE h.id IS NULL;

SELECT h.nome, i.nome
FROM Heroi AS h
RIGHT JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
RIGHT JOIN Item AS i
ON i.id = hi.item_id
WHERE h.id IS NULL;

-- OUTER EXCLUDING JOIN
SELECT h.nome, m.nome
FROM Heroi AS h
FULL OUTER JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
FULL OUTER JOIN Missao AS m
ON m.id = hm.missao_id
WHERE h.id IS NULL OR
m.id IS NULL;

SELECT h.nome, i.nome
FROM Heroi AS h
FULL OUTER JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
FULL OUTER JOIN Item AS i
ON i.id = hi.item_id
WHERE h.id IS NULL OR
i.id IS NULL;

-- UNION
SELECT id, nome FROM Jogador
UNION
SELECT id, nome FROM Heroi;

SELECT id, nome FROM Jogador
WHERE moedas > 100
UNION
SELECT id, nome FROM Jogador
WHERE nome LIKE 'a%';


-- UNION ALL
SELECT id, nome FROM Jogador
WHERE moedas > 100
UNION ALL
SELECT id, nome FROM Jogador
WHERE nome LIKE 'a%';

-- EXCEPT
SELECT id, nome FROM Jogador
WHERE moedas > 100
EXCEPT
SELECT id, nome FROM Jogador
WHERE nome LIKE 'a%';

-- INTERSECT
SELECT id, nome FROM Jogador
WHERE moedas > 100
INTERSECT
SELECT id, nome FROM Jogador
WHERE nome LIKE 'a%';
