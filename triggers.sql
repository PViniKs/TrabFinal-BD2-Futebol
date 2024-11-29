/*

Scripts SQL para Triggers (incluir comentário explicando para que serve a Trigger).
Mínimo = pelo menos 1 Trigger.

    1. Trigger que registra o log de todas as operações realizadas em todas as tabelas do BD

*/

-- Criação da tabela de logs
CREATE TABLE Logs (
    IDLog SERIAL PRIMARY KEY,
    operacao VARCHAR(10) NOT NULL, -- Tipo de operação
    tabela VARCHAR(50) NOT NULL, -- Nome da tabela
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da operação
    usuario VARCHAR(50) NOT NULL, -- Usuário que realizou a operação
    descricao TEXT -- Descrição
);

-- Função que registra o log na tabela de Logs
CREATE OR REPLACE FUNCTION log_operacoes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO logs (operacao, tabela, usuario, descricao)
        VALUES ('INSERT', TG_TABLE_NAME, current_user, 'Inserção de um registro' || NEW);
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO logs (operacao, tabela, usuario, descricao)
        VALUES ('UPDATE', TG_TABLE_NAME, current_user, 'Atualização de um registro' || NEW);
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO logs (operacao, tabela, usuario, descricao)
        VALUES ('DELETE', TG_TABLE_NAME, current_user, 'Remoção de um registro' || OLD);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers que chamam a função log_operacoes para todas as tabelas (Jogadores, Treinadores, Partidas, Times, Escalacoes, Jogadores_Times, Jogadores_Escalacoes)
CREATE TRIGGER trg_log_jogadores
AFTER INSERT OR UPDATE OR DELETE
ON Jogadores
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();

CREATE TRIGGER trg_log_treinadores
AFTER INSERT OR UPDATE OR DELETE
ON Treinadores
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();

CREATE TRIGGER trg_log_partidas
AFTER INSERT OR UPDATE OR DELETE
ON Partidas
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();

CREATE TRIGGER trg_log_times
AFTER INSERT OR UPDATE OR DELETE
ON Times
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();

CREATE TRIGGER trg_log_escalacoes
AFTER INSERT OR UPDATE OR DELETE
ON Escalacoes
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();

CREATE TRIGGER trg_log_jogadores_times
AFTER INSERT OR UPDATE OR DELETE
ON Jogadores_Times
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();

CREATE TRIGGER trg_log_jogadores_escalacoes
AFTER INSERT OR UPDATE OR DELETE
ON Jogadores_Escalacoes
FOR EACH ROW
EXECUTE FUNCTION log_operacoes();