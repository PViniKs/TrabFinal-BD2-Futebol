/*

Scripts SQL para Stored Procedures (incluir comentário explicando para que serve a
SP e os parâmetros caso utilizar).
Mínimo = pelo menos 2 SP.

    1. inserir novo jogador no time
    2. remover jogador do time
    3. inserir jogador como titular em uma escalação
    4. inserir jogador como reserva em uma escalação

*/

-- 1
/*
    A SP addJogadorNoTime vincula um jogador a um time, atualizando o número da camisa e a posição do jogador, caso ele já não esteja vinculado a um time.
    Parâmetros:
        - idJogadorSP: id do jogador a ser vinculado ao time
        - numeroCamisaSP: número da camisa do jogador no time
        - posicaoSP: posição do jogador no time
        - idTimeSP: id do time ao qual o jogador será vinculado

    A SP verifica se o jogador já está vinculado a um time.
    Caso esteja, um WARNING é emitido e a SP não realiza a inserção, se não, o jogador é vinculado ao time.
*/
CREATE OR REPLACE FUNCTION
    addJogadorNoTime (idJogadorSP INTEGER, numeroCamisaSP INTEGER, posicaoSP VARCHAR(50), idTimeSP INTEGER)
    RETURNS VOID AS $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Jogadores_Times WHERE idJogador = idJogadorSP) THEN
            INSERT INTO Jogadores_Times (idJogador, idTime) VALUES (idJogadorSP, idTimeSP);
            UPDATE Jogadores SET numeroCamisa = numeroCamisaSP, posicao = posicaoSP WHERE idPessoa = idJogadorSP;
        ELSE
            RAISE WARNING 'Erro ao inserir.'; 
            RAISE NOTICE 'Jogador % vinculado ao time %.', (SELECT nome FROM Jogadores WHERE idPessoa = idJogadorSP), (SELECT nomeTime from TIMES t JOIN Jogadores_Times jt ON t.idTime = jt.idTime WHERE jt.idJogador = idJogadorSP);
        END IF;
    END;
    $$ LANGUAGE plpgsql;

-- 2
/*
    A SP removeJogadorDoTime desvincula um jogador de um time, caso ele esteja vinculado ao mesmo.
    Parâmetros:
        - idJogadorSP: id do jogador a ser desvinculado do time
        - idTimeSP: id do time do qual o jogador será desvinculado

    A SP verifica se o jogador está vinculado ao time.
    Caso esteja, o jogador é desvinculado, se não, um WARNING é emitido.
*/
CREATE OR REPLACE FUNCTION
    removeJogadorDoTime (idJogadorSP INTEGER, idTimeSP INTEGER)
    RETURNS VOID AS $$
    BEGIN
        IF EXISTS (SELECT 1 FROM Jogadores_Times WHERE idJogador = idJogadorSP AND idTime = idTimeSP) THEN
            DELETE FROM Jogadores_Times WHERE idJogador = idJogadorSP AND idTime = idTimeSP;
        ELSE
            RAISE WARNING 'Erro ao remover.';
            RAISE NOTICE 'Jogador % não vinculado ao time %.', (SELECT nome FROM Jogadores WHERE idPessoa = idJogadorSP), (SELECT nomeTime from TIMES t JOIN Jogadores_Times jt ON t.idTime = jt.idTime WHERE jt.idJogador = idJogadorSP);
        END IF;
    END;
    $$ LANGUAGE plpgsql;

-- 3
/*
    A SP escJogadorTitular insere um jogador como titular em uma escalação, caso ele ainda não esteja escalado como titular.
    Parâmetros:
        - idJogadorSP: id do jogador a ser escalado como titular
        - idEscalacaoSP: id da escalação na qual o jogador será escalado como titular

    A SP verifica se a escalação já possui 11 titulares.
    Caso não possua, a SP verifica se o jogador já está escalado.
    Caso esteja, um WARNING é emitido, se não, o jogador é escalado como titular.
*/
CREATE OR REPLACE FUNCTION
    escJogadorTitular (idJogadorSP INTEGER, idEscalacaoSP INTEGER)
    RETURNS VOID AS $$
    BEGIN
        IF (SELECT COUNT(*) FROM Jogadores_Escalacoes WHERE idEscalacao = idEscalacaoSP AND titular = TRUE) < 11 THEN
            IF NOT EXISTS (SELECT 1 FROM Jogadores_Escalacoes WHERE idJogador = idJogadorSP AND idEscalacao = idEscalacaoSP) THEN
                INSERT INTO Jogadores_Escalacoes (idJogador, idEscalacao, titular) VALUES (idJogadorSP, idEscalacaoSP, TRUE);
            ELSE 
                RAISE WARNING 'Erro ao escalar jogador.';
                RAISE NOTICE 'Jogador % já escalado.', (SELECT nome FROM Jogadores WHERE idPessoa = idJogadorSP);
            END IF;
        ELSE
            RAISE WARNING 'Erro ao escalar jogador.';
            RAISE NOTICE 'Escalação % já possui 11 titulares.', idEscalacaoSP;
        END IF;
    END;
    $$ LANGUAGE plpgsql;

-- 4
/*
    A SP escJogadorReserva insere um jogador como reserva em uma escalação, caso ele ainda não esteja escalado como reserva.
    Parâmetros:
        - idJogadorSP: id do jogador a ser escalado como reserva
        - idEscalacaoSP: id da escalação na qual o jogador será escalado como reserva

    A SP verifica se a escalação já possui 11 reservas.
    Caso não possua, a SP verifica se o jogador já está escalado.
    Caso esteja, um WARNING é emitido, se não, o jogador é escalado como reserva.
*/
CREATE OR REPLACE FUNCTION
    escJogadorReserva (idJogadorSP INTEGER, idEscalacaoSP INTEGER)
    RETURNS VOID AS $$
    BEGIN
        IF (SELECT COUNT(*) FROM Jogadores_Escalacoes WHERE idEscalacao = idEscalacaoSP AND titular = FALSE) < 11 THEN
            IF NOT EXISTS (SELECT 1 FROM Jogadores_Escalacoes WHERE idJogador = idJogadorSP AND idEscalacao = idEscalacaoSP) THEN
                INSERT INTO Jogadores_Escalacoes (idJogador, idEscalacao, titular) VALUES (idJogadorSP, idEscalacaoSP, FALSE);
            ELSE 
                RAISE WARNING 'Erro ao escalar jogador.';
                RAISE NOTICE 'Jogador % já escalado.', (SELECT nome FROM Jogadores WHERE idPessoa = idJogadorSP);
            END IF;
        ELSE
            RAISE WARNING 'Erro ao escalar jogador.';
            RAISE NOTICE 'Escalação % já possui 11 reservas.', idEscalacaoSP;
        END IF;
    END;
    $$ LANGUAGE plpgsql;

-- agora vamos realizar as inserções de dados para testar as stored procedures com base em:

-- insersão dos jogadores nos times
SELECT addJogadorNoTime(3, 1, 'Goleiro', 1);
SELECT addJogadorNoTime(4, 43, 'Lateral', 1);
SELECT addJogadorNoTime(5, 3, 'Zagueiro', 1);
SELECT addJogadorNoTime(6, 4, 'Zagueiro', 1);
SELECT addJogadorNoTime(7, 26, 'Lateral', 1);
SELECT addJogadorNoTime(8, 8, 'Meio de Campo', 1);
SELECT addJogadorNoTime(9, 52, 'Meio de Campo', 1);
SELECT addJogadorNoTime(10, 45, 'Ponta', 1);
SELECT addJogadorNoTime(11, 14, 'Meio de Campo', 1);
SELECT addJogadorNoTime(12, 30, 'Ponta', 1);
SELECT addJogadorNoTime(13, 99, 'Atacante', 1);

SELECT addJogadorNoTime(14, 7, 'Atacante', 1);
SELECT addJogadorNoTime(14, 7, 'Atacante', 2);
-- Oops! O jogador 14 foi inserido no time errado, vamos corrigir
SELECT removeJogadorDoTime(14, 1);
-- Agora sim, jogador 14 no time 2

SELECT addJogadorNoTime(14, 7, 'Atacante', 2);
SELECT addJogadorNoTime(15, 13, 'Ponta', 2);
SELECT addJogadorNoTime(16, 10, 'Ponta', 2);
SELECT addJogadorNoTime(17, 44, 'Lateral', 2);
SELECT addJogadorNoTime(18, 23, 'Meio de Campo', 2);
SELECT addJogadorNoTime(19, 5, 'Meio de Campo', 2);
SELECT addJogadorNoTime(20, 6, 'Lateral', 2);
SELECT addJogadorNoTime(21, 8, 'Lateral', 2);
SELECT addJogadorNoTime(22, 21, 'Zagueiro', 2);
SELECT addJogadorNoTime(23, 2, 'Lateral', 2);
SELECT addJogadorNoTime(24, 22, 'Goleiro', 2);

SELECT addJogadorNoTime(25, 2, 'Lateral', 1);
SELECT addJogadorNoTime(26, 6, 'Lateral', 1);
SELECT addJogadorNoTime(27, 15, 'Zagueiro', 1);
SELECT addJogadorNoTime(28, 37, 'Meio de Campo', 1);
SELECT addJogadorNoTime(29, 19, 'Meio de Campo', 1);
SELECT addJogadorNoTime(30, 20, 'Ponta', 1);
SELECT addJogadorNoTime(31, 23, 'Zagueiro', 1);
SELECT addJogadorNoTime(32, 25, 'Goleiro', 1);
SELECT addJogadorNoTime(33, 29, 'Meio de Campo', 1);
SELECT addJogadorNoTime(34, 33, 'Zagueiro', 1);
SELECT addJogadorNoTime(35, 49, 'Goleiro', 1);

SELECT addJogadorNoTime(36, 18, 'Atacante', 2);
SELECT addJogadorNoTime(37, 11, 'Meio de Campo', 2);
SELECT addJogadorNoTime(38, 26, 'Lateral', 2);
SELECT addJogadorNoTime(39, 45, 'Meio de Campo', 2);
SELECT addJogadorNoTime(40, 3, 'Zagueiro', 2);
SELECT addJogadorNoTime(41, 11, 'Atacante', 2);
SELECT addJogadorNoTime(42, 16, 'Zagueiro', 2);
SELECT addJogadorNoTime(43, 17, 'Meio de Campo', 2);
SELECT addJogadorNoTime(44, 25, 'Lateral', 2);
SELECT addJogadorNoTime(45, 27, 'Zagueiro', 2);
SELECT addJogadorNoTime(46, 30, 'Lateral', 2);

-- insersão dos jogadores como titulares ou reservas nas escalacoes
SELECT escJogadorTitular(3, 1);
SELECT escJogadorTitular(4, 1);
SELECT escJogadorTitular(5, 1);
SELECT escJogadorTitular(6, 1);
SELECT escJogadorTitular(7, 1);
SELECT escJogadorTitular(8, 1);
SELECT escJogadorTitular(9, 1);
SELECT escJogadorTitular(10, 1);
SELECT escJogadorTitular(11, 1);
SELECT escJogadorTitular(12, 1);
SELECT escJogadorTitular(13, 1);

SELECT escJogadorTitular(13, 1);
-- Oops! O jogador 13 foi escalado duas vezes, ainda bem que a SP verifica isso

SELECT escJogadorTitular(14, 2);
SELECT escJogadorTitular(15, 2);
SELECT escJogadorTitular(16, 2);
SELECT escJogadorTitular(17, 2);
SELECT escJogadorTitular(18, 2);
SELECT escJogadorTitular(19, 2);
SELECT escJogadorTitular(20, 2);
SELECT escJogadorTitular(21, 2);
SELECT escJogadorTitular(22, 2);
SELECT escJogadorTitular(23, 2);
SELECT escJogadorTitular(24, 2);

SELECT escJogadorReserva(25, 1);
SELECT escJogadorReserva(26, 1);
SELECT escJogadorReserva(27, 1);
SELECT escJogadorReserva(28, 1);
SELECT escJogadorReserva(29, 1);
SELECT escJogadorReserva(30, 1);
SELECT escJogadorReserva(31, 1);
SELECT escJogadorReserva(32, 1);
SELECT escJogadorReserva(33, 1);
SELECT escJogadorReserva(34, 1);
SELECT escJogadorReserva(35, 1);

SELECT escJogadorReserva(36, 2);
SELECT escJogadorReserva(37, 2);
SELECT escJogadorReserva(38, 2);
SELECT escJogadorReserva(39, 2);
SELECT escJogadorReserva(40, 2);
SELECT escJogadorReserva(41, 2);
SELECT escJogadorReserva(42, 2);
SELECT escJogadorReserva(43, 2);
SELECT escJogadorReserva(44, 2);
SELECT escJogadorReserva(45, 2);
SELECT escJogadorReserva(46, 2);