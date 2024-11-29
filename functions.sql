/*

Scripts SQL para Functions (incluir comentário explicando para que serve a Function
e os parâmetros de entrada e valor de saída).
Mínimo = pelo menos 2 Functions.

    1. calcular a idade de um jogador
        1.2. getIdade
    2. calcular a quantidade de jogadores de um time
    3. calcular a quantidade de partidas de um time
    4. calcular a quantidade de partidas de um jogador

*/

-- 1
/*
    A Function calcularIdade calcula a idade de uma pessoa a partir de sua data de nascimento.
    Parâmetros:
        - idPessoaFN: id da pessoa
    Valor de saída:
        - nome e idade da pessoa
*/
CREATE OR REPLACE FUNCTION
    calcularIdade (idPessoaFN INTEGER)
    RETURNS TABLE (nome VARCHAR(50), idade VARCHAR(10)) AS $$
    BEGIN
        RETURN QUERY
        SELECT
            Pessoas.nome,
            CONCAT(EXTRACT(YEAR FROM AGE(CURRENT_DATE, Pessoas.dataNascimento))::INTEGER, ' anos')::VARCHAR(10)
        FROM Pessoas WHERE idPessoa = idPessoaFN;
    END;
    $$ LANGUAGE plpgsql;

-- 1.2 (getIdade)
CREATE OR REPLACE FUNCTION
    getIdade (idPessoaFN INTEGER)
    RETURNS INTEGER AS $$
    DECLARE
        idade INTEGER;
    BEGIN
        SELECT
            EXTRACT(YEAR FROM AGE(CURRENT_DATE, Pessoas.dataNascimento))::INTEGER
        INTO idade
        FROM Pessoas WHERE idPessoa = idPessoaFN;
        RETURN idade;
    END;
    $$ LANGUAGE plpgsql;

-- 2
/*
    A Function qtdJogadores calcula a quantidade de jogadores de um time.
    Parâmetros:
        - idTimeFN: id do time
    Valor de saída:
        - nome do time e quantidade de jogadores dele
*/
CREATE OR REPLACE FUNCTION
    qtdJogadores (idTimeFN INTEGER)
    RETURNS TABLE (nomeTime VARCHAR(50), quantidade VARCHAR(15)) AS $$
    BEGIN
        RETURN QUERY
        SELECT
            Times.nomeTime,
            CONCAT(COUNT(Jogadores_Times.idJogador), ' jogadores')::VARCHAR(15)
        FROM Times JOIN Jogadores_Times ON Times.idTime = Jogadores_Times.idTime WHERE Times.idTime = idTimeFN GROUP BY Times.nomeTime;
    END;
    $$ LANGUAGE plpgsql;

-- 3
/*
    A Function qtdPartidasTime calcula a quantidade de partidas de um time.
    Parâmetros:
        - idTimeFN: id do time
    Valor de saída:
        - nome do time e quantidade de partidas dele
*/
CREATE OR REPLACE FUNCTION
    qtdPartidasTime (idTimeFN INTEGER)
    RETURNS TABLE (nomeTime VARCHAR(50), quantidade VARCHAR(15)) AS $$
    BEGIN
        RETURN QUERY
        SELECT
            Times.nomeTime,
            CONCAT(COUNT(Partidas.idPartida), ' partidas')::VARCHAR(15)
        FROM Times JOIN Partidas ON Times.idTime = Partidas.timeCasa OR Times.idTime = Partidas.timeVisitante WHERE Times.idTime = idTimeFN GROUP BY Times.nomeTime;
    END;
    $$ LANGUAGE plpgsql;

-- 4
/*
    A Function qtdPartidasJogador calcula a quantidade de partidas de um jogador.
    Parâmetros:
        - idJogadorFN: id do jogador
    Valor de saída:
        - nome do jogador e quantidade de partidas dele
*/
CREATE OR REPLACE FUNCTION
    qtdPartidasJogador (idJogadorFN INTEGER)
    RETURNS TABLE (nome VARCHAR(50), quantidade VARCHAR(15)) AS $$
    BEGIN
        RETURN QUERY
        SELECT
            Jogadores.nome,
            CONCAT(COUNT(Partidas.idPartida), ' partidas')::VARCHAR(15)
        FROM Jogadores JOIN Jogadores_Times ON Jogadores.idPessoa = Jogadores_Times.idJogador JOIN Partidas ON Jogadores_Times.idTime = Partidas.timeCasa OR Jogadores_Times.idTime = Partidas.timeVisitante WHERE Jogadores.idPessoa = idJogadorFN GROUP BY Jogadores.nome;
    END;
    $$ LANGUAGE plpgsql;

-- Exemplos de uso

SELECT * FROM calcularIdade(4);
SELECT * FROM qtdJogadores(2);
SELECT * FROM qtdPartidasTime(1);
SELECT * FROM qtdPartidasJogador(3);