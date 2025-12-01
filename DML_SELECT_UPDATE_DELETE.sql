-- Script SQL com comandos SELECT, UPDATE e DELETE.

-- ** CONSULTAS (SELECT) **

-- 1. Consulta com WHERE e ORDER BY: Listar todos os empréstimos ativos, ordenados pela data de devolução prevista.
SELECT 
    E.ID_Emprestimo,
    U.Nome AS Nome_Usuario,
    M.Titulo AS Titulo_Material,
    E.Data_Emprestimo,
    E.Data_Devolucao_Prevista
FROM 
    EMPRESTIMO E
JOIN 
    USUARIO U ON E.ID_Usuario = U.ID_Usuario
JOIN 
    EXEMPLAR X ON E.ID_Exemplar = X.ID_Exemplar
JOIN 
    MATERIAL M ON X.ID_Material = M.ID_Material
WHERE 
    E.Status_Emprestimo = 'Ativo'
ORDER BY 
    E.Data_Devolucao_Prevista ASC;

-- 2. Consulta com JOIN e GROUP BY: Contar quantos exemplares de cada material estão disponíveis.
SELECT 
    M.Titulo,
    COUNT(X.ID_Exemplar) AS Total_Disponivel
FROM 
    MATERIAL M
JOIN 
    EXEMPLAR X ON M.ID_Material = X.ID_Material
WHERE 
    X.Status_Exemplar = 'Disponivel'
GROUP BY 
    M.Titulo
HAVING 
    COUNT(X.ID_Exemplar) > 0
ORDER BY 
    Total_Disponivel DESC;

-- 3. Consulta com JOIN e Subconsulta: Encontrar o nome dos usuários que reservaram o livro 'Introdução a Banco de Dados'.
SELECT 
    U.Nome
FROM 
    USUARIO U
JOIN 
    RESERVA R ON U.ID_Usuario = R.ID_Usuario
WHERE 
    R.ID_Material = (SELECT ID_Material FROM MATERIAL WHERE Titulo = 'Introdução a Banco de Dados');

-- 4. Consulta com LIMIT e OFFSET: Listar os 2 primeiros materiais mais antigos.
SELECT 
    Titulo,
    Autor,
    Ano
FROM 
    MATERIAL
ORDER BY 
    Ano ASC
LIMIT 2;

-- 5. Consulta com Funções de Agregação: Calcular o valor total de multas pendentes.
SELECT 
    SUM(Valor) AS Total_Multas_Pendentes
FROM 
    MULTA
WHERE 
    Status_Pagamento = 'Pendente';


-- ** ATUALIZAÇÃO DE DADOS (UPDATE) **

-- 1. Atualizar o status de um empréstimo que foi devolvido com atraso para 'Devolvido' e registrar a data de devolução real.
UPDATE 
    EMPRESTIMO
SET 
    Status_Emprestimo = 'Devolvido',
    Data_Devolucao_Real = '2025-11-28'
WHERE 
    ID_Emprestimo = 3;

-- 2. Aumentar o valor da multa em 10% para todas as multas pendentes.
UPDATE 
    MULTA
SET 
    Valor = Valor * 1.10
WHERE 
    Status_Pagamento = 'Pendente';

-- 3. Alterar o endereço de um usuário específico.
UPDATE 
    USUARIO
SET 
    Endereco = 'Rua Nova, 500'
WHERE 
    ID_Usuario = 4;


-- ** EXCLUSÃO DE DADOS (DELETE) **

-- 1. Excluir a reserva de um usuário que já está com o material emprestado (simulação de cancelamento após empréstimo).
DELETE FROM 
    RESERVA
WHERE 
    ID_Usuario = 3 AND ID_Material = 103;

-- 2. Excluir um exemplar que foi dado como perdido (ID_Exemplar = 1005).
DELETE FROM 
    EXEMPLAR
WHERE 
    ID_Exemplar = 1005 AND Status_Exemplar = 'Emprestado'; -- A restrição de chave estrangeira em EMPRESTIMO impedirá a exclusão se houver empréstimos ativos ou históricos.

-- 3. Excluir um usuário que não possui mais vínculos (empréstimos ativos, multas pendentes ou reservas).
DELETE FROM 
    USUARIO
WHERE 
    ID_Usuario = 4 AND Nome = 'Daniela Alves'; -- A exclusão será impedida pela FK em RESERVA.
