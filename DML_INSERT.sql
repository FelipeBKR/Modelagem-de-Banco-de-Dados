-- Script SQL com comandos de INSERT para popular as tabelas principais.

-- Inserção de dados na tabela USUARIO
INSERT INTO USUARIO (ID_Usuario, Nome, Matricula, Tipo, Endereco, Telefone, Email) VALUES
(1, 'Ana Silva', '2023001', 'Estudante', 'Rua A, 101', '9999-1111', 'ana.silva@uni.edu'),
(2, 'Bruno Costa', '2023002', 'Professor', 'Av. B, 202', '9999-2222', 'bruno.costa@uni.edu'),
(3, 'Carla Dias', '2023003', 'Estudante', 'Rua C, 303', '9999-3333', 'carla.dias@uni.edu'),
(4, 'Daniela Alves', '2023004', 'Estudante', 'Rua D, 404', '9999-4444', 'daniela.alves@uni.edu');

-- Inserção de dados na tabela MATERIAL
INSERT INTO MATERIAL (ID_Material, Titulo, Autor, ISBN, Edicao, Ano) VALUES
(101, 'Introdução a Banco de Dados', 'C.J. Date', '978-8575224353', 8, 2018),
(102, 'Algoritmos e Estruturas de Dados', 'Thomas H. Cormen', '978-8535236577', 3, 2009),
(103, 'Redes de Computadores', 'Andrew S. Tanenbaum', '978-8543004888', 5, 2011),
(104, 'Engenharia de Software', 'Roger S. Pressman', '978-8580550537', 7, 2011);

-- Inserção de dados na tabela EXEMPLAR
INSERT INTO EXEMPLAR (ID_Exemplar, ID_Material, Localizacao, Status_Exemplar) VALUES
(1001, 101, 'Estante 1A', 'Disponivel'),
(1002, 101, 'Estante 1A', 'Emprestado'),
(1003, 102, 'Estante 2B', 'Disponivel'),
(1004, 103, 'Estante 3C', 'Disponivel'),
(1005, 104, 'Estante 4D', 'Emprestado');

-- Inserção de dados na tabela EMPRESTIMO
INSERT INTO EMPRESTIMO (ID_Emprestimo, ID_Usuario, ID_Exemplar, Data_Emprestimo, Data_Devolucao_Prevista, Data_Devolucao_Real, Status_Emprestimo) VALUES
(1, 1, 1002, '2025-11-20', '2025-12-05', NULL, 'Ativo'),
(2, 2, 1005, '2025-11-15', '2025-11-30', '2025-11-28', 'Devolvido'),
(3, 3, 1001, '2025-11-10', '2025-11-25', NULL, 'Atrasado');

-- Inserção de dados na tabela RESERVA
INSERT INTO RESERVA (ID_Reserva, ID_Usuario, ID_Material, Data_Reserva, Posicao_Fila, Status_Reserva) VALUES
(1, 4, 101, '2025-11-22', 1, 'Ativa'),
(2, 3, 103, '2025-11-25', 1, 'Ativa');

-- Inserção de dados na tabela MULTA
INSERT INTO MULTA (ID_Multa, ID_Usuario, ID_Emprestimo, Valor, Data_Geracao, Status_Pagamento) VALUES
(1, 3, 3, 15.00, '2025-11-26', 'Pendente');
