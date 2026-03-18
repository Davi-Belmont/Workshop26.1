-- 1. criando schema

CREATE SCHEMA DESAFIO;
USE DESAFIO

-- 2. Criando Tabelas

CREATE TABLE clientes (
clienteID INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
cidade VARCHAR(20) NOT NULL
);

CREATE TABLE pedidos (
pedidoID INT PRIMARY KEY AUTO_INCREMENT,
clienteID INT,
data DATE NOT NULL,
valor FLOAT (10,2) NOT NULL,
FOREIGN KEY (clienteID) REFERENCES clientes(clienteID)
)

-- 3. Inserindo Dados

INSERT INTO clientes (nome,cidade) 
VALUES
('Ana Silva', 'São Paulo'),
('Bruno Oliveira', 'Rio de Janeiro'),
('Carla Souza', 'Belo Horizonte'),
('Diego Santos', 'Curitiba'),
('Elena Pires', 'Porto Alegre'),
('Fabio Costa', 'Salvador'),
('Gisele Almeida', 'Fortaleza'),
('Hugo Ferreira', 'Manaus'),
('Igor Meireles', 'Brasília'),
('Julia Ramos', 'Recife');

INSERT INTO Pedidos (clienteID, data, valor) 
VALUES 
(1, '2023-10-01', 250.00),  
(1, '2023-10-05', 300.50),
(2, '2023-10-02', 150.00), 
(3, '2023-10-10', 800.00), 
(4, '2023-10-12', 120.00), 
(5, '2023-10-15', 450.00), 
(6, '2023-10-15', 90.00), 
(2, '2023-10-20', 200.00), 
(7, '2023-10-21', 600.00), 
(8, '2023-10-22', 50.00)

-- 4.1 Executando Consultas

-- um DQL
SELECT clientes.nome,
-- tres funcoes agregadas
    COUNT(pedidos.pedidoID) AS total_pedidos,
    SUM(pedidos.valor) AS soma_total,
    AVG(pedidos.valor) AS media_valor
FROM  clientes

-- um JOIN

INNER JOIN pedidos ON clientes.clienteID = pedidos.clienteID

-- dois agrupamentos
GROUP BY cliente.nome
HAVING SUM (pedido.valor) > 500;

-- 4.2 Atualizando Dados

-- um DML
UPDATE pedidos SET valor = 200.00 WHERE pedidoID = 101
