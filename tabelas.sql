/* logico: */

-- Tabela Pessoas
CREATE TABLE Pessoas (
    idPessoa SERIAL PRIMARY KEY UNIQUE,
    dataNascimento DATE,
    nome VARCHAR(50),
    cpf VARCHAR(11) UNIQUE
);

-- Tabela Treinadores herda de Pessoas
CREATE TABLE Treinadores () INHERITS (Pessoas);

-- Tabela Jogadores herda de Pessoas
CREATE TABLE Jogadores (
    numeroCamisa INT DEFAULT -1,
    posicao VARCHAR(15) DEFAULT 'indefinida'
) INHERITS (Pessoas);

-- Tabela Times
CREATE TABLE Times (
    idTime SERIAL PRIMARY KEY,
    nomeTime VARCHAR(50),
    idTreinador SERIAL UNIQUE
);

-- Tabela Escalacoes
CREATE TABLE Escalacoes (
    idEscalacao SERIAL PRIMARY KEY UNIQUE,
    idTime SERIAL,
    formacao VARCHAR(10)
);

-- Tabela Partidas
CREATE TABLE Partidas (
    idPartida SERIAL PRIMARY KEY UNIQUE,
    timeCasa SERIAL,
    timeVisitante SERIAL,
    escalacaoCasa SERIAL,
    escalacaoVisitante SERIAL,
    golsCasa INT DEFAULT 0,
    golsVisitante INT DEFAULT 0,
    data DATE,
    horario TIME,
    local VARCHAR(20)
);

-- Tabela de relacionamento entre Jogadores e Times
CREATE TABLE Jogadores_Times (
    idJogador SERIAL PRIMARY KEY UNIQUE,
    idTime SERIAL
);

-- Tabela de relacionamento entre Jogadores e Escalacoes
CREATE TABLE Jogadores_Escalacoes (
    idJogador SERIAL PRIMARY KEY,
    idEscalacao SERIAL,
    titular BOOLEAN
);

-- Constraints de chaves estrangeiras
ALTER TABLE Treinadores ADD CONSTRAINT UQ_Treinadores_idPessoa UNIQUE (idPessoa);
ALTER TABLE Treinadores ADD CONSTRAINT UQ_Treinadores_cpf UNIQUE (cpf);

ALTER TABLE Jogadores ADD CONSTRAINT UQ_Jogadores_idPessoa UNIQUE (idPessoa);
ALTER TABLE Jogadores ADD CONSTRAINT UQ_Jogadores_cpf UNIQUE (cpf);

ALTER TABLE Times ADD CONSTRAINT FK_Times_2
    FOREIGN KEY (idTreinador)
    REFERENCES Treinadores (idPessoa);

ALTER TABLE Escalacoes ADD CONSTRAINT FK_Escalacoes_2
    FOREIGN KEY (idTime)
    REFERENCES Times (idTime);
    
ALTER TABLE Partidas ADD CONSTRAINT FK_Partidas_timeCasa
    FOREIGN KEY (timeCasa)
    REFERENCES Times (idTime);

ALTER TABLE Partidas ADD CONSTRAINT FK_Partidas_timeVisitante
    FOREIGN KEY (timeVisitante)
    REFERENCES Times (idTime);

ALTER TABLE Partidas ADD CONSTRAINT FK_Partidas_escalacaoCasa
    FOREIGN KEY (escalacaoCasa)
    REFERENCES Escalacoes (idEscalacao);

ALTER TABLE Partidas ADD CONSTRAINT FK_Partidas_escalacaoVisitante
    FOREIGN KEY (escalacaoVisitante)
    REFERENCES Escalacoes (idEscalacao);
    
ALTER TABLE Jogadores_Times ADD CONSTRAINT FK_Jogadores_Times_1
    FOREIGN KEY (idJogador)
    REFERENCES Jogadores (idPessoa);
    
ALTER TABLE Jogadores_Times ADD CONSTRAINT FK_Jogadores_Times_2
    FOREIGN KEY (idTime)
    REFERENCES Times (idTime);
    
ALTER TABLE Jogadores_Escalacoes ADD CONSTRAINT FK_Jogadores_Escalacoes_2
    FOREIGN KEY (idJogador)
    REFERENCES Jogadores (idPessoa);
    
ALTER TABLE Jogadores_Escalacoes ADD CONSTRAINT FK_Jogadores_Escalacoes_3
    FOREIGN KEY (idEscalacao)
    REFERENCES Escalacoes (idEscalacao);