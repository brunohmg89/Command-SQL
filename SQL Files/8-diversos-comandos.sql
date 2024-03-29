-- Criar um banco
CREATE DATABASE nomedobanco;

-- Excluir um banco
DROP DATABASE nomedobanco;

-- SELECT
SELECT coluna1, coluna2 ou * que significa tudo
FROM tabela;

-- DISTINCT Seleciona sem dados duplicados
SELECT DISTINCT coluna1, coluna2
FROM tabela;

-- WHERE
SELECT coluna1, coluna2
FROM tabela
WHERE condição que pode ser: 
OPERADOR    DESCRIÇÃO
=           IGUAL
>           MAIOR QUE
<           MENOR QUE
>=          MAIOR OU IGUAL
<=          MENOR OU IGUAL
<>          DIFERENTE DE
AND         OPERADOR LÓGICO E 
OR          OPERADOR LÓGICO OU

-- Exemplo do uso de WHERE
SELECT *
FROM Person.Person
WHERE Firstname = 'peter' and Lastname = 'krebs'

SELECT *
FROM Person.EmailAddress
WHERE BussinessEntityID = 26

-- COUNT ele mostra o número de linhas que bate com a condição entre parenteses
SELECT COUNT(DISTINCT COLUNA1)
FROM TABELA;

-- Exemplo
SELECT COUNT(SIZE)
FROM Production.Product;

-- TOP Seleciona os 10 primeiros registros no banco. 
-- O TOP serve pra filtrar um numero de linhas no exemplo é 10
SELECT TOP 10 *
FROM TABELA;

-- ORDER BY
SELECT COLUNA1, COLUNA2
FROM TABELA
ORDER BY COLUNA1 ASC/DESC

-- Exemplo
SELECT TOP 4 Name, ProductNumber
FROM Production.Product
ORDER BY ProductID ASC

-- BETWEEN
-- O BETWEEN é usado para encontrar o valor entre um valor máximo e um mínimo,
-- ele é usado junto com o WHERE, ele pode ter um NOT para tirar as linhas entre aquele valor
-- Exemplo 1
SELECT * 
FROM Production.Product
WHERE ListPrice BETWEEN 1000 and 1500;

-- Exemplo 2
SELECT * 
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 and 1500;

-- Exemplo 3
SELECT HireDate
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2009/01/01' and '2010/01/01'
ORDER BY HireDate

-- IN
-- Nós usamos o IN junto com o WHERE, e podemos usar também com o NOT
-- para verificar se um valor corresponde com qualquer valor passado na lista de valores.

WHERE VALOR IN (VALOR1, VALOR2)

-- Exemplo 1
SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (2,7,13)

-- Exemplo 2
SELECT *
FROM Person.Person
WHERE BusinessEntityID NOT IN (2,7,13)

-- LIKE serve quando você não lembra direito
SELECT *
FROM Person.Person
WHERE Firstname like 'lembrodocomeco%' -- o que tem depois do % não lembro

SELECT *
FROM Person.Person
WHERE Firstname like '%lembrodofinal' -- o que tem antes do % não lembro

SELECT *
FROM Person.Person
WHERE Firstname like '%lembrodomeio%' -- o que tem antes e depois das % não lembro

SELECT *
FROM Person.Person
WHERE Firstname like '%lembrodotamanho__' -- o que tem depois da % lembro só de uma parte, mas sei que são 2 letras

-- Funções de agregação

SELECT TOP 10  SUM(LineTotal) AS 'Soma' -- Soma os valores da coluna LineTotal
FROM Sales.SalesOrderDetail

SELECT TOP 10 MIN(LineTotal) AS 'MÍNIMO' -- Traz o menor valor da coluna LineTotal
FROM Sales.SalesOrderDetail

SELECT TOP 10 MAX(LineTotal) AS 'MÁXIMO' -- Traz o maior valor da coluna LineTotal
FROM Sales.SalesOrderDetail

SELECT TOP 10 AVG(LineTotal) AS 'MÉDIA'  -- Traz a média de valores da coluna LineTotal
FROM Sales.SalesOrderDetail

SELECT TOP 10 COUNT(LineTotal) AS 'QUANTAS VEZES'  -- Traz o número de linhas da coluna LINETOTAL
FROM Sales.SalesOrderDetail

-- Fim dos fundamentos começo do intermediário

-- GROUP BY Divide o resultado da sua pesquisa em grupos,
-- e para cada grupo você é obrigado a aplicar uma função de agregação que são as que aparecem acima
-- você não precisa de um GROUP BY para usar uma função de agregação
-- a menos que você queira usar a função em uma determinada coluna.

-- Aqui o que eu estou dizendo:
1 - Retornar uma média de acordo com a coluna LISTPRICE e chama isso de média
2 - Pega da tabela PRODUCTION.PRODUCT

SELECT AVG(ListPrice) AS MÉDIA
FROM Production.Product

ELE RETORNA ISSO:
|  MÉDIA   |
| 438,6662 |

-- Aqui o que eu estou dizendo:
1 - Selecione a coluna COLOR, faça uma média com a coluna LISTPRICE, chama isso de média
2 - Pega da tabela Production.Product
3 - Como eu tenho uma coluna e uma função de agregação na linha 1, se eu rodasse a linha 1 e 2
ele me retornaria um erro, pois ele entende que COLOR deve ser relacionada com a média,
para relacionar então deve-se colocar um GROUP BY que significa:
Ei divida o resultadoDIVIDA O RESULTADO DE AVG(ListPrice) AS MÉDIA POR COR
OU SEJA FAÇA PARA CADA COR A FUNÇÃO DE AGREGAÇÃO 

SELECT Color, AVG(ListPrice) AS MÉDIA
FROM Production.Product
GROUP BY Color
ELE RETORNA ISSO:

         |Color  |   MÉDIA
         |NULL   |   16,8641
         |Black  |   725,121
         |Blue   |   923,6792
         |Grey   |   125,00
         |Red    |   59,865
         |Silver |   1401,95
         |White  |   850,3053
         |Yellow |   64,0185
           
SINTAXE
 SELECT COLUNA1, FuncaoAgregacao(COLUNA2)
 FROM nomeTAbela
 GROUP BY coluna1;

 --EXEMPLOS
 --1
SELECT ProductID, COUNT(ProductID) AS "Contagem"
FROM Sales.SalesOrderDetail
GROUP BY ProductID;
--2
SELECT FirstName, COUNT(FirstName) AS "Vezes"
FROM Person.Person
GROUP BY FirstName
ORDER BY FirstName ASC;
--3
SELECT Color,AVG(ListPrice)  AS preço
FROM Production.Product
GROUP BY Color;

--HAVING
--O HAVING É BASICAMENTE UM WHERE COM GROUP BY 
SINTAXE
SELECT COLUNA1,FUNCAODEAGREGACAO(COLUNA2)
FROM TABELA
GROUP BY COLUNA1
HAVING CONDIÇÃO
--exemplos
--1
SELECT ProductID,SUM(LineTotal) AS 'total'
FROM SALES.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) BETWEEN 162000 AND 500000

--2
SELECT FirstName, COUNT(FirstName) AS 'QUANTIDADE'
 FROM PERSON.Person
 WHERE Title = 'Mr.'
 GROUP BY FIRSTNAME
 HAVING COUNT(FirstName) > 10
 order by QUANTIDADE desc

 --INNER JOIN
 --SINTAXE
SELECT AB.COLUNA1, AB.COLUNA2, AB.COLUNA3, AB2.COLUNA1
FROM PRIMEIRATABELA AS AB /*ABREVIAÇÃO QUE VOU CHAMAR DE AB*/ 
INNER JOIN SEGUNDATABELA AS AB2 /*ABREVIAÇÃO QUE VOU CHAMAR DE AB2*/ 
/*ON SIGNIFICA TIPO ONDE*/
 ON  AB.CoisaEmComum = AB2.CoisaEmComum

 --EXEMPLO
 --1
 SELECT PH.BusinessEntityID, PH.PhoneNumber, PH.PhoneNumberTypeID, PT.Name
FROM Person.PersonPhone AS PH
INNER JOIN Person.PhoneNumberType AS PT ON PH.PhoneNumberTypeID = PT.PhoneNumberTypeID
--2
SELECT PA.AddressID,PA.City,PS.StateProvinceID,PS.Name
FROM Person.Address AS PA
INNER JOIN Person.StateProvince AS PS ON PA.StateProvinceID = PS.StateProvinceID

-- JOINS
--FULL OUTER JOIN
--SINTAXE
SELECT AB.COLUNA1, AB.COLUNA2, AB.COLUNA3, AB2.COLUNA1
FROM PRIMEIRATABELA AS AB /*ABREVIAÇÃO QUE VOU CHAMAR DE AB*/ 
FULL OUTER JOIN SEGUNDATABELA AS AB2 /*ABREVIAÇÃO QUE VOU CHAMAR DE AB2*/ 
/*ON SIGNIFICA TIPO ONDE*/
 ON  AB.CoisaEmComum = AB2.CoisaEmComum
 --DIFERENTE DO INNER JOIN ELE RETORNA TODOS OS DADOS 
 --INCLUSIVE OS QUE NÃO EXISTEM NAS DUAS TABELAS ELE PREENCHE COM NULL

--LEFT OUTER JOIN
--SINTAXE
SELECT AB.COLUNA1, AB.COLUNA2, AB.COLUNA3, AB2.COLUNA1
FROM PRIMEIRATABELA AS AB /*ABREVIAÇÃO QUE VOU CHAMAR DE AB*/ 
LEFT OUTER JOIN SEGUNDATABELA AS AB2 /*ABREVIAÇÃO QUE VOU CHAMAR DE AB2*/ 
/*ON SIGNIFICA TIPO ONDE*/
 ON  AB.CoisaEmComum = AB2.CoisaEmComum
 --DIFERENTE DO FULL OUTER JOIN ELE NÃO RETORNA TODOS OS DADOS 
 --ELE RETORNA TODOS OS DADOS DA TABELA (A), OS DADOS IGUAIS E SÓ, NADA QUE SOMENTE EXISTA NA TABELA (B)
 --INCLUSIVE OS DADOS QUE NÃO EXISTEM NA TABELA (B) ELE PREENCHE COM NULL
 --MAS QUANDO OS DADOS NÃO EXISTEM NA TABELA (A) ELE NÃO TRAZ NADA

--RIGHT OUTER JOIN
--SINTAXE
SELECT AB.COLUNA1, AB.COLUNA2, AB.COLUNA3, AB2.COLUNA1
FROM PRIMEIRATABELA AS AB /*ABREVIAÇÃO QUE VOU CHAMAR DE AB*/ 
RIGHT OUTER JOIN SEGUNDATABELA AS AB2 /*ABREVIAÇÃO QUE VOU CHAMAR DE AB2*/ 
/*ON SIGNIFICA TIPO ONDE*/
 ON  AB.CoisaEmComum = AB2.CoisaEmComum
 --DIFERENTE DO FULL OUTER JOIN ELE NÃO RETORNA TODOS OS DADOS 
 --ELE RETORNA TODOS OS DADOS DA TABELA (B), OS DADOS IGUAIS E SÓ, NADA QUE SOMENTE EXISTA NA TABELA (A)
 --INCLUSIVE OS DADOS QUE NÃO EXISTEM NA TABELA (A) ELE PREENCHE COM NULL
 --MAS QUANDO OS DADOS NÃO EXISTEM NA TABELA (B) ELE NÃO TRAZ NADA

--UNION 
--COMBINA 2 OU MAIS RESULTADOS DE UM SELECT EM APENAS 1 RESULTADO
--ELE REMOVE OS DADOS DUPLICADOS A MENOS QUE VOCÊ COLOQUE UNION ALL

--SINTAXE 
SELECT COLUNA1, COLUNA2
FROM TABELA1
UNION OU UNION ALL
SELECT COLUNA1, COLUNA2
FROM TABELA2
--EXEMPLOS
--1
SELECT [ProductID], [NAME], [ProductNumber]
FROM Production.Product 
WHERE NAME LIKE '%Chain%'
UNION
SELECT [ProductID], [NAME], [ProductNumber]
FROM Production.Product 
WHERE NAME LIKE '%Decal%'
ORDER BY Name
--2
SELECT FirstName,Title, MiddleName
FROM Person.Person 
WHERE Title LIKE 'Mr.'
UNION
SELECT FirstName,Title, MiddleName
FROM Person.Person 
WHERE MiddleName LIKE 'A'
--3
SELECT Title, FirstName
FROM Person.Person
WHERE Title = 'MR.'
UNION
SELECT Title, FirstName
FROM Person.Person
WHERE Title = 'MS.'

DATEPART 
-- https://docs.microsoft.com/pt-br/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15
--SERVE PARA TRABALHAR COM DATA EM TIMESTAMP QUE É ESSE FORMATO:
ANO-MES-DIA HORA:MINUTOS:SEGUNDOS.MILISEGUNDOS
EXEMPLO: 
2020-08-24 19:35:00.000 QUE FICA 24/08/2020 ÁS 19:35
SINTAXE
SELECT COLUNA1, DATEPART(MONTH YEAR OU DAY,ColunaComFormatoEmTimestamp) 
FROM Tabela1
--EXEMPLOS
--1 QUERO O ID E EM QUE MES CADA UM FOI REGISTRADO
SELECT SalesOrderID AS ID,DATEPART(MONTH,OrderDate) AS MES
FROM Sales.SalesOrderHeader

--2 QUERO A MÉDIA POR ANO DE FATURAMENTO TOTAL
SELECT AVG(TotalDue) AS Media,DATEPART(YEAR,OrderDate) AS ANO
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(YEAR,OrderDate)
ORDER BY ANO

--OPERCOES EM STRING 
--CONCAT
SELECT CONCAT(FirstName, ' ', LastName)
FROM Person.Person
RETORNA
Syed Abbas
...
--UPPER
--LOWER
SELECT UPPER(FirstName), LOWER(LastName)
FROM Person.Person
RETORNA
SYED	abbas
--LEN
SELECT FirstName, LEN(FirstName)
FROM Person.Person
RETORNA
Syed	4
--SUBSTRING
SELECT FirstName, SUBSTRING(FirstName,1,3)
FROM Person.Person
RETORNA
Syed	Sye
--REPLACE substitui
SELECT REPLACE(ProductNumber, '-','#')
FROM Production.Product
ANTES
AR-5381
DEPOIS
AR#5381
--FUNCOES MATEMÁTICAS
-- +
SELECT UnitPrice + LineTotal
FROM Sales.SalesOrderDetail
-- -
SELECT UnitPrice - LineTotal
FROM Sales.SalesOrderDetail
-- *
SELECT UnitPrice * LineTotal
FROM Sales.SalesOrderDetail
-- /
SELECT UnitPrice / LineTotal
FROM Sales.SalesOrderDetail

TODOS ESSES RETORNAM UM NÚMERO

--ARREDONDAMENTO
--ROUND
SELECT ROUND(LINETOTAL, 0), LineTotal
FROM Sales.SalesOrderDetail
RETORNA
ARRENDONDADO: 2025.000000
NORMAL: 2024.994000
-- O ZERO SIGNIFICA COM QUANTAS CASAS DEPOIS DA VÍRGULA EU QUERO A PRECISÃO TAMBÉM POSSO PASSAR VALORES NEGATIVOS
SELECT ROUND(LINETOTAL, -1), LineTotal
FROM Sales.SalesOrderDetail
RETORNA
ARRENDONDADO: 2020.000000
NORMAL: 2024.994000

--RAIZ QUADRADA
SELECT SQRT(LINETOTAL), LineTotal
FROM Sales.SalesOrderDetail
RETORNA
RAIZ: 44,9999333332839
NORMAL: 2024.994000
-- VOCÊ TAMBÉM PODE ARRENDONDAR A RAIZ OLHA
SELECT ROUND(SQRT(LINETOTAL), 0), LineTotal
FROM Sales.SalesOrderDetail
RETORNA
RAIZ: 45
NORMAL: 2024.994000

--SUBQUERYES OU SUBSELECTS

SINTAXE

SELECT COLUNA1, ...
FROM TABELA
WHERE DADO É = , >, <, <=, >=, IN (
SELECT COLUNA
FROM TABELA
WHERE DADO = ALGO)

EXEMPLOS 

-- 1) TRAGA O NOME DOS FUNCIONÁRIOS QUE TEM O CARGO DESIGN ENGINEER
SELECT FirstName
FROM Person.Person
WHERE BusinessEntityID IN (
SELECT BusinessEntityID
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer')

-- 2) TRAGA os dados dos produtos que tem o preco de venda acima da média
SELECT *
FROM Production.Product
WHERE ListPrice > (
SELECT AVG(ListPrice) FROM Production.Product )

-- 3) TRAGA TODOS OS ENDEREÇOS QUE ESTÃO NO ESTADO DE ALBERTA
SELECT *
FROM Person.Address
WHERE StateProvinceID = (
SELECT StateProvinceID 
FROM Person.StateProvince
WHERE Name = 'Alberta'
)

-- SELF JOIN SERVE PARA COMPARAR DADOS DA MESMA TABELA
-- BANCO DE DADOS UTILIZADO:  http://b.link/BancoDeDadosAual24

SINTAXE 

SELECT A.COLUNA, B.COLUNA
FROM COLUNA AS A, COLUNA AS B
WHERE A.DADO =, >, <, ETC, B.DADO

EXEMPLOS

-- 1) TRAGA TODOS OS CLIENTES QUE ESTÃO NA MESMA REGIÃO

SELECT DISTINCT A.ContactName, A.Region, B.ContactName, B.Region
FROM Customers AS A, Customers AS B
WHERE A.Region = B.Region

-- 2) TRAGA O NOME DOS FUNCIONARIOS QUE FORAM CONTRATADOS NO MESMO ANO

SELECT A.FirstName, A.HireDate, B.FirstName, B.HireDate
FROM Employees A, Employees B
WHERE DATEPART(YEAR, A.HireDate) =  DATEPART(YEAR, B.HireDate)

-- 3) TRAGA AS ORDERNS DE PEDIDO COM O MESMO PERCENTUAL DE DESCONTO

SELECT DISTINCT(A.ORDERID) ,A.Discount
FROM [Order Details] AS A, [Order Details] AS B
WHERE A.Discount = B.Discount
ORDER BY A.ORDERID

--TIPOS DE DADOS NO SQL SERVER
1.BOLEANOS NO SQL SERVER É BIT E RECEBE 1 QUE É TRUE , 0 QUE É FALSE E NULL
2.CARACTERES
3.NÚMEROS
4.TEMPORAIS

--CHAVE PRIMÁRIA
--PRIMARY KEY
/* UMA CHAVE PRIMÁRIA É UMA COLUNA OU UM GRUPO DE COLUNAS,
 USADA PARA IDENTIFICAR UNICAMENTE UMA LINHA EM UMA TABELA COMO UM ID 235 QUE SE REFERE A LINHA 235 */

/* VOCÊ CONSEGUE CRIAR CHAVES PRIMARIAS ATRAVÉS DE RESTRIÇÕES OU CONSTRAINTS EM INGLÊS CONSTRAINT,
QUE SÃO REGRAS QUE VOCÊ DEFINE QUANDO ESTÁ CRIANDO UMA COLUNA
 */

 /* OU SEJA QUANDO VOCÊ DEFINE CONSTRAINT,
  ESTÁ CRIANDO UM INDICE ÚNICO PARA AQUELA COLUNA OU GRUPO DE COLUNAS */

  --CHAVE ESTRANGEIRA

--CHAVE ESTRANGEIRA É A CHAVE PRIMÁRIA EM OUTRA TABELA 
--ELA IDENTIFICA UNICAMENTE EM UMA ÚNICA LINHA EM OUTRA TABELA

EXEMPLO
--https://drive.google.com/file/d/1FonwdwET4CfexnOvsf_ZRttzMHd-P8Ux/view?usp=sharing

CRIAR TABELA
--CREATE TABLE
SINTAXE
CREATE TABLE NOMETABELA (
coluna1 tipo restriçãoColuna,
coluna2 tipo restriçãoColuna,
coluna3 tipo restriçãoColuna,
....
);
PRINCIPAIS TIPOS DE RESTRIÇÕES:
--https://drive.google.com/file/d/1NGWBOgZna6gXjdpb0KYHL-ZeJb-Q1-jZ/view?usp=sharing

EXEMPLOS
1) /*
CREATE TABLE CANAL (
CanalId int Primary key,
Nome varchar(150) not null,
ContagemInscritos int default 0,
DataCriacao datetime not null
);
*/
2) /*
CREATE TABLE VIDEO (
VideoId INT PRIMARY KEY,
Nome VARCHAR(150) NOT NULL,
Visualizacoes INT DEFAULT 0,
Likes INT DEFAULT 0,
Deslikes INT DEFAULT 0,
Duracao INT NOT NULL,
CanalID INT FOREIGN KEY REFERENCES Canal(CanalID)
);

3)

CREATE TABLE DAN (
NOME VARCHAR(40) NOT NULL,
ID INT PRIMARY KEY
)


*/
COMO CRIAR TABELA RÁPIDO

SELECT * INTO tabelaNOVA FROM TabelaQueVocêQuerCopiar

COMO COPIAR OS DADOS DE UMA TABELA PRA OUTRA

SINTAXE:

INSERT INTO TabelaQVcQuerCopiarDados 
(ColunasQueVcQuerPorOsDados1, ColunasQueVcQuerPorOsDados2, ...) 
SELECT ColunasOndeOsDadosDevemSerRetirados1, ColunasOndeOsDadosDevemSerRetirados2 
FROM TabelaOndeOsDadosDevemSerRetirados; 

EXEMPLO
1-
INSERT INTO DAN (NOME, ID)
SELECT NOME, ID FROM DAN2;

/*
Caso as duas tabelas tenham os mesmos campos:
INSERT INTO table2
SELECT * FROM table1;

Se apenas alguns campos forem comuns, terá de indicar esses campos:
INSERT INTO table2 -- INSIRA NA TABELA2 
(COLUNA1, COLUNA2, ...) --NAS COLUNAS 1 e 2
SELECT COLUNAX, COLUNAY -- QUE SE CHAMAM COLUNA X e Y
FROM table1; -- NA TABELA 1

--Nota: os nomes dos campos podem ser diferentes, têm é de ser do mesmo tipo. 
--Eles serão preenchidos de acordo com a ordem em que são declarados.

--Em ambos os casos pode ser utilizada a cláusula WHERE:

INSERT INTO table2
(column_name1, column_name2, ...)
SELECT column_name1, column_name2, ...
FROM table1
WHERE column_name1 = "a qualquer coisa";
Para apagar a tabela use:

COMO APAGAR TABELA

DROP TABLE tabela1

*/
--INSERIR DADOS
SINTAXE
INSERT INTO nomeTABELA(coluna1, coluna2, ...)
VALUES(valor1, valor2)

exemplos
--1
INSERT INTO aula(id,nome) 
VALUES
(2,'AULA 2'),
(3,'AULA 3'),
(4,'AULA 4');

--2
INSERT INTO DAN (NOME,ID)
VALUES
('ROBERTO BOBAO', 3),
('O TAL DO FORGA', 4),
('FERNANDO REGO BARROS', 5);

--UPDATE
SINTAXE
UPDATE nomeTabela
SET coluna1 = valor1
coluna2 = valor2
WHERE condição

-ATENÇÃO O WHERE É EXTREMAMENTE IMPORTANTE OU ELE ALTERA TODOS OS DADOS DA COLUNA

EXEMPLOS
UPDATE TabelaNova 
SET nome = 'Pug'
WHERE ID = 5

UPDATE CANAL
SET DataCriacao  = 	2007-05-08
WHERE ID = 1

--DELETAR
SINTAXE
DELETE FROM nomeTabela
WHERE condicao

DELETE FROM TABELANOVA 
WHERE NOME = 'AULA 2'

-- ALTER TABLE 
ALTER TABLE nomeTabela
ACAO

EXEMPLOS DE O QUE PODE SER FEITO
- ADD, REMOVER, OU ALTERAR UMA COLUNA
- SETAR VALORES PADRÃO PARA UMA COLUNA
- ADD OU REMOVER RESTRIÇÕES DE COLUNAS
- RENOMEAR UMA TABELA

exemplos 
ALTER TABLE youtube
ALTER COLUMN categoria Varchar(300) NOT NULL

ALTER TABLE youtube
ALTER COLUMN NOME Varchar(300)

ALTER TABLE DAN
ALTER COLUMN NOME NVARCHAR(40) 

--COMO MUDAR NOME DE COLUNA OU TABELA NO SQL SERVER

EXEC sp_rename 'TABELA.COLUNA', 'NovoNomeColuna', 'COLUMN'
EXEC sp_rename 'youtube', 'Youtube'

--EXCLUIR TABELA 
SINTAXE
DROP TABLE nomeTabela

EXEMPLO
DROP TABLE ErrorLog

--COMO LIMPAR OS DADOS DE UMA TABELA
SINTAXE
 TRUNCATE TABLE nomeDaTabela

 NÃO É POSSÍVEL EXCLUIR E NEM TRUNCAR UMA TABELA QUE É REFERENCIADA POR UMA FOREIGN KEY

 --RESTRICÇÕES COM CHECK
SINTAXE 

CREATE TABLE NomeTabela (
Coluna1 --INT NOT NULL,
Coluna2 --VARCHAR(255) NOT NULL,
Coluna3 tipo CHECK ( verificação)
);

EXEMPLOS

CREATE TABLE CarteiraMotorista (
Id INT PRIMARY KEY,
NOME VARCHAR(255) NOT NULL,
IDADE INT CHECK ( IDADE >= 18 ) NOT NULL,
CodigoCNH int NOT NULL UNIQUE
);

CREATE TABLE BEBE (
BebeALcool BIT NOT NULL,
IDADE INT NOT NULL CHECK ( IDADE > 30 ),
ID INT PRIMARY KEY,
)

-- NOT NUUL 
NÃO PODE SER NULO
--UNIQUE 
É UNICA NÃO PODE SER IGUAL
EXEMPLO
CREATE TABLE CarteiraMotorista (
Id INT PRIMARY KEY,
NOME VARCHAR(255) NOT NULL,
IDADE INT CHECK ( IDADE >= 18 ) NOT NULL,
CodigoCNH int NOT NULL UNIQUE --JÁ TEMOS A CHAVE PRIMARIA E O CODIGO CNH NÃO PODE SER NULO E DEVE SER UNICO
);

VIEWS
SINTAXE
CREATE VIEW [NomeDaView] AS
SELECT ColunaX, ColunaY ...
FROM TabelaZ
WHERE condição

EXEMPLOS
CREATE VIEW [Pessoa Simplificada] AS
SELECT FirstName, LastName, MiddleName
FROM PERSON.PERSON
WHERE Title = 'Ms.'

SELECT * FROM [Pessoa Simplificada]

-- UMA VIEW SERVE PARA QUANDO O SEU SISTEMA SEMPRE FAZ ALGO E PRECISA PERFORMAR BEM