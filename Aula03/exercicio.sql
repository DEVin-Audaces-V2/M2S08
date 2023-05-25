USE LAB365;
GO

-- EX1
SELECT j.nome 
FROM Jogador AS j
LEFT JOIN Heroi AS h
ON j.id = h.jogador_id
WHERE h.id IS NULL;

-- EX2
SELECT j.id, COUNT(h.id)
FROM Jogador AS j
INNER JOIN Heroi AS h
ON j.id = h.jogador_id
GROUP BY j.id;

-- EX3
SELECT h.nome, i.nome, hi.quantidade
FROM Heroi AS h
INNER JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
INNER JOIN Item AS i
ON i.id = hi.item_id;

-- EX4
SELECT j.nome, SUM(m.recompensa_moedas)
FROM Jogador AS j
INNER JOIN Heroi AS h
ON j.id = h.jogador_id
INNER JOIN Heroi_Missao AS hm
ON h.id = hm.heroi_id
INNER JOIN Missao AS m
ON m.id = hm.missao_id
WHERE hm.progresso = 1
GROUP BY j.nome
ORDER BY SUM(m.recompensa_moedas) DESC;

-- EX5
SELECT h.classe, SUM(hi.quantidade)
FROM Heroi AS h
INNER JOIN Heroi_Item AS hi
ON h.id = hi.heroi_id
INNER JOIN Item AS i
ON i.id = hi.item_id
GROUP BY h.classe;




