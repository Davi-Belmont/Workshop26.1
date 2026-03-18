# Desafio SQL 
Este projeto consiste em na criação e manipulação de um banco de dados relacional para gerenciar clientes e seus pedidos, aplicando conceito fundamentais de SQL como DDL, DML, DQL, JOIN e funções de agrupamento.
## Estrutura do Desafio

O script está dividido em 4 etapas:
1. **Definição do Schema:** Criação do ambiente isolado.
2. **Modelagem de Dados:** Criação das tabelas com chaves primárias e estrangeiras.
3. **População do Banco:** Inserção de dados fictícios para testes.
4. **Análise de Dados:** Execução de consultas complexas e manipulação de registros.

## 1. Criando Banco de Dados (SCHEMA)
Criando um schema denominado `DESAFIO`.
```SQL
CREATE SCHEMA DESAFIO;
USE DESAFIO
```

## 2. Criação das tabelas
Criando as tabelas `clientes` e `pedidios` com chaves primarias e chave estrangeira.
```SQL
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
```

## 3. Inserir Dados
Inserindo 10 registros em cada tabela.
```SQL
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
```
## 4.1 - Executando Consultas
Execute **1** comando de **DML (UPDATE ou DELETE), 1** de **DQL (SELECT), 3** funções **Agregadas**, **2** de **Agrupamento** e **1 JOIN**.
```SQL
SELECT 
    clientes.nome,
    COUNT(pedidos.pedidoID) AS total_pedidos,
    SUM(pedidos.valor) AS soma_total,
    AVG(pedidos.valor) AS media_valor
FROM clientes
INNER JOIN pedidos ON clientes.clienteID = pedidos.clienteID
GROUP BY clientes.nome
HAVING SUM(pedidos.valor) > 500;
```

## 4.2 - Atualizando Dados
Ajustando o valor de um registro especifico.
```SQL
UPDATE pedidos SET valor = 200.00 WHERE pedidoID = 101
```
