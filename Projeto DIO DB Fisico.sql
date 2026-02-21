CREATE DATABASE oficina;
USE oficina;

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(100),
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Mecanico (
    id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    especialidade VARCHAR(100),
    salario DECIMAL(10,2)
);

CREATE TABLE OrdemServico (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    data_abertura DATE,
    data_fechamento DATE,
    status VARCHAR(50),
    id_veiculo INT,
    id_mecanico INT,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico)
);

CREATE TABLE Servico (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100),
    valor DECIMAL(10,2)
);

CREATE TABLE OS_Servico (
    id_os INT,
    id_servico INT,
    quantidade INT,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

INSERT INTO Cliente (nome, telefone, email) VALUES
('Carlos Silva', '99999-1111', 'carlos@email.com'),
('Ana Souza', '98888-2222', 'ana@email.com');

INSERT INTO Veiculo (placa, modelo, ano, id_cliente) VALUES
('ABC1234', 'Gol', 2018, 1),
('XYZ9876', 'Onix', 2020, 2);

INSERT INTO Mecanico (nome, especialidade, salario) VALUES
('João Mecânico', 'Motor', 3000.00),
('Pedro Técnico', 'Suspensão', 2800.00);

INSERT INTO Servico (descricao, valor) VALUES
('Troca de Óleo', 150.00),
('Alinhamento', 200.00),
('Revisão Completa', 500.00);

INSERT INTO OrdemServico (data_abertura, data_fechamento, status, id_veiculo, id_mecanico) VALUES
('2026-02-01', '2026-02-02', 'Finalizada', 1, 1),
('2026-02-05', NULL, 'Em andamento', 2, 2);

INSERT INTO OS_Servico VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1);

-- 1. Quais são todos os clientes cadastrados?

SELECT * FROM Cliente;

-- 2. Quais ordens de serviço estão em andamento?

SELECT * 
FROM OrdemServico
WHERE status = 'Em andamento';

-- 3. Qual o valor total de cada ordem de serviço?

SELECT os.id_os,
       SUM(s.valor * oss.quantidade) AS valor_total
FROM OrdemServico os
JOIN OS_Servico oss ON os.id_os = oss.id_os
JOIN Servico s ON oss.id_servico = s.id_servico
GROUP BY os.id_os;

-- 4. Quais clientes ordenados por nome?

SELECT nome, telefone
FROM Cliente
ORDER BY nome ASC;

-- 5. Qual mecânico realizou serviços que somam mais de R$300?

SELECT m.nome,
       SUM(s.valor * oss.quantidade) AS total_servicos
FROM Mecanico m
JOIN OrdemServico os ON m.id_mecanico = os.id_mecanico
JOIN OS_Servico oss ON os.id_os = oss.id_os
JOIN Servico s ON oss.id_servico = s.id_servico
GROUP BY m.nome
HAVING total_servicos > 300;

-- 6. Quais clientes e seus respectivos veículos?

SELECT c.nome AS cliente,
       v.modelo,
       v.placa
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente;

-- 7. Quantas ordens cada mecânico realizou?

SELECT m.nome,
       COUNT(os.id_os) AS total_ordens
FROM Mecanico m
LEFT JOIN OrdemServico os ON m.id_mecanico = os.id_mecanico
GROUP BY m.nome
ORDER BY total_ordens DESC;