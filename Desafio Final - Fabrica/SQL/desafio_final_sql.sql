
-- 1. DEFINIÇÃO E CRIAÇÃO DO BANCO DE DADOS (DDL)

CREATE DATABASE Concessionaria_VelozCar;
USE Concessionaria_VelozCar;

-- Tabela Categoria
CREATE TABLE Categoria (
    ID_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Grupo VARCHAR(50) NOT NULL,
    Valor_Diario DECIMAL(10,2) NOT NULL,
    Transmissao VARCHAR(20),
    Tipo VARCHAR(30),
    Tamanho_Mala CHAR(1),
    Cap_Passageiro INT,
    Porta INT
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(7) NOT NULL UNIQUE,
    Ano_Fabricacao INT NOT NULL,
    Cor VARCHAR(20),
    Modelo VARCHAR(50) NOT NULL,
    Marca VARCHAR(30) NOT NULL,
    Status_Veiculo VARCHAR(20) DEFAULT 'Disponivel',
    fk_Categoria_ID_Categoria INT,
    FOREIGN KEY (fk_Categoria_ID_Categoria) REFERENCES Categoria(ID_Categoria)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Endereco VARCHAR(200),
    Telefone VARCHAR(15),
    data_cadastro DATE,
    Numero_CNH VARCHAR(15) NOT NULL UNIQUE
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    ID_Funcionario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Matricula VARCHAR(20) NOT NULL UNIQUE,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Cargo VARCHAR(50),
    Data_Admissao DATE,
    Login_Sistema VARCHAR(30) UNIQUE,
    Senha_Hash VARCHAR(255)
);

-- Tabela Reserva
CREATE TABLE Reserva (
    ID_Reserva INT PRIMARY KEY AUTO_INCREMENT,
    Data_Reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Prevista_Retirada DATETIME NOT NULL,
    Status_Reserva VARCHAR(20) DEFAULT 'Pendente',
    fk_Cliente_ID_Cliente INT,
    fk_Funcionario_ID_Funcionario INT,
    fk_Categoria_ID_Categoria INT,
    FOREIGN KEY (fk_Cliente_ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (fk_Funcionario_ID_Funcionario) REFERENCES Funcionario(ID_Funcionario),
    FOREIGN KEY (fk_Categoria_ID_Categoria) REFERENCES Categoria(ID_Categoria)
);

-- Tabela Registro_aluguel
CREATE TABLE Registro_aluguel (
    ID_Registro_Aluguel INT PRIMARY KEY AUTO_INCREMENT,
    Data_Inicio DATETIME NOT NULL,
    Data_Prevista_Devolucao DATETIME NOT NULL,
    Data_Devolucao_Real DATETIME,
    Valor_Total_Estimado DECIMAL(10,2),
    Status_Registro_Aluguel VARCHAR(20) DEFAULT 'Ativo',
    fk_Cliente_ID_Cliente INT,
    fk_Veiculo_ID_Veiculo INT,
    fk_Funcionario_ID_Funcionario INT,
    fk_Reserva_ID_Reserva INT,
    FOREIGN KEY (fk_Cliente_ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (fk_Funcionario_ID_Funcionario) REFERENCES Funcionario(ID_Funcionario),
    FOREIGN KEY (fk_Reserva_ID_Reserva) REFERENCES Reserva(ID_Reserva)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    ID_Pagamento INT PRIMARY KEY AUTO_INCREMENT,
    Data_Vencimento DATE,
    Data_Pagamento DATETIME,
    Valor_Total_Pago DECIMAL(10,2),
    Metodo VARCHAR(30),
    Status_Pagamento VARCHAR(20),
    fk_Registro_aluguel_ID_Registro_Aluguel INT,
    fk_Funcionario_ID_Funcionario INT,
    FOREIGN KEY (fk_Registro_aluguel_ID_Registro_Aluguel) REFERENCES Registro_aluguel(ID_Registro_Aluguel),
    FOREIGN KEY (fk_Funcionario_ID_Funcionario) REFERENCES Funcionario(ID_Funcionario)
);

-- Tabela Manutencao
CREATE TABLE Manutencao (
    ID_Manutencao INT PRIMARY KEY AUTO_INCREMENT,
    Data_Entrada DATETIME NOT NULL,
    Km_Na_Manutencao INT,
    Custo_Total DECIMAL(10,2),
    Descricao_Problema TEXT,
    Status_Servico VARCHAR(20),
    fk_Veiculo_ID_Veiculo INT,
    fk_Funcionario_ID_Funcionario INT,
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (fk_Funcionario_ID_Funcionario) REFERENCES Funcionario(ID_Funcionario)
);


-- 2. INSERÇÃO E MANIPULAÇÃO DE DADOS (DML)

-- Inserindo Categorias 
INSERT INTO Categoria (Nome_Grupo, Valor_Diario, Transmissao, Tipo, Tamanho_Mala, Cap_Passageiro, Porta) VALUES
('Econômico', 85.00, 'Manual', 'Hatch', 'P', 5, 4),
('Econômico Plus', 110.00, 'Manual', 'Sedan', 'M', 5, 4),
('Intermediário', 145.00, 'Manual', 'Sedan', 'M', 5, 4),
('Intermediário Auto', 170.00, 'Automático', 'Hatch', 'P', 5, 4),
('SUV Compacto', 210.00, 'Automático', 'SUV', 'M', 5, 4),
('SUV Premium', 350.00, 'Automático', 'SUV', 'G', 7, 4),
('Luxo Sport', 600.00, 'Automático', 'Conversível', 'P', 2, 2),
('Executivo', 450.00, 'Automático', 'Sedan Premium', 'G', 5, 4),
('Minivan Family', 280.00, 'Automático', 'Minivan', 'G', 7, 4),
('Utilitário Carga', 190.00, 'Manual', 'Furgão', 'G', 2, 2),
('Pick-up 4x4', 320.00, 'Automático', 'Pick-up', 'G', 5, 4),
('Híbrido Eco', 250.00, 'Automático', 'Hatch', 'M', 5, 4);


-- Inserindo Veículos
INSERT INTO Veiculo (Placa, Ano_Fabricacao, Cor, Modelo, Marca, Status_Veiculo, fk_Categoria_ID_Categoria) VALUES

('BRA2E19', 2023, 'Branco', 'Argo', 'Fiat', 'Disponível', 1),
('KLA4J55', 2022, 'Prata', 'Mobi', 'Fiat', 'Alugado', 1),
('HPX9012', 2023, 'Preto', 'Cronos', 'Fiat', 'Disponível', 2),
('RWS3A44', 2022, 'Cinza', 'HB20S', 'Hyundai', 'Manutenção', 2),
('OPI1122', 2021, 'Branco', 'Virtus', 'Volkswagen', 'Disponível', 3),
('GHT5566', 2023, 'Azul', 'Polo', 'Volkswagen', 'Alugado', 4),
('JJK7788', 2024, 'Prata', 'Nivus', 'Volkswagen', 'Disponível', 5),
('LOU0011', 2023, 'Preto', 'Commander', 'Jeep', 'Disponível', 6),
('ZZX9900', 2022, 'Vermelho', 'Z4', 'BMW', 'Disponível', 7),
('EBT4455', 2023, 'Preto', 'Série 5', 'BMW', 'Alugado', 8),
('FAM8811', 2021, 'Branco', 'Carnival', 'Kia', 'Disponível', 9),
('FUR2233', 2022, 'Branco', 'Master', 'Renault', 'Manutenção', 10),
('PKP5566', 2024, 'Cinza', 'Hilux', 'Toyota', 'Disponível', 11),
('ECO0012', 2024, 'Verde', 'Leaf', 'Nissan', 'Disponível', 12),
('BRB6B66', 2023, 'Branco', 'Onix', 'Chevrolet', 'Disponível', 1);


-- Insririndo Clientes

INSERT INTO Cliente (Nome, CPF, Email, Endereco, Telefone, data_cadastro, Numero_CNH) VALUES
('Carlos Oliveira', '12345678901', 'carlos.o@email.com', 'Av. Epitácio Pessoa, 100, João Pessoa', '83988776655', '2026-01-10', '12345678901'),
('Ana Beatriz Silva', '23456789012', 'ana.bs@email.com', 'Rua das Flores, 50, Campina Grande', '83999887766', '2026-01-15', '23456789012'),
('Marcos Souza', '34567890123', 'marcos.s@email.com', 'Rua Manoel Deodato, 12, João Pessoa', '83987654321', '2026-02-01', '34567890123'),
('Juliana Costa', '45678901234', 'ju.costa@email.com', 'Av. Cabo Branco, 200, João Pessoa', '83912345678', '2026-02-05', '45678901234'),
('Ricardo Pereira', '56789012345', 'ricardo.p@email.com', 'Rua Bessa, 300, João Pessoa', '83911223344', '2026-02-10', '56789012345'),
('Fernanda Lima', '67890123456', 'fernanda.l@email.com', 'Rua Tambaú, 15, João Pessoa', '83955667788', '2026-02-15', '67890123456'),
('Paulo Roberto', '78901234567', 'paulo.r@email.com', 'Rua do Sol, 99, Santa Rita', '83944332211', '2026-02-20', '78901234567'),
('Camila Mendes', '89012345678', 'camila.m@email.com', 'Rua da Paz, 44, Cabedelo', '83977889900', '2026-02-25', '89012345678'),
('Lucas Gabriel', '90123456789', 'lucas.g@email.com', 'Rua Verde, 123, João Pessoa', '83966554433', '2026-03-01', '90123456789'),
('Patrícia Nunes', '01234567890', 'patricia.n@email.com', 'Rua das Palmeiras, 8, João Pessoa', '83933221100', '2026-03-05', '01234567890'),
('Gabriel Santos', '11223344556', 'gabriel.s@email.com', 'Rua da Areia, 90, João Pessoa', '83922334455', '2026-03-08', '11223344556'),
('Renata Rocha', '22334455667', 'renata.r@email.com', 'Rua Nova, 500, Bayeux', '83911122233', '2026-03-10', '22334455667'),
('Felipe Dantas', '33445566778', 'felipe.d@email.com', 'Rua Direita, 10, Cabedelo', '83944455566', '2026-03-12', '33445566778'),
('Bruna Carvalho', '44556677889', 'bruna.c@email.com', 'Rua Esperança, 77, João Pessoa', '83977788899', '2026-03-15', '44556677889'),
('Davi Souza', '55667788990', 'davi.s@email.com', 'Av. Unipê, 1000, João Pessoa', '83988899900', '2026-03-18', '55667788990');


-- Insirindo Funcionarios

INSERT INTO Funcionario (Nome, Matricula, CPF, Cargo, Data_Admissao, Login_Sistema, Senha_Hash) VALUES
('João Vendedor', 'MAT001', '10120230344', 'Atendente Senior', '2025-01-01', 'joao.veloz', 'hash_seguro_1'),
('Maria Silva', 'MAT002', '20230340455', 'Gerente', '2025-01-01', 'maria.gerente', 'hash_seguro_2'),
('Pedro Souza', 'MAT003', '30340450566', 'Atendente Junior', '2025-06-01', 'pedro.vendas', 'hash_seguro_3'),
('Alice Lima', 'MAT004', '40450560677', 'Atendente Junior', '2025-08-15', 'alice.vendas', 'hash_seguro_4'),
('Bruno Melo', 'MAT005', '50560670788', 'Atendente Senior', '2025-10-20', 'bruno.senior', 'hash_seguro_5'),
('Clara Luz', 'MAT006', '60670780899', 'Supervisor', '2025-11-01', 'clara.supervisor', 'hash_seguro_6'),
('Diego Faro', 'MAT007', '70780890911', 'Mecânico Chefe', '2025-01-10', 'diego.mecanica', 'hash_seguro_7'),
('Elena Rios', 'MAT008', '80890910122', 'Atendente Senior', '2026-01-05', 'elena.vendas', 'hash_seguro_8'),
('Fabio Junior', 'MAT009', '90910120233', 'Atendente Junior', '2026-01-15', 'fabio.atendimento', 'hash_seguro_9'),
('Gisele B', 'MAT010', '11122233344', 'Auxiliar de Limpeza', '2026-02-01', 'gisele.limpeza', 'hash_seguro_10'),
('Hugo Boss', 'MAT011', '22233344455', 'Vendedor', '2026-02-10', 'hugo.vendedor', 'hash_seguro_11'),
('Igor Guia', 'MAT012', '33344455566', 'Atendente Junior', '2026-02-20', 'igor.vendas', 'hash_seguro_12'),
('Julia Meire', 'MAT013', '44455566677', 'Supervisor', '2026-03-01', 'julia.supervisor', 'hash_seguro_13'),
('Katia Abreu', 'MAT014', '55566677788', 'Atendente Senior', '2026-03-10', 'katia.vendas', 'hash_seguro_14'),
('Luís Inácio', 'MAT015', '66677788899', 'Gerente de Frota', '2026-03-15', 'luis.frota', 'hash_seguro_15');

-- Inserindo Registro de Aluguel

INSERT INTO Registro_aluguel (Data_Inicio, Data_Prevista_Devolucao, Data_Devolucao_Real, Valor_Total_Estimado, Status_Registro_Aluguel, fk_Cliente_ID_Cliente, fk_Veiculo_ID_Veiculo, fk_Funcionario_ID_Funcionario) VALUES
('2026-03-01 08:00:00', '2026-03-05 08:00:00', '2026-03-05 09:30:00', 450.00, 'Finalizado', 1, 1, 1),
('2026-03-02 10:00:00', '2026-03-10 10:00:00', '2026-03-10 10:15:00', 1200.00, 'Finalizado', 2, 2, 2),
('2026-03-05 14:00:00', '2026-03-07 14:00:00', '2026-03-07 13:00:00', 290.00, 'Finalizado', 3, 3, 3),
('2026-03-10 09:00:00', '2026-03-15 09:00:00', NULL, 750.00, 'Ativo', 4, 4, 4),
('2026-03-12 11:30:00', '2026-03-14 11:30:00', '2026-03-14 12:00:00', 420.00, 'Finalizado', 5, 5, 5),
('2026-03-15 08:00:00', '2026-03-20 08:00:00', NULL, 850.00, 'Ativo', 6, 6, 8),
('2026-03-16 10:00:00', '2026-03-18 10:00:00', '2026-03-18 09:45:00', 420.00, 'Finalizado', 7, 7, 9),
('2026-03-17 15:00:00', '2026-03-22 15:00:00', NULL, 1750.00, 'Ativo', 8, 8, 11),
('2026-03-18 07:30:00', '2026-03-19 07:30:00', '2026-03-19 08:00:00', 600.00, 'Finalizado', 9, 9, 12),
('2026-03-19 13:00:00', '2026-03-25 13:00:00', NULL, 2700.00, 'Ativo', 10, 10, 13),
('2026-03-20 09:00:00', '2026-03-21 09:00:00', NULL, 280.00, 'Ativo', 11, 11, 14),
('2026-03-21 10:00:00', '2026-03-23 10:00:00', NULL, 380.00, 'Ativo', 12, 12, 1),
('2026-03-21 11:00:00', '2026-03-25 11:00:00', NULL, 1280.00, 'Ativo', 13, 13, 2),
('2026-03-21 14:00:00', '2026-03-22 14:00:00', NULL, 250.00, 'Ativo', 14, 14, 3),
('2026-03-21 16:00:00', '2026-03-23 16:00:00', NULL, 170.00, 'Ativo', 15, 15, 8);


-- Inserindo Pagamentos

INSERT INTO Pagamento (Data_Vencimento, Data_Pagamento, Valor_Total_Pago, Metodo, Status_Pagamento, fk_Registro_aluguel_ID_Registro_Aluguel, fk_Funcionario_ID_Funcionario) VALUES
('2026-03-05', '2026-03-05 09:40:00', 450.00, 'Cartão de Crédito', 'Pago', 1, 1),
('2026-03-10', '2026-03-10 10:30:00', 1200.00, 'Pix', 'Pago', 2, 2),
('2026-03-07', '2026-03-07 13:10:00', 290.00, 'Dinheiro', 'Pago', 3, 3),
('2026-03-15', NULL, 750.00, 'Cartão de Crédito', 'Pendente', 4, 4),
('2026-03-14', '2026-03-14 12:15:00', 420.00, 'Pix', 'Pago', 5, 5),
('2026-03-20', NULL, 850.00, 'Cartão de Débito', 'Pendente', 6, 8),
('2026-03-18', '2026-03-18 10:00:00', 420.00, 'Pix', 'Pago', 7, 9),
('2026-03-22', NULL, 1750.00, 'Cartão de Crédito', 'Pendente', 8, 11),
('2026-03-19', '2026-03-19 08:10:00', 600.00, 'Dinheiro', 'Pago', 9, 12),
('2026-03-25', NULL, 2700.00, 'Pix', 'Pendente', 10, 13),
('2026-03-21', '2026-03-20 18:00:00', 280.00, 'Pix', 'Pago', 11, 14),
('2026-03-23', NULL, 380.00, 'Cartão de Crédito', 'Pendente', 12, 1),
('2026-03-25', '2026-03-21 11:15:00', 1280.00, 'Transferência', 'Pago', 13, 2),
('2026-03-22', NULL, 250.00, 'Dinheiro', 'Pendente', 14, 3),
('2026-03-23', '2026-03-21 16:05:00', 170.00, 'Pix', 'Pago', 15, 8);

-- Inserido Reserva

INSERT INTO Reserva (Data_Reserva, Data_Prevista_Retirada, Status_Reserva, fk_Categoria_ID_Categoria, fk_Cliente_ID_Cliente, fk_Funcionario_ID_Funcionario) VALUES
('2026-03-01 10:00:00', '2026-03-05 08:00:00', 'Finalizada', 1, 1, 1),
('2026-03-01 14:30:00', '2026-03-10 10:00:00', 'Finalizada', 2, 2, 2),
('2026-03-02 09:00:00', '2026-03-07 14:00:00', 'Finalizada', 3, 3, 3),
('2026-03-05 11:00:00', '2026-03-15 09:00:00', 'Confirmada', 1, 4, 4),
('2026-03-08 16:20:00', '2026-03-14 11:30:00', 'Finalizada', 2, 5, 5),
('2026-03-10 10:00:00', '2026-03-20 08:00:00', 'Confirmada', 4, 6, 8),
('2026-03-12 13:45:00', '2026-03-18 10:00:00', 'Finalizada', 5, 7, 9),
('2026-03-14 08:00:00', '2026-03-22 15:00:00', 'Confirmada', 6, 8, 11),
('2026-03-15 17:30:00', '2026-03-19 07:30:00', 'Finalizada', 7, 9, 12),
('2026-03-16 11:00:00', '2026-03-25 13:00:00', 'Confirmada', 8, 10, 13),
('2026-03-17 09:15:00', '2026-03-21 09:00:00', 'Confirmada', 9, 11, 14),
('2026-03-18 14:00:00', '2026-03-23 10:00:00', 'Confirmada', 10, 12, 1),
('2026-03-19 10:30:00', '2026-03-25 11:00:00', 'Confirmada', 11, 13, 2),
('2026-03-20 15:00:00', '2026-03-22 14:00:00', 'Pendente', 12, 14, 3),
('2026-03-21 08:20:00', '2026-03-23 16:00:00', 'Pendente', 1, 15, 8);



-- 2.3. Atualizações (UPDATE)
UPDATE Veiculo SET Status = 'Disponível' WHERE Placa = 'OPI1122';
UPDATE Categoria SET Valor_Diario = Valor_Diario * 1.10 WHERE Nome_Grupo = 'SUV';


-- 3. CONSULTAS E ANÁLISES (DQL)

-- 3.1. Agregações e Agrupamentos

-- Média de valor de diária por tipo de transmissão
SELECT Transmissao, AVG(Valor_Diario) as Media_Diaria 
FROM Categoria 
GROUP BY Transmissao;

-- Contagem de veículos por status
SELECT Status, COUNT(*) as Total_Veiculos 
FROM Veiculo 
GROUP BY Status;

-- 3.2. Operações de JOIN

-- JOIN 1: Ver quais veículos pertencem a quais categorias
SELECT V.Modelo, V.Placa, C.Nome_Grupo, C.Valor_Diario
FROM Veiculo V
INNER JOIN Categoria C ON V.fk_Categoria_ID_Categoria = C.ID_Categoria;

-- JOIN 2: Relatório de Aluguel com nome do Cliente e do Funcionário
SELECT R.ID_Registro_Aluguel, CL.Nome as Cliente, F.Nome as Atendente, R.Data_Inicio
FROM Registro_aluguel R
INNER JOIN Cliente CL ON R.fk_Cliente_ID_Cliente = CL.ID_Cliente
INNER JOIN Funcionario F ON R.fk_Funcionario_ID_Funcionario = F.ID_Funcionario;

-- JOIN 3: Histórico de manutenções por veículo
SELECT V.Placa, V.Modelo, M.Descricao_Problema, M.Custo_Total
FROM Veiculo V
LEFT JOIN Manutencao M ON V.ID_Veiculo = M.fk_Veiculo_ID_Veiculo;