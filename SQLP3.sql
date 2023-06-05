CREATE DATABASE testep3
GO
USE testep3
GO
CREATE TABLE aluno(
ra    CHAR(10)     NOT NULL,
nome  VARCHAR(100) NOT NULL
PRIMARY KEY (ra)
)
GO
CREATE TABLE disciplina(
cod_disc    CHAR(7)     NOT NULL,
nome_disc   VARCHAR(50) NOT NULL,
sigla       VARCHAR(4)  NOT NULL,
turno       VARCHAR(1)  NOT NULL,
num_aulas   INT         NOT NULL
PRIMARY KEY (cod_disc)
)
GO
CREATE TABLE avaliacao(
cod_av  INT          NOT NULL,
tipo    VARCHAR (2)  NULL,
peso    DECIMAL(4,3) NULL
PRIMARY KEY (cod_av)
)
GO
CREATE TABLE notas(
ra_al     CHAR(10)     NOT NULL,
cod_disc  CHAR(7)      NOT NULL,
cod_av    INT          NOT NULL,
nota	  DECIMAL(4,1) NULL
PRIMARY KEY (ra_al, cod_disc, cod_av)
FOREIGN KEY (ra_al) REFERENCES aluno(ra), 
FOREIGN KEY (cod_disc) REFERENCES disciplina(cod_disc),
FOREIGN KEY (cod_av) REFERENCES avaliacao(cod_av)
)
GO
CREATE TABLE faltas(
ra        CHAR(10)   NOT NULL,
cod_disc  CHAR(7)    NOT NULL,
dt        DATE       NOT NULL,
presenca  VARCHAR(4) NULL
PRIMARY KEY (ra, cod_disc, dt)
FOREIGN KEY (ra) REFERENCES aluno(ra), 
FOREIGN KEY (cod_disc) REFERENCES disciplina(cod_disc)
)

-----------------------------------------------------------------------------------------------------------------------------------------------------
--INSERTS
INSERT INTO avaliacao VALUES
(01, 'P1', 0.3),
(02, 'P2', 0.5),
(03, 'T', 0.2),
(04, 'P1', 0.35),
(05, 'P2', 0.35),
(06, 'T', 0.3),
(07, 'P1', 0.333),
(08, 'P2', 0.333),
(09, 'T', 0.333),
(10, 'MC', 0.8),
(11, 'MP', 0.2)


INSERT INTO disciplina VALUES
('4203010', 'Arquitetura e Organização de Computadores', 'AOC', 'T', 80),
('4203020', 'Arquitetura e Organização de Computadores', 'AOC', 'N', 80),
('5005220', 'Métodos Para a Produção do Conhecimento', 'MPPC', 'T', 80),
('4208010', 'Laboratório de Hardware', 'LABH', 'T', 80),
('4226004', 'Banco de Dados', 'BD', 'T', 80),
('4213003', 'Sistemas Operacionais I', 'SOI', 'T', 80),
('4213013', 'Sistemas Operacionais I', 'SOI', 'N', 80),
('4233005', 'Laboratório de Banco de Dados', 'LBD', 'T', 80)

-------------------------------------------------------------------------------------------------------------------------------------------
--SELECTS
SELECT * FROM avaliacao

SELECT * FROM aluno

SELECT * FROM faltas

SELECT * FROM disciplina

SELECT * FROM notas 

-------------------------------------------------------------------------------------------------------------------------------------------
--FUNCTIONS
--FUNCTION para calcular a media dos alunos
CREATE FUNCTION fn_media(@sigla CHAR(5), @turno CHAR(1))
RETURNS @table TABLE(
ra           CHAR(11),
nome_aluno   VARCHAR(100),
nota1        DECIMAL(4,1),
nota2        DECIMAL(4,1),
nota3        DECIMAL(4,1),
media_final  DECIMAL(4,1),
total_falta         INT,
situacao     VARCHAR(9)
)
AS
BEGIN
	DECLARE	@ra    CHAR(11),
			@nome     VARCHAR(100),
			@nota1	  DECIMAL(4,1),
			@nota2	  DECIMAL(4,1),
			@nota3 	  DECIMAL(4,1),
			@media    DECIMAL(4,1),
			@total_ft INT,
			@situacao VARCHAR(9)

	
	DECLARE c CURSOR FOR SELECT a.ra 
							FROM notas n, aluno a, disciplina d 
							WHERE d.cod_disc = n.cod_disc 
							AND d.sigla IN (@sigla) 
							AND d.turno IN (@turno)
							AND n.ra_al = a.ra 
							GROUP BY a.ra
	OPEN c
	FETCH NEXT FROM c INTO @ra
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @nome = (SELECT nome FROM aluno WHERE ra = @ra)

		SET @nota1 = (SELECT n.nota
						FROM notas n, avaliacao av, aluno a
						WHERE av.cod_av = n.cod_av
						AND av.tipo IN ('P1', 'MC')
						AND n.ra_al = a.ra
						AND a.ra = @ra)

		SET @nota2 = (SELECT n.nota
						FROM notas n, avaliacao av, aluno a
						WHERE av.cod_av = n.cod_av
						AND av.tipo IN ('P2', 'MP')
						AND n.ra_al = a.ra
						AND a.ra = @ra)

		SET @nota3 = (SELECT n.nota
						FROM notas n, avaliacao av, aluno a
						WHERE av.cod_av = n.cod_av
						AND av.tipo IN ('T')
						AND n.ra_al = a.ra
						AND a.ra = @ra)

		SET @media = (SELECT CAST(SUM((av.peso * n.nota)) AS DECIMAL(4,1))
						FROM notas n, avaliacao av, aluno a
						WHERE av.cod_av = n.cod_av
						AND n.ra_al = a.ra
						AND a.ra = @ra)

		SELECT @total_ft = SUM(LEN(presenca) - LEN(REPLACE(presenca, 'F', ''))) FROM faltas WHERE ra = @ra

		IF (@sigla = 'MPPC')
		BEGIN
			IF (@media < 6 AND @total_ft > 11)
			BEGIN
				SET @situacao = 'Reprovado'
			END
			ELSE
			BEGIN
				SET @situacao = 'Aprovado'
			END
		END
		ELSE
		BEGIN
			IF (@media >= 6 AND @total_ft < 21)
			BEGIN
				SET @situacao = 'Aprovado'
			END
			ELSE
			BEGIN
				SET @situacao = 'Reprovado'
			END
		END

		INSERT INTO @table VALUES (@ra, @nome, @nota1, @nota2, @nota3, @media, @total_ft, @situacao)
		FETCH NEXT FROM c INTO @ra
	END

	CLOSE c
	DEALLOCATE c
	RETURN
END

 
SELECT * FROM dbo.fn_media ('AOC', 'N')

---------------------------------------------------------------------------------------------------------------------------------
--FUNCTION para mostrar as faltas dos alunos
CREATE FUNCTION fn_ObterDadosPresenca(@siglaF CHAR(4), @turnoF CHAR(1))
RETURNS @resultado TABLE (
    ra CHAR(10),
    [Data1] VARCHAR(4),
    [Data2] VARCHAR(4),
    [Data3] VARCHAR(4),
    [Data4] VARCHAR(4),
	[Data5] VARCHAR(4),
	[Data6] VARCHAR(4),
	[Data7] VARCHAR(4),
	[Data8] VARCHAR(4),
	[Data9] VARCHAR(4),
	[Data10] VARCHAR(4),
	[Data11] VARCHAR(4),
	[Data12] VARCHAR(4),
	[Data13] VARCHAR(4),
	[Data14] VARCHAR(4),
	[Data15] VARCHAR(4),
	[Data16] VARCHAR(4),
	[Data17] VARCHAR(4),
	[Data18] VARCHAR(4),
	[Data19] VARCHAR(4),
	[Data20] VARCHAR(4),
    TotalFaltas INT
)
AS
BEGIN
    DECLARE @ra CHAR(10)
    DECLARE @dt DATE
    DECLARE @presenca VARCHAR(4)
    DECLARE @data1 DATE
    DECLARE @data2 DATE
    DECLARE @data3 DATE
    DECLARE @data4 DATE
	DECLARE @data5 DATE
	DECLARE @data6 DATE
	DECLARE @data7 DATE
	DECLARE @data8 DATE
	DECLARE @data9 DATE
	DECLARE @data10 DATE
	DECLARE @data11 DATE
	DECLARE @data12 DATE
	DECLARE @data13 DATE
	DECLARE @data14 DATE
	DECLARE @data15 DATE
	DECLARE @data16 DATE
	DECLARE @data17 DATE
	DECLARE @data18 DATE
	DECLARE @data19 DATE
	DECLARE @data20 DATE
    DECLARE @totalFaltas INT
	DECLARE @presenca1 VARCHAR(4),
         @presenca2 VARCHAR(4),
         @presenca3 VARCHAR(4),
         @presenca4 VARCHAR(4),
         @presenca5 VARCHAR(4),
         @presenca6 VARCHAR(4),
         @presenca7 VARCHAR(4),
         @presenca8 VARCHAR(4),
         @presenca9 VARCHAR(4),
         @presenca10 VARCHAR(4),
         @presenca11 VARCHAR(4),
         @presenca12 VARCHAR(4),
         @presenca13 VARCHAR(4),
         @presenca14 VARCHAR(4),
         @presenca15 VARCHAR(4),
         @presenca16 VARCHAR(4),
         @presenca17 VARCHAR(4),
         @presenca18 VARCHAR(4),
         @presenca19 VARCHAR(4),
         @presenca20 VARCHAR(4)

    -- Cursor para percorrer os registros
    DECLARE c CURSOR FOR
    SELECT f.ra, f.dt, f.presenca
    FROM faltas f, disciplina d
	WHERE d.cod_disc = f.cod_disc
	AND d.sigla IN (@siglaF)
	AND d.turno IN (@turnoF)
	GROUP BY f.ra, f.dt, f.presenca	

    OPEN c

    -- Inicializar variáveis
    SET @data1 = (SELECT MIN(dt) FROM faltas f, disciplina d WHERE f.cod_disc = d.cod_disc AND d.sigla = @siglaF AND d.turno = @turnoF)
    SET @data2 = ''
    SET @data3 = ''
    SET @data4 = ''
	SET @data5 = ''
	SET @data6 = ''
	SET @data7 = ''
	SET @data8 = ''
	SET @data9 = ''
	SET @data10 = ''
	SET @data11 = ''
	SET @data12 = ''
	SET @data13 = ''
	SET @data14 = ''
	SET @data15 = ''
	SET @data16 = ''
	SET @data17 = ''
	SET @data18 = ''
	SET @data19 = ''
	SET @data20 = ''
    SET @totalFaltas = 0

    -- Loop através dos registros
    FETCH NEXT FROM c INTO @ra, @dt, @presenca
    WHILE @@FETCH_STATUS = 0
    BEGIN
       -- Preencher os valores da presença de cada data
	   IF(@data1 = @dt)
		 BEGIN
		      SET @presenca1 = @presenca
			  SET @data2 = DATEADD(DAY, 7, @data1)
		 END
        ELSE IF(@data2 = @dt)
			BEGIN
		      SET @presenca2 = @presenca
			  SET @data3 = DATEADD(DAY, 7, @data2)
			END
        ELSE IF(@data3 = @dt)
			BEGIN
		      SET @presenca3 = @presenca
			  SET @data4 = DATEADD(DAY, 7, @data3)
			END
		ELSE IF(@data4 = @dt)
			BEGIN
		      SET @presenca4 = @presenca
			  SET @data5 = DATEADD(DAY, 7, @data4)
			END
		ELSE IF(@data5 = @dt)
			BEGIN
		      SET @presenca5 = @presenca
			  SET @data6 = DATEADD(DAY, 7, @data5)
			END
		ELSE IF(@data6 = @dt)
			BEGIN
		      SET @presenca6 = @presenca
			  SET @data7 = DATEADD(DAY, 7, @data6)
			END
		ELSE IF(@data7 = @dt)
			BEGIN
		      SET @presenca7 = @presenca
			  SET @data8 = DATEADD(DAY, 7, @data7)
			END
		ELSE IF(@data8 = @dt)
			BEGIN
		      SET @presenca8 = @presenca
			  SET @data9 = DATEADD(DAY, 7, @data8)
			END
		ELSE IF(@data9 = @dt)
			BEGIN
		      SET @presenca9 = @presenca
			  SET @data10 = DATEADD(DAY, 7, @data9)
			END
		ELSE IF(@data10 = @dt)
			BEGIN
		      SET @presenca10 = @presenca
			  SET @data11 = DATEADD(DAY, 7, @data10)
			END
		ELSE IF(@data11 = @dt)
			BEGIN
		      SET @presenca11 = @presenca
			  SET @data12 = DATEADD(DAY, 7, @data11)
			END
		ELSE IF(@data12 = @dt)
			BEGIN
		      SET @presenca12 = @presenca
			  SET @data13 = DATEADD(DAY, 7, @data12)
			END
		ELSE IF(@data13 = @dt)
			BEGIN
		      SET @presenca13 = @presenca
			  SET @data14 = DATEADD(DAY, 7, @data13)
			END
		ELSE IF(@data14 = @dt)
			BEGIN
		      SET @presenca14 = @presenca
			  SET @data15 = DATEADD(DAY, 7, @data14)
			END
		ELSE IF(@data15 = @dt)
			BEGIN
		      SET @presenca15 = @presenca
			  SET @data16 = DATEADD(DAY, 7, @data15)
			END
		ELSE IF(@data16 = @dt)
			BEGIN
		      SET @presenca16 = @presenca
			  SET @data17 = DATEADD(DAY, 7, @data16)
			END
		ELSE IF(@data17 = @dt)
			BEGIN
		      SET @presenca17 = @presenca
			  SET @data18 = DATEADD(DAY, 7, @data17)
			END
		ELSE IF(@data18 = @dt)
			BEGIN
		      SET @presenca18 = @presenca
			  SET @data19 = DATEADD(DAY, 7, @data18)
			END
		ELSE IF(@data19 = @dt)
			BEGIN
		      SET @presenca19 = @presenca
			  SET @data20 = DATEADD(DAY, 7, @data20)
			END
		ELSE IF(@data20 = @dt)
			BEGIN
		      SET @presenca20 = @presenca
			END

        -- Calcular o total de faltas
        SELECT @totalFaltas = SUM(LEN(presenca) - LEN(REPLACE(presenca, 'F', ''))) FROM faltas WHERE ra = @ra

        FETCH NEXT FROM c INTO @ra, @dt, @presenca
    END

    CLOSE c
    DEALLOCATE c

    -- Inserir os dados na tabela de resultado
    INSERT INTO @resultado (ra, [Data1], [Data2], [Data3], [Data4], [Data5], [Data6], [Data7], [Data8], [Data9], [Data10], [Data11], [Data12], [Data13], [Data14], [Data15], [Data16], [Data17], [Data18], [Data19], [Data20], TotalFaltas)
    VALUES (@ra, @presenca1, @presenca2, @presenca3, @presenca4, @presenca5, @presenca6, @presenca7, @presenca8, @presenca9, @presenca10, @presenca11, @presenca12, @presenca13, @presenca14, @presenca15, @presenca16, @presenca17, @presenca18, @presenca19, @presenca20, @totalFaltas)

    RETURN
END

SELECT * FROM fn_ObterDadosPresenca('AOC', 'T')
