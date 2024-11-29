/*

Scripts SQL para Views (incluir comentário explicando para que serve a View).
Mínimo = pelo menos 2 Views.

    1. View com os dados de todos os jogadores e o time que jogam
    2. View com os dados de todas as partidas, incluindo: data, hora, local e nome dos times que jogaram
    3. View que exibe todas as pessoas, separando-as em jogadores e treinadores

*/

-- 1
/*
    A View viewJogadores exibe os dados de todos os jogadores e o time ao qual estão vinculados.
*/
CREATE OR REPLACE VIEW viewJogadores AS
SELECT
    Jogadores.nome AS "Nome do Jogador",
    getIdade(Jogadores.idPessoa) AS "Idade",
    Times.nomeTime AS "Time"
FROM Jogadores JOIN Jogadores_Times ON Jogadores.idPessoa = Jogadores_Times.idJogador JOIN Times ON Jogadores_Times.idTime = Times.idTime;

-- 2
/*
    A View viewPartidas exibe os dados de todas as partidas, incluindo: data, hora, local e nome dos times que jogaram.
*/
CREATE OR REPLACE VIEW viewPartidas AS
SELECT
    Partidas.data AS "Data",
    Partidas.horario AS "Horário",
    Partidas.local AS "Local",
    TimeCasa.nomeTime AS "Time da Casa",
    TimeVisitante.nomeTime AS "Time Visitante"
FROM Partidas JOIN Times TimeCasa ON Partidas.timeCasa = TimeCasa.idTime JOIN Times TimeVisitante ON Partidas.timeVisitante = TimeVisitante.idTime;

-- 3
/*
    A View viewPessoas exibe os dados de todas as pessoas, separando-as em jogadores e treinadores.
*/
CREATE OR REPLACE VIEW viewPessoas AS
SELECT
    j.idPessoa AS "ID",
    j.nome AS "Nome",
    getIdade(j.idPessoa) AS "Idade",
    'Jogador' AS "Tipo"
FROM Jogadores j
UNION
SELECT
    t.idPessoa AS "ID",
    t.nome AS "Nome",
    getIdade(t.idPessoa) AS "Idade",
    'Treinador' AS "Tipo"
FROM Treinadores t ORDER BY "Tipo" DESC, "ID";

-- Exemplo de consulta às Views
SELECT * FROM viewJogadores;
SELECT * FROM viewPartidas;
SELECT * FROM viewPessoas;