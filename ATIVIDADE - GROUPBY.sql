create database Jogos;
CREATE TABLE Jogos (
    titulo VARCHAR(255),
    empresa VARCHAR(255),
    tipo VARCHAR(255),
    ano_producao INT,
    sistema VARCHAR(255),
    custo_producao INT,
    receita INT,
    classificacao INT
);

INSERT INTO Jogos (titulo, empresa, tipo, ano_producao, sistema, custo_producao, receita, classificacao) VALUES
('Blasting Boxes', 'Simone Games', 'aventura de ação', 1998, 'PC', 100000, 200000, 7),
('Run Run Run!', '13 Mad Bits', 'tiro', 2011, 'PS3', 3500000, 6500000, 3),
('Duck n’Go', '13 Mad Bits', 'tiro', 2012,'Xbox' ,3000000 ,15000000 ,5 ),
('SQL Wars!', 'Vertabelo','jogos de guerra' ,2017 ,'Xbox' ,5000000 ,25000000 ,10 ),
('Tap Tap Hex!', 'PixelGaming Inc.', 'ritmo' ,2006 ,'PS2' ,2500000 ,3500000 ,7 ),
('NoRisk','Simone Games','aventura de ação' ,2004 ,'PS2' ,1400000 ,3400000 ,8 );

/* QUERY 1 */
select empresa,sum(receita) AS Receita_Total from Jogos group by empresa;

/* QUERY 2 */
select ano_producao,
    count(titulo) AS Total_Jogos,
    avg(receita) AS Receita_Media,
    avg(custo_producao) AS Custo_Medio
from Jogos
 group by ano_producao;
 
/* QUERY 3 */
select tipo,
    sum(case when receita > custo_producao then 1 else 0 end) as Numero_Jogos_Lucrativos
from Jogos
group by tipo;

/* QUERY 4 */
select tipo, 
sum(receita) AS Receita_Total
from Jogos
where sistema IN ('PS2', 'PS3')
group by tipo;

/* QUERY 5 */
select empresa,
sum(receita - custo_producao) AS Lucro_Bruto_Total
from Jogos
group by empresa;

/* QUERY 6 */
select ano_producao,
empresa,
sum(receita - custo_producao) AS Lucro_Bruto_Ano
from Jogos
group by ano_producao, empresa;


