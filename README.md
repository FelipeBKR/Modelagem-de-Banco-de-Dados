# Projeto de Banco de Dados: Sistema de Gestão de Acervo e Empréstimos para a Biblioteca Central Universitária "Saber Infinito"

## 1. Visão Geral do Projeto (Minimundo)

Este projeto consiste no desenvolvimento de um modelo de banco de dados relacional para um sistema de gestão de acervo e empréstimos de uma biblioteca universitária. O objetivo é modernizar a gestão do acervo e otimizar o processo de empréstimo de livros e materiais, permitindo que usuários consultem a disponibilidade de títulos, reservem e renovem empréstimos de forma autônoma.

**Objetivos Principais:**
1.  **Gerenciar** o acervo de livros, periódicos e mídias.
2.  **Otimizar** o processo de empréstimo e devolução.
3.  **Facilitar** a consulta e reserva de materiais por parte dos usuários.

## 2. Modelo Lógico (3FN)

O modelo foi desenvolvido seguindo as regras de normalização até a Terceira Forma Normal (3FN), garantindo a integridade e minimizando a redundância de dados.

**Entidades Principais:**
*   **USUARIO:** Informações sobre estudantes, professores e funcionários.
*   **MATERIAL:** Informações sobre o título do livro/item (Autor, ISBN, Edição).
*   **EXEMPLAR:** Informações sobre a cópia física do material (Localização, Status).
*   **EMPRESTIMO:** Registro das transações de empréstimo.
*   **RESERVA:** Registro das reservas de materiais.
*   **MULTA:** Registro das multas geradas por atraso.

## 3. Scripts SQL

Os scripts SQL estão divididos em dois arquivos principais para facilitar a execução e a manipulação dos dados.

### 3.1. DDL (Data Definition Language) - Criação do Esquema

O código DDL abaixo cria as tabelas e define as regras de integridade referencial (chaves primárias e estrangeiras), restrições de unicidade e de domínio (`CHECK`).

\`\`\`sql
-- Tabela USUARIO
CREATE TABLE USUARIO (
    ID_Usuario INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Matricula VARCHAR(20) UNIQUE NOT NULL,
    Tipo VARCHAR(20) NOT NULL CHECK (Tipo IN ('Estudante', 'Professor', 'Funcionario')),
    Endereco VARCHAR(255),
    Telefone VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela MATERIAL (O Título do Livro/Item)
CREATE TABLE MATERIAL (
    ID_Material INT PRIMARY KEY,
    Titulo VARCHAR(255) NOT NULL,
    Autor VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    Edicao INT,
    Ano INT
);

-- Tabela EXEMPLAR (A Cópia Física do Material)
CREATE TABLE EXEMPLAR (
    ID_Exemplar INT PRIMARY KEY,
    ID_Material INT NOT NULL,
    Localizacao VARCHAR(50) NOT NULL,
    Status_Exemplar VARCHAR(20) NOT NULL CHECK (Status_Exemplar IN ('Disponivel', 'Emprestado', 'Em Reparo', 'Perdido')),
    FOREIGN KEY (ID_Material) REFERENCES MATERIAL(ID_Material)
);

-- Tabela EMPRESTIMO
CREATE TABLE EMPRESTIMO (
    ID_Emprestimo INT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Exemplar INT NOT NULL,
    Data_Emprestimo DATE NOT NULL,
    Data_Devolucao_Prevista DATE NOT NULL,
    Data_Devolucao_Real DATE,
    Status_Emprestimo VARCHAR(20) NOT NULL CHECK (Status_Emprestimo IN ('Ativo', 'Devolvido', 'Atrasado')),
    FOREIGN KEY (ID_Usuario) REFERENCES USUARIO(ID_Usuario),
    FOREIGN KEY (ID_Exemplar) REFERENCES EXEMPLAR(ID_Exemplar)
);

-- Tabela RESERVA
CREATE TABLE RESERVA (
    ID_Reserva INT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Material INT NOT NULL,
    Data_Reserva DATE NOT NULL,
    Posicao_Fila INT,
    Status_Reserva VARCHAR(20) NOT NULL CHECK (Status_Reserva IN ('Ativa', 'Cancelada', 'Concluida')),
    FOREIGN KEY (ID_Usuario) REFERENCES USUARIO(ID_Usuario),
    FOREIGN KEY (ID_Material) REFERENCES MATERIAL(ID_Material)
);

-- Tabela MULTA
CREATE TABLE MULTA (
    ID_Multa INT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Emprestimo INT UNIQUE,
    Valor DECIMAL(10, 2) NOT NULL,
    Data_Geracao DATE NOT NULL,
    Status_Pagamento VARCHAR(20) NOT NULL CHECK (Status_Pagamento IN ('Pendente', 'Pago')),
    FOREIGN KEY (ID_Usuario) REFERENCES USUARIO(ID_Usuario),
    FOREIGN KEY (ID_Emprestimo) REFERENCES EMPRESTIMO(ID_Emprestimo)
);
\`\`\`

### 3.2. DML (Data Manipulation Language) - Inserção de Dados

O arquivo `DML_INSERT.sql` contém comandos `INSERT` para popular as tabelas com dados de exemplo.

**Instruções de Execução:**
1.  Execute o script DDL (acima) para criar o esquema do banco de dados.
2.  Execute o script `DML_INSERT.sql` para inserir os dados iniciais.

### 3.3. DML (Data Manipulation Language) - Consultas e Manipulação

O arquivo `DML_SELECT_UPDATE_DELETE.sql` contém exemplos de consultas (`SELECT`) e comandos de manipulação (`UPDATE` e `DELETE`).

**Exemplos de Consultas (SELECT):**
1.  Listar empréstimos ativos, ordenados pela data de devolução.
2.  Contar exemplares disponíveis por material.
3.  Encontrar usuários que reservaram um título específico.
4.  Listar os materiais mais antigos (uso de `LIMIT`).
5.  Calcular o valor total de multas pendentes (uso de `SUM`).

**Exemplos de Manipulação (UPDATE/DELETE):**
*   **UPDATE:** Atualização de status de empréstimo, aumento de valor de multa e alteração de endereço de usuário.
*   **DELETE:** Exclusão de reserva e exemplos de exclusão que seriam impedidas por restrições de chave estrangeira, demonstrando a integridade do modelo.

## 4. Estrutura do Repositório

| Arquivo | Descrição |
| :--- | :--- |
| `README.md` | Este arquivo, contendo a documentação completa do projeto. |
| `DML_INSERT.sql` | Script SQL com comandos `INSERT` para popular as tabelas. |
| `DML_SELECT_UPDATE_DELETE.sql` | Script SQL com comandos `SELECT`, `UPDATE` e `DELETE` de exemplo. |
| `ex1.pdf` | Documento da Atividade 1: Definição do Minimundo e Análise de Dados. |
| `ex2.pdf` | Documento da Atividade 2: Modelagem Conceitual (DER) e Normalização. |
| `ex3.pdf` | Documento da Atividade 3: Modelo Lógico (DDL) e Verificação de FN. |
| `ex4.pdf` | Documento da Atividade 4: Manipulação de Dados (DML) e Documentação Final. |
