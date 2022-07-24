-- TB_BOARD ���� ��� ������

-- 001. DB ���� : TEST_KSK
USE TEST_KSK;

-- 002. ���̺� ����(1) / ȸ�� / TB_USER
CREATE TABLE TB_USER
(
	U_ID	VARCHAR(200)	NOT NULL	-- ���̵�(�̸���)
  ,	U_PWD	CHAR(14)		NOT NULL	-- ��й�ȣ(�ֹι�ȣ)
  , U_NAME  VARCHAR(20)		NOT NULL	-- �̸� 
  , U_TEL	VARCHAR(13)		NOT NULL	-- ��ȭ��ȣ 010-1111-1111
  , CONSTRAINT CT_USER_ID_PK PRIMARY KEY(U_ID)
);
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 002. ���̺� ����(2) / �Խù� / TB_BOARD
CREATE TABLE TB_BOARD
(
	BOARD_ID		INT				NOT NULL  -- ��ȣ
  , BOARD_TITLE		VARCHAR(300)	NOT NULL  -- ����
  , BOARD_CONTENT	VARCHAR(8000)	NOT NULL  -- ����
  , BOARD_HITCOUNT  INT				DEFAULT 0 -- ��ȸ��
  , BOARD_DATE		DATE			DEFAULT GETDATE()   -- ��¥
  , U_ID			VARCHAR(200)	NOT NULL  -- �ۼ��� ID(�̸���)
  , CONSTRAINT CT_BOARD_ID_PK PRIMARY KEY(BOARD_ID)
  , CONSTRAINT CT_BOARD_UID_FK FOREIGN KEY(U_ID)
			   REFERENCES TB_USER(U_ID)
);
--==>> Commands completed successfully.
ALTER TABLE TB_BOARD
ADD DEL_CHECK	INT	DEFAULT 0;

----------------------------------------------------------------------
-- 002. ���̺� ����(3) / ��� / TB_REPLY
CREATE TABLE TB_REPLY
(
	REPLY_ID		INT				NOT NULL
  , REPLY_CONTENT	VARCHAR(100)	NOT NULL
  , REPLY_DATE		DATE			DEFAULT GETDATE()
  , U_ID			VARCHAR(200)	NOT NULL
  , BOARD_ID		INT				NOT NULL		
  , CONSTRAINT CT_REPLY_ID_PK	PRIMARY KEY(REPLY_ID)
  , CONSTRAINT CT_REPLY_UID_FK	FOREIGN KEY(U_ID)
			   REFERENCES TB_USER(U_ID)
  , CONSTRAINT CT_REPLY_BOARDID_FK	FOREIGN KEY(BOARD_ID)
			   REFERENCES TB_BOARD(BOARD_ID)
);
----------------------------------------------------------------------
-- 003. ������ �Է�(1) ȸ�� / TB_USER
INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('skkim@mostisoft.com', '961004-1030721', '����', '010-5693-4223');
--==>> (1 row affected)

INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('hskim@mostisoft.com', '961004-1112223', '��ȿ��', '010-2233-4443');
--==>> (1 row affected)

----------------------------------------------------------------------
-- 003. ������ �Է�(2) �Խù� / TB_BOARD
INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(NEXT VALUE FOR BOARD_SEQ)
		, '�ȳ��ϼ���, ���� �Դϴ�.'
		, '������ �λ�'
		, 'skkim@mostisoft.com');
--==>> (1 row affected)

INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(NEXT VALUE FOR BOARD_SEQ)
		, '�ȳ��ϼ���, ���� �Դϴ�.'
		, '������ �λ�'
		, 'skkim@mostisoft.com');
DELETE
FROM TB_BOARD;
----------------------------------------------------------------------
-- 003. ������ �Է�(3) ��� / TB_REPLY
INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)
VALUES( (NEXT VALUE FOR REPLY_SEQ)
		 , '�ȳ��ϼ��� ���� ��ȿ�� �̿���'
		 , 'hskim@mostisoft.com'
		 , 1);
--==>> (1 row affected)

----------------------------------------------------------------------

-- 004. ������ ����
UPDATE TB_BOARD
SET BOARD_TITLE = '�ȳ��ϼ��� �����߾��', BOARD_CONTENT = '�ȳ��ϼ��� ��¥�����Ѱ��̿���'
WHERE BOARD_ID = 3;
--==>> (1 row affected)

----------------------------------------------------------------------

-- 005. ������ ���� -- TB_BOARD �� DEL_CHECK �� 1�� ������Ʈ
UPDATE TA_BOARD SET DEL_CHECK = 1 WHERE BOARD_ID = 1;
SELECT *
FROM TB_BOARD;

----------------------------------------------------------------------

-- 006. �Խù� ��ü ��ȸ�� ���� BASE VIEW ����
CREATE VIEW BOARD_LIST_VIEW
AS
SELECT B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, B.BOARD_DATE, B.U_ID, B.DEL_CHECK, U.U_NAME FROM TB_BOARD B JOIN TB_USER U ON B.U_ID = U.U_ID;
--==>> Commands completed successfully.


-- 006-1. �Խù� ��ü ��ȸ�� ���� ���� VIEW ����
CREATE VIEW BOARD_LIST_VIEW2
AS
SELECT B.ROWNUM, B.BOARD_ID, B.BOARD_TITLE, B.BOARD_HITCOUNT, B.BOARD_CONTENT, B.BOARD_DATE, B.U_NAME FROM (SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY BOARD_ID)) AS [ROWNUM], BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_CONTENT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], U_NAME FROM BOARD_LIST_VIEW WHERE DEL_CHECK = 0 )B

-- �Խù� ��ü ��ȸ�� ���� ���� VIEW ����
ALTER VIEW BOARD_LIST_VIEW2
AS
SELECT B.ROWNUM, B.BOARD_ID, B.BOARD_TITLE, B.BOARD_HITCOUNT, B.BOARD_CONTENT, B.BOARD_DATE, B.U_NAME FROM (SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY BOARD_ID)) AS [ROWNUM], BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_CONTENT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], U_NAME FROM BOARD_LIST_VIEW WHERE DEL_CHECK = 0 )B

----------------------------------------------------------------------

-- 007. ���� �Խù� ��ȸ�� ���� BASE VIEW ����
CREATE VIEW BOARD_DETAIL_VIEW
AS
SELECT B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, CONVERT(VARCHAR(8), B.BOARD_DATE, 112) AS [BOARD_DATE]
     , U.U_ID, U.U_NAME, ISNULL(R.U_ID, '����') AS [REPLY_U_ID]
	 , ISNULL(R.REPLY_ID, 0) AS [REPLY_ID], ISNULL(R.REPLY_CONTENT, '����') AS [REPLY_CONTENT]
	 , ISNULL(CONVERT(VARCHAR(8), R.REPLY_DATE, 112), '����') AS [REPLY_DATE]
FROM TB_BOARD B JOIN TB_USER U
     ON B.U_ID = U.U_ID
	 LEFT OUTER JOIN TB_REPLY R
	 ON B.BOARD_ID = R.BOARD_ID;
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 007-1. ���� �Խù� ��ȸ�� ���� ���� VIEW ����
CREATE VIEW BOARD_DETAIL_VIEW2
AS
SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY BOARD_ID)) AS [ROWNUM], B.BOARD_ID, B.BOARD_TITLE, B.BOARD_HITCOUNT, CONVERT(VARCHAR(8), B.BOARD_DATE, 112) AS [BOARD_DATE], B.BOARD_CONTENT, B.U_ID, B.U_NAME
FROM
( 
SELECT BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], BOARD_CONTENT, U_ID, U_NAME
  FROM BOARD_LIST_VIEW
  WHERE DEL_CHECK = 0 
)B;
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 008. ���� �Խù��� ��� ��ȸ�� ���� ���� VIEW ����
CREATE VIEW REPLY_LIST_VIEW
AS
SELECT R.REPLY_ID, R.REPLY_CONTENT, CONVERT(VARCHAR(8), R.REPLY_DATE, 112) AS [REPLY_DATE]
     , R.BOARD_ID, U.U_NAME
FROM TB_REPLY R JOIN TB_USER U
	 ON R.U_ID = U.U_ID;
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 009. ��ü �Խù� ��ȸ ����
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME 
FROM BOARD_LIST_VIEW2
WHERE ROWNUM >= ? AND ROWNUM <= ?; 

-- ���� : �˻��� ���յ� ����
SELECT BOARD.ROWNUM, BOARD.BOARD_ID, BOARD.BOARD_TITLE, BOARD.BOARD_HITCOUNT, BOARD.BOARD_DATE, BOARD.U_NAME 
FROM
(
	SELECT ROW_NUMBER() OVER(ORDER BY BOARD_ID) AS [ROWNUM], BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME
	FROM BOARD_LIST_VIEW2 WHERE {0} LIKE '{1}'
) [BOARD]
WHERE BOARD.ROWNUM >= {2} AND BOARD.ROWNUM <= {3}; 


----------------------------------------------------------------------

-- 010. ���� �Խù� ��ȸ ����
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], BOARD_CONTENT, U_ID, U_NAME
FROM BOARD_DETAIL_VIEW2 
WHERE BOARD_ID = ?

----------------------------------------------------------------------

-- 011. ���� �Խù� ��� ��ȸ ����
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY REPLY_ID)) AS [ROWNUM], REPLY_ID, REPLY_CONTENT, CONVERT(VARCHAR(8), REPLY_DATE, 112) AS [REPLY_DATE], BOARD_ID, U_NAME 
FROM REPLY_LIST_VIEW 
WHERE BOARD_ID = ?

----------------------------------------------------------------------

-- 012. LOGIN �� USER Ȯ���� ���� ����
SELECT COUNT(*) AS [U_COUNT]
FROM TB_USER
WHERE U_ID = ? AND U_PWD = ?;

----------------------------------------------------------------------

-- 013. ����¡�� ���� ��ü ������ ��ȸ ����(DEL_CHECK �� 0�� �͸�)
SELECT COUNT(*) AS [DATACOUNT]
FROM BOARD_LIST_VIEW2

----------------------------------------------------------------------

-- 014. ����� �̸��� ��ȯ�ϴ� ����
SELECT U_NAME
FROM TB_USER
WHERE U_ID = ?

----------------------------------------------------------------------

-- 015. �˻��� ���� ������ ���� ��ȸ�ϴ� ����
SELECT COUNT(*) AS [DATACOUNT]
FROM BOARD_LIST_VIEW2
WHERE U_NAME LIKE '%����%';

SELECT COUNT(*) AS [DATACOUNT] FROM BOARD_LIST_VIEW2 WHERE 'BOARD_TITLE' LIKE '%�ȳ��ϼ���%';



