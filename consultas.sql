/*

Scripts SQL para consultas, algumas usando diferentes tipos de JOIN.
Mínimo = 5 consultas envolvendo preferencialmente mais de uma tabela

    1. liste todos os jogadores e o time que joga, em ordem alfabética pelo nome do jogador
    2. selecione todos os jogadores, sua camisa, sua posição e se já foi titular em alguma escalação
    3. mostre os dados de uma partida, incluindo: data, hora, local e nome dos times que jogaram
    4. mostre todos os times, quem é o treinador e quantos jogadores tem
    5. mostre todos os jogadores de um determinado time (pelo id), quantas vezes foi escalado e quantas partidas jogou

*/

-- 1
SELECT j.nome AS "Nome do Jogador", j.dataNascimento AS "Data de Nascimento", t.nomeTime AS "Time"
FROM Jogadores j
    JOIN Jogadores_Times jt ON j.idPessoa = jt.idJogador
    JOIN Times t ON jt.idTime = t.idTime ORDER BY j.nome ASC;

-- 2
SELECT j.nome AS "Nome do Jogador", j.numeroCamisa AS "Número da Camisa", j.posicao AS "Posição", t.nomeTime AS "Time",
CASE 
    WHEN EXISTS (SELECT 1 FROM Jogadores_Escalacoes je WHERE je.idJogador = j.idPessoa AND je.titular = true) 
    THEN 'Sim' 
    ELSE 'Não' 
END AS "Já foi Titular"
FROM Jogadores j
    JOIN Jogadores_Times jt ON j.idPessoa = jt.idJogador
    JOIN Times t ON jt.idTime = t.idTime ORDER BY j.nome ASC;

-- 3
SELECT p.data AS "Data", p.horario AS "Horário", p.local AS "Local", tC.nomeTime AS "Time da Casa", tV.nomeTime AS "Time Visitante" FROM Partidas p
    JOIN Times tC ON p.timeCasa = tC.idTime
    JOIN Times tV ON p.timeVisitante = tV.idTime ORDER BY p.data ASC;

-- 4
SELECT t.nomeTime AS "Time", tr.nome AS "Treinador", COUNT(jt.idJogador) AS "Quantidade de Jogadores" FROM Times t
    JOIN Treinadores tr ON t.idTreinador = tr.idPessoa
    JOIN Jogadores_Times jt ON t.idTime = jt.idTime GROUP BY t.nomeTime, tr.nome ORDER BY t.nomeTime ASC;

-- 5
SELECT j.nome AS "Nome do Jogador", COUNT(je.idJogador) AS "Quantidade de Escalações", COUNT(p.idPartida) AS "Quantidade de Partidas" FROM Jogadores j
    JOIN Jogadores_Times jt ON j.idPessoa = jt.idJogador
    JOIN Jogadores_Escalacoes je ON j.idPessoa = je.idJogador
    JOIN Partidas p ON jt.idTime = p.timeCasa OR jt.idTime = p.timeVisitante WHERE jt.idTime = 1 GROUP BY j.nome ORDER BY j.nome ASC;