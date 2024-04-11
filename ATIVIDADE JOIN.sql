create database ASSINATURA;
USE ASSINATURA;

CREATE TABLE Ramo_Atividade (
    Id_ramo INT PRIMARY KEY auto_increment,
    descrição VARCHAR(255) NOT NULL

);
CREATE TABLE Tipo_Assinante (
   id_tipo INT PRIMARY KEY auto_increment,
   descrição VARCHAR(255) NOT NULL
);

CREATE TABLE Telefone (
    id_fone INT PRIMARY KEY auto_increment,
    ddd INT NOT NULL,
    numero INT NOT NULL
);
CREATE TABLE Municipio (
   id_municipio INT PRIMARY KEY,
   nome VARCHAR(255) NOT NULL
);
CREATE TABLE Endereco (
    id_endereco INT PRIMARY KEY,
    rua VARCHAR(255) NOT NULL,
    complemento VARCHAR(255),
    bairro VARCHAR(255) NOT NULL,
    CEP INT NOT NULL,
    id_municipio INT,
    id_fone INT,
    FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio),
    FOREIGN KEY (id_fone) REFERENCES Telefone(id_fone)
);

CREATE TABLE Assinante (
    cd_assinante INT PRIMARY KEY,
    nm_assinante VARCHAR(255) NOT NULL,
    id_endereco INT,
    id_ramo INT,
    id_tipo INT,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco),
    FOREIGN KEY (id_ramo) REFERENCES Ramo_Atividade(id_ramo),
    FOREIGN KEY (id_tipo) REFERENCES Tipo_Assinante(id_tipo)
);

-- Adicionar dados à tabela Ramo_Atividade
INSERT INTO Ramo_Atividade (descrição) VALUES
('Tecnologia'),
('Saúde'),
('Educação'),
('Serviços');

-- Adicionar dados à tabela Tipo_Assinante
INSERT INTO Tipo_Assinante (descrição) VALUES
('Residencial'),
('Comercial'),
('Corporativo');

-- Adicionar dados à tabela Telefone
INSERT INTO Telefone (ddd, numero) VALUES
(51, 123456789),
(84, 987654321),
(11, 555555555);

-- Adicionar dados à tabela Municipio
INSERT INTO Municipio (id_municipio, nome) VALUES
(1, 'Pelotas'),
(2, 'Natal'),
(3, 'João Câmara');

-- Adicionar dados à tabela Endereco
INSERT INTO Endereco (id_endereco, rua, complemento, bairro, CEP, id_municipio, id_fone) VALUES
(1, 'Rua A', 'Apartamento 101', 'Centro', 12345678, 1, 1),
(2, 'Rua B', NULL, 'Cidade Alta', 87654321, 2, 2),
(3, 'Rua C', 'Sala 202', 'Vila Nova', 54321678, 3, 3);

-- Adicionar dados à tabela Assinante
INSERT INTO Assinante (cd_assinante, nm_assinante, id_endereco, id_ramo, id_tipo) VALUES
(1, 'João', 1, 1, 1),
(2, 'Maria', 2, 2, 2),
(3, 'Pedro', 3, 3, 3);

-- Listar os nomes dos assinantes, seguido dos dados do endereço e os telefones correspondentes.
select 
    A.nm_assinante as Nome_Assinante,
    E.rua as Rua,
    E.complemento as Complemento,
    E.bairro as Bairro,
    E.CEP as CEP,
    T.ddd as DDD,
    T.numero as Numero
from 
    Assinante A
join 
    Endereco E on A.id_endereco = E.id_endereco
join 
    Telefone T on E.id_fone = T.id_fone;

-- Listar os nomes dos assinantes, seguido do seu ramo, ordenados por ramo e posteriormente por nome.
select 
    A.nm_assinante as Nome_Assinante,
    R.descrição as Ramo_Atividade
from 
    Assinante A
join 
    Ramo_Atividade R on A.id_ramo = R.Id_ramo
order by 
    R.descrição, 
    A.nm_assinante;

-- Listar os assinantes do município de Pelotas que são do tipo residencial.
select 
    A.nm_assinante as Nome_Assinante,
    TA.descrição as Tipo_Assinante
from 
    Assinante A
join 
    Endereco E on A.id_endereco = E.id_endereco
join 
    Municipio M on E.id_municipio = M.id_municipio
join 
    Tipo_Assinante TA on A.id_tipo = TA.id_tipo
where 
    M.nome = 'Pelotas'
    and TA.descrição = 'Residencial';

-- Listar os nomes dos assinantes que possuem mais de um telefone.
select 
    A.nm_assinante as Nome_Assinante
from 
    Assinante A
join 
    Endereco E on A.id_endereco = E.id_endereco
join 
    Telefone T on E.id_fone = T.id_fone
group by 
    A.cd_assinante
having 
    COUNT(T.id_fone) > 1;

-- Listar os nomes dos assinantes seguido do número do telefone, tipo de assinante comercial, com endereço em Natal ou João Câmara.
select 
    A.nm_assinante as Nome_Assinante,
    T.numero as Numero_Telefone,
    TA.descrição as Tipo_Assinante
from 
    Assinante A
JOIN 
    Endereco E on A.id_endereco = E.id_endereco
join 
    Telefone T on E.id_fone = T.id_fone
join 
    Municipio M on E.id_municipio = M.id_municipio
join 
    Tipo_Assinante TA on A.id_tipo = TA.id_tipo
where 
    TA.descrição = 'Comercial'
    and (M.nome = 'Natal' or M.nome = 'João Câmara');
