-- ���̺� ���� (TB_TODO)
CREATE TABLE TB_TODO
(
	TODO_ID			INT				NOT NULL
  ,	U_TODO			VARCHAR(200)	NOT NULL
  , TODO_STATUS		VARCHAR(8)		DEFAULT 'N'
  , CONSTRAINT TB_TODO__ID_PK PRIMARY KEY(TODO_ID)
  , CONSTRAINT TB_TODO_STATUS_CK CHECK(TODO_STATUS = 'Y' OR TODO_STATUS = 'N' OR TODO_STATUS = 'D' )
);
--==>> Commands completed successfully.


-- ������ ����(TODO_SEQ)
CREATE SEQUENCE TODO_SEQ 
AS DECIMAL(18, 0)
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100
CYCLE
CACHE 1;
--==>> Commands completed successfully.

-- TB_TODO ���̺� ������ �Է�
INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'ASP.NET STUDY');
--==>> (1 row affected)

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'ASP.NET MVC STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'ASP.NET WINDOW FORM STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'ASP.NET ADO.NET STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'C# STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'JAVASCRIPT STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'HTML STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'CSS STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'SQL SERVER STUDY');

INSERT INTO TB_TODO(TODO_ID, U_TODO)
VALUES(NEXT VALUE FOR TODO_SEQ, 'FRAMEWORK STUDY');

-- TB_TODO ���̺� ������ ��ȸ
SELECT *
FROM TB_TODO;
--==>> 1	ASP.NET STUDY	N

-- TB_TODO ���̺� ������ UPDATE
UPDATE TB_TODO
SET TODO_STATUS = 'Y'
WHERE TODO_ID = 1;
--==>> (1 row affected)

-- TB_TODO ���̺� ������ ��ȸ
SELECT *
FROM TB_TODO;

-- TB_TODO ���̺� ������ UPDATE
UPDATE TB_TODO
SET TODO_STATUS = 'D'
WHERE TODO_ID = 1;
--==>> (1 row affected)

-- TB_TODO ���̺� ������ ��ȸ
SELECT *
FROM TB_TODO;
--==>> 1	ASP.NET STUDY	D

-- TB_TODO ���̺� ������ UPDATE
UPDATE TB_TODO
SET TODO_STATUS = 'L'
WHERE TODO_ID = 1;
/*
Msg 547, Level 16, State 0, Line 56
UPDATE ���� CHECK ���� ���� "TB_TODO_STATUS_CK"��(��) �浹�߽��ϴ�. �����ͺ��̽� "TEST_KSK", ���̺� "dbo.TB_TODO", column 'TODO_STATUS'���� �浹�� �߻��߽��ϴ�.
���� ����Ǿ����ϴ�.

--> STATUS �� Y N D �� ����
*/


-- TB_TODO ���� STATUS �� D �� �ƴѰ͸� ��ȸ
SELECT ROW_NUMBER() OVER(ORDER BY TODO_ID ASC) AS [ROWNUM], TODO_ID, U_TODO, TODO_STATUS
FROM TB_TODO
WHERE TODO_STATUS != 'D'



