USE ExSemanal;
GO

-- EX2
CREATE TABLE Cliente (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(200) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    senha VARCHAR(50) NOT NULL
);

CREATE TABLE MetodoPagamento (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    numero_cartao VARCHAR(16) NOT NULL,
    validade DATE NOT NULL,
    senha VARCHAR(50) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

CREATE TABLE Produto (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    nota NUMERIC(2, 1) NOT NULL,
    unidades INTEGER NOT NULL,
    nro_vendas INTEGER NOT NULL
);

CREATE TABLE Avaliacao (
    id INT PRIMARY KEY IDENTITY(1,1),
    autor INT,
    produto INT,
    comentario VARCHAR(500) NOT NULL,
    numero_estrelas NUMERIC(1, 0) NOT NULL,
    data_criacao DATE NOT NULL,
    FOREIGN KEY (autor) REFERENCES Cliente(id),
    FOREIGN KEY (produto) REFERENCES Produto(id)
);

CREATE TABLE Pedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente INT,
    metodo_pagamento INT,
    valor_total NUMERIC(20, 2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    foi_entregue BIT NOT NULL,
    FOREIGN KEY (cliente) REFERENCES Cliente(id),
    FOREIGN KEY (metodo_pagamento) REFERENCES MetodoPagamento(id)
);

CREATE TABLE ProdutoPedido (
    produto INT,
    pedido INT,
    FOREIGN KEY (produto) REFERENCES Produto(id),
    FOREIGN KEY (pedido) REFERENCES Pedido(id)
);

-- EX3
INSERT INTO Cliente (nome, data_nascimento, email, cpf, senha)
VALUES
	('João Silva', '1990-05-12', 'joao.silva@example.com', '12345678901', 'senha123'),
	('Maria Santos', '1985-08-18', 'maria.santos@example.com', '98765432101', 'senha456'),
	('Pedro Almeida', '1995-02-25', 'pedro.almeida@example.com', '65432178901', 'senha789'),
	('Ana Oliveira', '1992-11-30', 'ana.oliveira@example.com', '98765412301', 'senhaabc'),
	('Eduardo Costa', '1998-05-22', 'eduardo.costa@example.com', '98775512101', 'senhadef');

INSERT INTO MetodoPagamento (cliente_id, numero_cartao, validade, senha)
VALUES
	(1, '1234567890123456', '2025-12-31', 'senha123'),
	(2, '9876543210987654', '2024-06-30', 'senha456'),
	(3, '6543219870654321', '2023-09-30', 'senha789'),
	(4, '9876543210123456', '2026-03-31', 'senhaabc');

-- Inserção de dados na tabela Produto
INSERT INTO Produto (nome, preco, nota, unidades, nro_vendas)
VALUES
	('Camiseta', 29.90, 4.5, 100, 50),
	('Calça Jeans', 99.90, 4.2, 80, 30),
	('Tênis', 149.90, 4.8, 50, 20),
	('Bolsa', 79.90, 4.0, 120, 60);

INSERT INTO Avaliacao (autor, produto, comentario, numero_estrelas, data_criacao)
VALUES
	(1, 1, 'Ótimo produto!', 5, '2023-05-15'),
	(2, 1, 'Gostei muito!', 4, '2023-05-16'),
	(3, 2, 'Qualidade excelente!', 4, '2023-05-17'),
	(4, 3, 'Recomendo!', 5, '2023-05-18'),
	(4, 4, 'Uma porcaria!', 1, '2023-05-19');

-- Inserção de dados na tabela Pedido
INSERT INTO Pedido (cliente, metodo_pagamento, valor_total, status, foi_entregue)
VALUES
	(1, 1, 59.90, 'Em andamento', 0),
	(2, 2, 149.90, 'Entregue', 1),
	(3, 3, 228.70, 'Em andamento', 0),
	(4, 4, 79.90, 'Cancelado', 0);

-- Inserção de dados na tabela ProdutoPedido
INSERT INTO ProdutoPedido (produto, pedido)
VALUES
	(1, 1),
	(1, 2),
	(2, 2),
	(3, 3),
	(4, 4);

-- EX4
SELECT TOP 2 * FROM Produto ORDER BY nro_vendas DESC;

-- EX5
SELECT * FROM Pedido
WHERE valor_total > 100 AND foi_entregue = 1;

-- EX6
SELECT 
	c.nome, 
	COUNT(a.id) AS 'Número de avaliações'
FROM Cliente AS c
LEFT JOIN Avaliacao AS a
ON c.id = a.autor
GROUP BY c.nome
ORDER BY COUNT(a.id) DESC;

--EX7
SELECT c.nome, pr.nome, pe.valor_total
FROM Cliente AS c
INNER JOIN Pedido AS pe
ON c.id = pe.cliente
INNER JOIN ProdutoPedido AS pp
ON pe.id = pp.pedido
INNER JOIN Produto AS pr
ON pp.produto = pr.id
WHERE pe.valor_total > 150;

-- EX8
GO;
CREATE PROCEDURE AtualizarEstoque
	@produto_id INT,
	@quantidade_vendida INT
AS
	UPDATE Produto
	SET
		unidades = unidades - @quantidade_vendida,
		nro_vendas = nro_vendas + @quantidade_vendida
	WHERE
		id = @produto_id;
GO;

SELECT nome, unidades, nro_vendas FROM Produto
WHERE id = 1;

EXEC AtualizarEstoque @produto_id = 1, @quantidade_vendida = 10;

-- EX9
GO;
CREATE VIEW vwDetalhesPedidosCliente
AS
	SELECT
		p.id,
		c.nome,
		c.email,
		p.valor_total,
		p.status
	FROM Pedido AS p
	LEFT JOIN Cliente AS c
	ON p.cliente = c.id;

SELECT * FROM vwDetalhesPedidosCliente;