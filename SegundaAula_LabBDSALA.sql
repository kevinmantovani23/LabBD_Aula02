--1) Fazer em SQL Server os seguintes algoritmos:


--a) Dado um número inteiro. Calcule e mostre o seu fatorial. (Não usar entrada superior a 12)
DECLARE @a INT, @i INT, @r INT
SET @a = 6
SET @i = 1
SET @r = @a 
WHILE (@i < @a)
BEGIN
	SET @r = @i * @r
	SET @i = @i + 1
END
PRINT(@r)

--b) Dados A, B, e C de uma equação do 2o grau da fórmula AX2+BX+C=0. Verifique e mostre a
--existência de raízes reais e se caso exista, calcule e mostre. Caso não existam, exibir mensagem.
DECLARE @aa INT, @bb INT, @cc INT, @res1 FLOAT, @res2 FLOAT
DECLARE @raiz FLOAT
SET @aa = 5
SET @bb = 2
SET @cc = 3
SET @raiz = (@bb * @bb) - (4*@aa*@cc)
IF (@raiz >= 0)
BEGIN
	SET @res1 = (SELECT -@bb/(-2*@aa*@cc)) + (SELECT SQRT(@raiz)/(-2*@aa*@cc))
	SET @res2 = (SELECT -@bb/(-2*@aa*@cc)) - (SELECT SQRT(@raiz)/(-2*@aa*@cc))
	PRINT('Raizes: ' + CAST(@res1 AS VARCHAR(50)) + ' e ' + CAST(@res2 AS VARCHAR(50)))
END
ELSE
BEGIN
	PRINT('Não existe raiz real')
END

--c) Calcule e mostre quantos anos serão necessários para que Ana seja maior que Maria sabendo
--que Ana tem 1,10 m e cresce 3 cm ao ano e Maria tem 1,5 m e cresce 2 cm ao ano.

DECLARE @anaAltura FLOAT, @mariaAltura FLOAT, @ano INT
SET @anaAltura = 1.10
SET @mariaAltura = 1.5
SET @ano = 0
WHILE (@anaAltura < @mariaAltura)
BEGIN
	SET @anaAltura = @anaAltura + 0.03
	SET @mariaAltura = @mariaAltura + 0.02
	SET @ano = @ano + 1
END

PRINT('São necessários ' + CAST(@ano AS VARCHAR(2)) + ' anos.')


--d) Seja a seguinte série: 1, 4, 4, 2, 5, 5, 3, 6, 6, 4, 7, 7, ...
--Escreva uma aplicação que a escreva N termos

DECLARE @n1 INT, @termos INT, @i2 INT
SET @n1 = 1
SET @i2 = 0
SET @termos = 2
WHILE (@i2 < @termos)
BEGIN
	PRINT(@n1)
	PRINT(@n1 + 3)
	PRINT(@n1 + 3)
	SET @n1 = @n1 + 1
	SET @i2 = @i2 + 1
END

--e) Considerando a tabela abaixo, gere uma database, a tabela e crie um algoritmo para inserir
--uma massa de dados, com 50 registros, para fins de teste, com as regras estabelecidas (Não
--usar constraints na criação da tabela)
--• Código inicia em 50001 e incrementa de 1 em 1
--• Nome segue padrão simples: Produto 1, Produto 2, Produto 3, etc.
--• Valor, gerar um número aleatório* entre 10.00 e 100.00
--• Vencimento, gerar um número aleatório* entre 3 e 7 e, usando a função específica para
--soma de datas no SQL Server, somar o valor gerado à data de hoje.
--* Função RAND() gera números aleatórios entre 0 e 0,9999...

CREATE DATABASE iteme
USE iteme
CREATE TABLE produto (
	codigo		INT,
	nome		VARCHAR(30),
	valor		DECIMAL(7,2),
	vencimento	DATE,
	PRIMARY KEY(codigo)
)
DECLARE @codigo	INT, @nome VARCHAR(30), @vencimento DATE, @i3 INT, @valor DECIMAL(7,2)
SET @codigo = 50000
SET @nome = 'Produto '
SET @i3 = 1
WHILE (@i3 <= 50)
BEGIN
	SET @valor = RAND()*(100-10+1)+10
	SET @vencimento = DATEADD(DAY, RAND()* 5 + 3, GETDATE())
	INSERT INTO produto(codigo, nome, vencimento, valor)
	VALUES(@codigo + @i3, @nome + CAST(@i3 AS VARCHAR(2)), @vencimento, @valor)
	SET @i3 = @i3 + 1
END
SELECT * FROM produto


--f) Considerando a tabela abaixo, gere uma database, a tabela e crie um algoritmo para inserir
--uma massa de dados, com 50 registros, para fins de teste, com as regras estabelecidas (Não
--usar constraints na criação da tabela)
--• Código inicia em 981101 e incrementa de 1 em 1
--• Título segue padrão simples: Livro 981101, Livro 981102, Livro 981103, etc.
--• Qtd_paginas deve ser um número aleatório entre 100 e 400
--• Qtd_Estoque deve ser um número aleatório entre 2 e 20

CREATE DATABASE itemf
USE itemf

CREATE TABLE livro (
	id				INT,
	titulo			VARCHAR(30),
	qtd_paginas		INT,
	qtd_estoque		INT,
	PRIMARY KEY (id)
)

DECLARE @id INT, @titulo VARCHAR(30), @qtd_paginas INT, @qtd_estoque INT, @i4 INT
SET @id = 981100
SET @titulo = 'Livro '
SET @i4 = 1
WHILE (@i4 <= 50)
BEGIN
	SET @qtd_paginas = RAND()*301 + 100
	SET @qtd_estoque = RAND()*19 + 2
	INSERT INTO livro(id, titulo, qtd_paginas, qtd_estoque)
	VALUES(@id + @i4, @titulo + CAST((@i4 + @id) AS VARCHAR(6)), @qtd_paginas, @qtd_estoque)
	SET @i4 = @i4 + 1
END
SELECT * FROM livro
