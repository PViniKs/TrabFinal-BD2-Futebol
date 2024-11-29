-- Criação dos grupos de usuários
CREATE ROLE admin;
CREATE ROLE presidenteClube;
CREATE ROLE arbitro;
CREATE ROLE treinador;
CREATE ROLE jogador;
CREATE ROLE torcedor;

-- Concessão de permissões aos grupos
GRANT USAGE ON SCHEMA public TO admin, presidenteClube, arbitro, treinador, jogador, torcedor;

GRANT ALL PRIVILEGES ON DATABASE futebol TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Times, Treinadores, Jogadores TO presidenteClube;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Partidas TO arbitro;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Escalacoes, Jogadores_Escalacoes TO treinador;
GRANT SELECT ON TABLE Jogadores, Times, Partidas TO jogador;
GRANT SELECT ON TABLE Times, Partidas TO torcedor;

-- Criação dos usuários
CREATE USER administrador WITH ENCRYPTED PASSWORD '4dm1n';
CREATE USER rLandim WITH ENCRYPTED PASSWORD 'fl4m3ng0'; -- Rodolfo Landim
CREATE USER fLuis WITH ENCRYPTED PASSWORD 'luis+85'; -- Filipe Luis
CREATE USER aDaronco WITH ENCRYPTED PASSWORD 'best4rb1tr0'; -- Anderson Daronco
CREATE USER gBarbosa WITH ENCRYPTED PASSWORD 'gab1g0l'; -- Gabriel Barbosa
CREATE USER zeDoBar WITH ENCRYPTED PASSWORD 'z3c4'; -- Seu Zé (todo bar tem um Zé)

-- Insersão dos usuários nos grupos
GRANT admin TO administrador;
GRANT presidenteClube TO rLandim;
GRANT arbitro TO aDaronco;
GRANT treinador TO fLuis;
GRANT jogador TO gBarbosa;
GRANT torcedor TO zeDoBar;