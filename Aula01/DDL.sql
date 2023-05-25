USE LAB365;
GO

CREATE TABLE Jogador (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50),
    email VARCHAR(100),
    moedas INT
);

CREATE TABLE Heroi (
    id INT PRIMARY KEY IDENTITY(1,1),
    jogador_id INT,
    nome VARCHAR(50),
    nivel INT,
    classe VARCHAR(50),
    vida INT,
    mana INT,	
    ataque INT,
    defesa INT,
    FOREIGN KEY (jogador_id) REFERENCES Jogador(id)
);

CREATE TABLE Item (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50),
    tipo VARCHAR(50),
    valor INT,
    nivel_requerido INT
);

CREATE TABLE Heroi_Item (
    id INT PRIMARY KEY IDENTITY(1,1),
    heroi_id INT,
    item_id INT,
    quantidade INT,
    FOREIGN KEY (heroi_id) REFERENCES Heroi(id),
    FOREIGN KEY (item_id) REFERENCES Item(id)
);

CREATE TABLE Missao (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50),
    recompensa_moedas INT,
    nivel_requerido INT
);

CREATE TABLE Heroi_Missao (
    id INT PRIMARY KEY IDENTITY(1,1),
    heroi_id INT,
    missao_id INT,
    progresso INT,
    data_finalizacao DATE,
    FOREIGN KEY (heroi_id) REFERENCES Heroi(id),
    FOREIGN KEY (missao_id) REFERENCES Missao(id)
);
