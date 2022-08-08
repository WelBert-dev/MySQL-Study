-- Conceituando: A junção é uma das operações mais úteis e a maneira mais comumente usada para combinar informações de duas ou mais tabelas 

-- Tipos de junção:
   -- Produto Cartesiano (CROSS JOIN)
   -- Junção Interna (INNER JOIN) 
   -- Junção Natural (NATURAL JOIN)
   -- Junção Externa à Esquerda (LEFT OUTER JOIN) 
   -- Junção Externa à Direita (RIGHT OUTER JOIN) 
   -- Junção Externa à Esquerda e à Direita (FULL OUTER JOIN) – MySQL não aceita.

-- Tabelas:
-- [Emp]                              [Depto]
-- | MATR | E_NOME | SALARIO | DEPTO_ID | ID | D_NOME      | 
-- | 123  | Mary   | 4000.00 |  1       | 1  | Informática |
-- | 234  | John   | 3000.00 |  1       | 2  | Matemática  |
-- | 345  | Jim    | 2500.00 |  2       | 3  | Física      |
-- | 456  | Ann    | 3500.00 |  3       | 4  | Química     |
-- | 567  | Carl   | 3000.00 | NULL     |

-- Produto Cartesiano (CROSS JOIN):
   -- Conceituando: Obtém uma tabela contendo todas as combinações possíveis de registros entre duas tabelas T1 e T2
   -- Exemplo: 
      SELECT * 
      FROM empe, depto d; 
      SELECT * 
      FROM empe 
      CROSS JOIN depto d;
      -- Saída:
         -- | MATR | E_NOME | SALARIO | DEPTO_ID | ID | D_NOME      | 
         -- | 123  | Mary   | 4000.00 | 1        | 1  | Informática | 
         -- | 234  | John   | 3000.00 | 1        | 1  | Informática | 
         -- | 345  | Jim    | 2500.00 | 2        | 1  | Informática | 
         -- | 456  | Ann    | 3500.00 | 3        | 1  | Informática | 
         -- | 567  | Carl   | 3000.00 | NULL     | 1  | Informática | 
         -- | 123  | Mary   | 4000.00 | 1        | 2  | Matemática  | 
         -- | 234  | John   | 3000.00 | 1        | 2  | Matemática  | 
         -- | 345  | Jim    | 2500.00 | 2        | 2  | Matemática  | 
         -- | 456  | Ann    | 3500.00 | 3        | 2  | Matemática  | 
         -- | 567  | Carl   | 3000.00 | NULL     | 2  | Matemática  | 
         -- | 123  | Mary   | 4000.00 | 1        | 3  | Física      | 
         -- | 234  | John   | 3000.00 | 1        | 3  | Física      | 
         -- | 345  | Jim    | 2500.00 | 2        | 3  | Física      | 
         -- | 456  | Ann    | 3500.00 | 3        | 3  | Física      | 
         -- | 567  | Carl   | 3000.00 | NULL     | 3  | Física      | 
         -- | 123  | Mary   | 4000.00 | 1        | 4  | Química     | 
         -- | 234  | John   | 3000.00 | 1        | 4  | Química     |
         -- | 345  | Jim    | 2500.00 | 2        | 4  | Química     | 
         -- | 456  | Ann    | 3500.00 | 3        | 4  | Química     |
         -- | 567  | Carl   | 3000.00 | NULL     | 4  | Química     |

-- Junção Interna (INNER JOIN):
   -- Conceituando: Obtém uma tabela contendo as combinações de registros entre duas tabelas T1 e T2 que satisfazem a uma condição (de igualdade).
   -- Exemplo: Recuperar a matrícula e o nome dos empregados do departamento 'Informática'.
      SELECT e.matr, e.nome 
      FROM emp e 
      INNER JOIN depto d ON (e.depto_id = d.id) 
      WHERE d.nome = 'Informática'; 
      -- Saída:
         -- [1a. Etapa(ON (e.depto_id = d.id))]:
         -- | MATR | E_NOME | SALARIO | [DEPTO_ID | ID] | D_NOME      |
         -- | 123  | Mary   | 4000.00 | [ 1       | 1 ] | Informática |
         -- | 234  | John   | 3000.00 | [ 1       | 1 ] | Informática |
         -- | 345  | Jim    | 2500.00 | [ 2       | 2 ] | Matemática  |
         -- | 456  | Ann    | 3500.00 | [ 3       | 3 ] | Física      |
         -- [2a. Etapa(WHERE d.nome = 'Informática')]:
         -- | MATR | E_NOME | SALARIO | DEPTO_ID | ID | [D_NOME       ] |
         -- | 123  | Mary   | 4000.00 | 1        | 1  | [ Informática ] |
         -- | 234  | John   | 3000.00 | 1        | 1  | [ Informática ] |
         -- [Resultado Final(SELECT e.matr, e.nome)]:
         -- | MATR | E_NOME |
         -- | 123  | Mary   |
         -- | 234  | John   |

-- Junção Natural (NATURAL JOIN):
   -- Conceituando: Obtém a junção interna, porém é utilizada apenas quando os nomes das colunas da condição de junção são iguais.
   -- O resultado omite uma das colunas duplicadas no resultado.
   -- Exemplo: Recuperar os empregados do departamento ‘Informática’.
   SELECT *
   FROM emp e 
   NATURAL INNER JOIN depto d 
   WHERE d.d_nome = 'Informática';
   -- Saída: 
      -- [1a. Etapa(D_ID nas duas tabelas, não precisa especificar com ON)]:
      -- | MATR | NOME | SALARIO | [D_ID | D_ID] | D_NOME        |
      -- | 123  | Mary | 4000.00 | [ 1   |   1 ] | Informática |
      -- | 234  | John | 3000.00 | [ 1   |   1 ] | Informática |
      -- | 345  | Jim  | 2500.00 | [ 2   |   2 ] | Matemática  |
      -- | 456  | Ann  | 3500.00 | [ 3   |   3 ] | Física      |
      -- [Resultado final (WHERE d.d_nome = 'Informática')]:
      -- | D_ID | MATR | NOME | SALARIO | [D_NOME       ] |
      -- | 1    | 123  | Mary | 4000.00 | [ Informática ] |
      -- | 1    | 234  | John | 3000.00 | [ Informática ] |
     
