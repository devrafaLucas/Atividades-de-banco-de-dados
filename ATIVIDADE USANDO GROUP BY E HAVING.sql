create database comercio_eletronico;
use comercio_eletronico;

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    cidade VARCHAR(100)
);

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE vendas (
    id INT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    data DATE,
    quantidade INT,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO clientes (id, nome, idade, cidade)
VALUES
    (1, 'João', 30, 'São Paulo'),
    (2, 'Maria', 25, 'Rio de Janeiro'),
    (3, 'Carlos', 35, 'Belo Horizonte'),
    (4, 'Ana', 28, 'Salvador');

INSERT INTO produtos (id, nome, categoria, preco)
VALUES
    (1, 'Camiseta', 'Roupas', 29.99),
    (2, 'Tênis', 'Calçados', 99.99),
    (3, 'Celular', 'Eletrônicos', 799.99),
    (4, 'Livro', 'Livros', 19.99);

INSERT INTO vendas (id, cliente_id, produto_id, data, quantidade, total)
VALUES
    (1, 1, 1, '2024-02-01', 2, 59.98),
    (2, 2, 3, '2024-02-01', 1, 799.99),
    (3, 3, 2, '2024-02-02', 1, 99.99),
    (4, 1, 4, '2024-02-03', 3, 59.97),
    (5, 4, 1, '2024-02-03', 2, 59.98),
    (6, 2, 2, '2024-02-04', 1, 99.99),
    (7, 1, 3, '2024-02-05', 1, 799.99),
    (8, 3, 1, '2024-02-06', 2, 59.98),
    (9, 4, 4, '2024-02-07', 1, 19.99),
    (10, 1, 2, '2024-02-08', 1, 99.99),
    (11, 2, 1, '2024-02-08', 2, 59.98);
    
    SELECT 
    c.id AS Cliente_ID,
    c.nome AS Nome_Cliente,
    COUNT(v.id) AS Total_Vendas
FROM 
    clientes c
LEFT JOIN 
    vendas v ON c.id = v.cliente_id
GROUP BY 
    c.id, c.nome;
    
    SELECT 
    data
FROM 
    vendas
GROUP BY 
    data
HAVING 
    COUNT(id) > 2;
    
    SELECT 
    cidade,
    COUNT(id) AS Numero_de_Clientes
FROM 
    clientes
GROUP BY 
    cidade
ORDER BY 
    Numero_de_Clientes DESC
LIMIT 1;

SELECT 
    AVG(idade) AS Idade_Media
FROM 
    clientes;
    
    SELECT cidade
FROM clientes
GROUP BY cidade
HAVING AVG(idade) < 30;

SELECT data
FROM vendas
GROUP BY data
HAVING SUM(total) > 500;

SELECT 
    p.nome AS Produto_Mais_Vendido,
    SUM(v.quantidade) AS Total_Vendido
FROM 
    vendas v
JOIN 
    produtos p ON v.produto_id = p.id
GROUP BY 
    p.nome
ORDER BY 
    Total_Vendido DESC
LIMIT 1;