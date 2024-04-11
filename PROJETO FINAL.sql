CREATE DATABASE IF NOT EXISTS RH;
USE RH;

-- Tabela Departamentos
CREATE TABLE IF NOT EXISTS Departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_departamento VARCHAR(50) UNIQUE
);

-- Inserir dados na tabela Departamentos
INSERT INTO Departamentos (nome_departamento) VALUES
('Financeiro'),
('Recursos Humanos'),
('Tecnologia da Informação'),
('Marketing');

-- Tabela Cargos
CREATE TABLE IF NOT EXISTS Cargos (
    id_cargo INT PRIMARY KEY AUTO_INCREMENT,
    nome_cargo VARCHAR(50) UNIQUE,
    salario_base DECIMAL(10, 2)
);

-- Inserir dados na tabela Cargos
INSERT INTO Cargos (nome_cargo, salario_base) VALUES
('Analista Financeiro', 5000.00),
('Assistente de RH', 3500.00),
('Desenvolvedor de Software', 6000.00),
('Analista de Marketing', 5500.00);

-- Tabela Funcionários
CREATE TABLE IF NOT EXISTS Funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    data_nascimento DATE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20) UNIQUE,
    salario DECIMAL(10, 2),
    id_departamento INT,
    id_cargo INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento),
    FOREIGN KEY (id_cargo) REFERENCES Cargos(id_cargo)
);

-- Inserir dados na tabela Funcionarios
INSERT INTO Funcionarios (nome, data_nascimento, email, telefone, salario, id_departamento, id_cargo) VALUES
('João', '1990-05-15', 'joao.silva@email.com', '(11) 9999-8888', 5000.00, 1, 1),
('Maria', '1985-09-20', 'maria.santos@email.com', '(21) 7777-6666', 3500.00, 2, 2),
('Pedro', '1995-02-10', 'pedro.oliveira@email.com', '(31) 3333-4444', 6000.00, 3, 3),
('Ana', '1988-11-30', 'ana.ferreira@email.com', '(41) 5555-4444', 5500.00, 4, 4);

-- Tabela Histórico de Salários
CREATE TABLE IF NOT EXISTS HistoricoSalarios (
    id_historico_salario INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    salario_antigo DECIMAL(10, 2),
    salario_novo DECIMAL(10, 2),
    data_alteracao DATE,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario)
);

-- Tabela Histórico de Promoções
CREATE TABLE IF NOT EXISTS HistoricoPromocoes (
    id_historico_promocao INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    cargo_anterior VARCHAR(50),
    cargo_novo VARCHAR(50),
    data_promocao DATE,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario)
);

-- Trigger para atualizar o histórico de salários
DELIMITER $$
CREATE TRIGGER atualizar_salario
AFTER UPDATE ON Funcionarios
FOR EACH ROW
BEGIN
    INSERT INTO HistoricoSalarios (id_funcionario, salario_antigo, salario_novo, data_alteracao)
    VALUES (OLD.id_funcionario, OLD.salario, NEW.salario, NOW());
END$$
DELIMITER ;

-- Stored procedure para promover um funcionário
DELIMITER $$
CREATE PROCEDURE PromoverFuncionario(
    IN funcionario_id INT,
    IN novo_cargo_id INT
)
BEGIN
    DECLARE cargo_anterior VARCHAR(50);
    DECLARE novo_cargo_nome VARCHAR(50);

    -- Obter o cargo anterior do funcionário
    SELECT nome_cargo INTO cargo_anterior
    FROM Cargos
    WHERE id_cargo = (SELECT id_cargo FROM Funcionarios WHERE id_funcionario = funcionario_id);
	
    -- Obter o nome do novo cargo
    SELECT nome_cargo INTO novo_cargo_nome
    FROM Cargos
    WHERE id_cargo = novo_cargo_id;

    -- Atualizar o cargo do funcionário
    UPDATE Funcionarios
    SET id_cargo = novo_cargo_id
    WHERE id_funcionario = funcionario_id;

    -- Registrar a promoção no histórico
    INSERT INTO HistoricoPromocoes (id_funcionario, cargo_anterior, cargo_novo, data_promocao)
    VALUES (funcionario_id, cargo_anterior, novo_cargo_nome, NOW());
END$$
DELIMITER ;

-- View para listar os funcionários com seus departamentos e cargos
CREATE VIEW FuncionariosDetalhados AS
SELECT f.id_funcionario, f.nome, c.nome_cargo
FROM Funcionarios f
JOIN Cargos c ON f.id_cargo = c.id_cargo;

-- Consultas

SELECT 
    f.id_funcionario, 
    f.nome AS nome_funcionario, 
    c.nome_cargo
FROM 
    Funcionarios f
JOIN 
    Cargos c ON f.id_cargo = c.id_cargo
WHERE 
    c.nome_cargo = 'Analista Financeiro';


select * from cargos;

select * from departamentos;

select * from funcionarios;

select * from HistoricoPromocoes;

select * from HistoricoSalarios;

SELECT * FROM FuncionariosDetalhados;

-- Atualizar Salario
UPDATE Funcionarios 
SET salario = 5001.00
WHERE id_funcionario = 1;

CALL PromoverFuncionario(1, 1);



