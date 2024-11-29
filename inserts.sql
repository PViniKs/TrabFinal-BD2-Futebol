/*

Inserções realizadas sem nenhuma verificação de integridade ou relacionamento dos dados,
irei fazer isso na parte das Functions

*/

INSERT INTO Treinadores (nome, cpf, dataNascimento) VALUES
    ('Filipe Luis', '01234567890', '1985-08-09'), -- id 1
    ('Gabriel Milito', '06548662498', '1980-09-07'); -- id 2

INSERT INTO Jogadores (nome, cpf, dataNascimento) VALUES
    -- titulares flamengo
    ('Agustin Rossi', '12345678901', '1995-08-21'), -- id 3
    ('Wesley França', '12345678902', '2003-09-06'), -- id 4
    ('Leo Ortiz', '12345678903', '1996-01-03'), -- id 5
    ('Leo Pereira', '12345678904', '1996-01-31'), -- id 6
    ('Alex Sandro Lobo Silva', '12345678905', '1991-01-26'), -- id 7
    ('Gerson Santos da Silva', '12345678906', '1997-05-20'), -- id 8
    ('Evertton Araujo', '12345678907', '2003-02-28'), -- id 9
    ('Gonzalo Plata', '12345678908', '2000-11-01'), -- id 10
    ('Giorgian De Arrascaeta', '12345678909', '1994-06-01'), -- id 11
    ('Michael Richard Delgado de Oliveira', '12345678910', '1996-03-12'), -- id 12
    ('Gabriel Barbosa', '12345678911', '1996-08-30'), -- id 13

    -- titulares atletico mg
    ('Givanildo Vieira de Sousa', '23456789012', '1986-07-25'), -- id 14
    ('Guilherme Arana', '23456789013', '1997-04-14'), -- id 15
    ('Paulo Henrique Sampaio Filho', '23456789014', '2000-07-15'), -- id 16
    ('Rubens Antonio Dias', '23456789015', '2001-06-21'), -- id 17
    ('Alan Franco Palma', '23456789016', '1998-08-21'), -- id 18
    ('Otavio Henrique Passos Santos', '23456789017', '1994-05-04'), -- id 19
    ('Gustavo Scarpa', '23456789018', '1994-01-05'), -- id 20
    ('Junior Alonso', '23456789019', '1993-02-09'), -- id 21
    ('Rodrigo Battaglia', '23456789020', '1991-07-12'), -- id 22
    ('Lyanco Evangelista Silveira Neves Vojnovic', '23456789021', '1997-02-01'), -- id 23
    ('Everson Felipe Marques Pires', '23456789022', '1990-07-22'), -- id 24
    
    -- reservas flamengo
    ('Guillermo Varela', '34567890123', '1993-03-24'), -- id 25
    ('Ayrton Lucas Dantas de Medeiros', '34567890124', '1997-06-19'), -- id 26
    ('Fabrício Bruno', '34567890125', '1996-02-12'), -- id 27
    ('Carlos Alcaraz', '34567890126', '2002-11-30'), -- id 28
    ('Lorran Lucas Pereira de Sousa', '34567890127', '2006-07-04'), -- id 29
    ('Matheus Gonçalves', '34567890128', '2005-08-18'), -- id 30
    ('David Luiz', '34567890129', '1987-04-22'), -- id 31
    ('Matheus Cunha Queiroz', '34567890130', '2001-05-24'), -- id 32
    ('Allan Rodrigues de Souza', '34567890131', '1997-03-03'), -- id 33
    ('Cleiton Santana', '34567890132', '2003-04-25'), -- id 34
    ('Francisco Dyogo Bento Alves', '34567890133', '2004-01-09'), -- id 35

    -- reservas atletico mg
    ('Alan Kardec', '45678901234', '1989-01-12'), -- id 36
    ('Matías Zaracho', '45678901235', '1998-03-10'), -- id 37
    ('Renzo Saravia', '45678901236', '1993-06-16'), -- id 38
    ('Alisson Santana', '45678901237', '2005-09-21'), -- id 39
    ('Bruno Fuchs', '45678901238', '1999-04-01'), -- id 40
    ('Eduardo Vargas', '45678901239', '1989-11-20'), -- id 41
    ('Igor Rabello', '45678901240', '1995-04-28'), -- id 42
    ('Igor Gomes', '45678901241', '1999-03-17'), -- id 43
    ('Mariano Ferreira Filho', '45678901242', '1986-06-23'), -- id 44
    ('Paulo Vitor Monteiro', '45678901243', '2004-08-26'), -- id 45
    ('Brahian Palacios', '45678901244', '2002-11-24'); -- id 46

INSERT INTO Times (nomeTime, idTreinador) VALUES
    ('Flamengo', 1),
    ('Atletico MG', 2);

INSERT INTO Escalacoes (idTime, formacao) VALUES
    (1, '4-2-3-1'),
    (2, '3-4-2-1');

INSERT INTO Partidas (timeCasa, timeVisitante, escalacaoCasa, escalacaoVisitante, data, horario, local) VALUES
    (1, 2, 1, 2, '2024-11-03', '16:00', 'Maracanã'),
    (2, 1, 2, 1, '2024-11-10', '16:00', 'Arena MRV');

INSERT INTO Jogadores_Times (idJogador, idTime) VALUES
    (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1),
    (14, 2), (15, 2), (16, 2), (17, 2), (18, 2), (19, 2), (20, 2), (21, 2), (22, 2), (23, 2), (24, 2),
    (25, 1), (26, 1), (27, 1), (28, 1), (29, 1), (30, 1), (31, 1), (32, 1), (33, 1), (34, 1), (35, 1),
    (36, 2), (37, 2), (38, 2), (39, 2), (40, 2), (41, 2), (42, 2), (43, 2), (44, 2), (45, 2), (46, 2);

INSERT INTO Jogadores_Escalacoes (idJogador, idEscalacao, titular) VALUES
    (3, 1, TRUE), (4, 1, TRUE), (5, 1, TRUE), (6, 1, TRUE), (7, 1, TRUE), (8, 1, TRUE),
    (9, 1, TRUE), (10, 1, TRUE), (11, 1, TRUE), (12, 1, TRUE), (13, 1, TRUE),
    (14, 2, TRUE), (15, 2, TRUE), (16, 2, TRUE), (17, 2, TRUE), (18, 2, TRUE), (19, 2, TRUE),
    (20, 2, TRUE), (21, 2, TRUE), (22, 2, TRUE), (23, 2, TRUE), (24, 2, TRUE),
    (25, 1, FALSE), (26, 1, FALSE), (27, 1, FALSE), (28, 1, FALSE), (29, 1, FALSE), (30, 1, FALSE),
    (31, 1, FALSE), (32, 1, FALSE), (33, 1, FALSE), (34, 1, FALSE), (35, 1, FALSE),
    (36, 2, FALSE), (37, 2, FALSE), (38, 2, FALSE), (39, 2, FALSE), (40, 2, FALSE), (41, 2, FALSE),
    (42, 2, FALSE), (43, 2, FALSE), (44, 2, FALSE), (45, 2, FALSE), (46, 2, FALSE);