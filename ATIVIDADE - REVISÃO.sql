CREATE DATABASE AtividadeSQL;
USE AtividadeSQL;

CREATE DATABASE AtividadeSQL;
USE AtividadeSQL;

CREATE TABLE alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    idade INT,
    cidade VARCHAR(100)
);

CREATE TABLE disciplinas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    professor VARCHAR(100)
);

CREATE TABLE notas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    disciplina_id INT,
    nota FLOAT,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);

INSERT INTO alunos (nome, idade, cidade) VALUES
    ('João', 20, 'São Paulo'),
    ('Maria', 22, 'Rio de Janeiro'),
    ('Pedro', 21, 'Belo Horizonte');

INSERT INTO disciplinas (nome, professor) VALUES
    ('Matemática', 'Prof. Silva'),
    ('História', 'Prof. Oliveira'),
    ('Geografia', 'Prof. Santos');

INSERT INTO notas (aluno_id, disciplina_id, nota) VALUES
    (1, 1, 8.5),
    (1, 2, 7.0),
    (1, 3, 9.0),
    (2, 1, 9.5),
    (2, 2, 8.0),
    (2, 3, 8.5),
    (3, 1, 7.0),
    (3, 2, 6.5),
    (3, 3, 7.5);

SELECT * FROM alunos;

SELECT * FROM disciplinas;

SELECT alunos.nome, notas.nota
FROM alunos
INNER JOIN notas ON alunos.id = notas.aluno_id
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.id
WHERE disciplinas.nome = 'História';

SELECT alunos.nome, AVG(notas.nota) AS media_notas
FROM alunos
LEFT JOIN notas ON alunos.id = notas.aluno_id
GROUP BY alunos.nome;

SELECT * FROM alunos WHERE idade > 20;

SELECT disciplinas.nome AS disciplina, disciplinas.professor
FROM disciplinas;

SELECT disciplinas.nome AS disciplina, AVG(notas.nota) AS media_notas
FROM disciplinas
INNER JOIN notas ON disciplinas.id = notas.disciplina_id
GROUP BY disciplinas.nome
HAVING AVG(notas.nota) > 8.0;

SELECT alunos.nome
FROM alunos
LEFT JOIN notas ON alunos.id = notas.aluno_id
GROUP BY alunos.nome
HAVING MIN(notas.nota) >= 8.0;

SELECT alunos.nome, notas.nota
FROM alunos
INNER JOIN notas ON alunos.id = notas.aluno_id
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.id
WHERE disciplinas.nome = 'Matemática';

SELECT cidade, COUNT(*) AS quantidade_alunos
FROM alunos
GROUP BY cidade;

SELECT disciplinas.nome AS disciplina, MAX(notas.nota) AS nota_mais_alta
FROM disciplinas
INNER JOIN notas ON disciplinas.id = notas.disciplina_id
GROUP BY disciplinas.nome;

SELECT alunos.nome
FROM alunos
INNER JOIN notas ON alunos.id = notas.aluno_id
WHERE notas.nota < 7.0;

SELECT alunos.nome, AVG(notas.nota) AS media_notas
FROM alunos
INNER JOIN notas ON alunos.id = notas.aluno_id
WHERE notas.nota > 9.0
GROUP BY alunos.nome;

SELECT alunos.nome
FROM alunos
LEFT JOIN notas ON alunos.id = notas.aluno_id
WHERE notas.id IS NULL;

SELECT alunos.nome
FROM alunos
INNER JOIN notas ON alunos.id = notas.aluno_id
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.id
WHERE alunos.cidade = 'São Paulo' AND notas.nota > 8.0;