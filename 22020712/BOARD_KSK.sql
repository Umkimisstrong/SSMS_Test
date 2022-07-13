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

DROP TABLE TB_USER;

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
--==>> Commands completed successfully.

-- 003. ������ �Է�(1) ȸ�� / TB_USER
INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('skkim@mostisoft.com', '961004-1030721', '����', '010-5693-4223');
--==>> (1 row affected)

INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('hskim@mostisoft.com', '961004-1112223', '��ȿ��', '010-2233-4443');
--==>> (1 row affected)

-- 003. ������ �Է�(2) �Խù� / TB_BOARD -- ������� ����
INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(SELECT COUNT(*) + 1 AS [COUNT]
		FROM TB_BOARD)
		, '�ȳ��ϼ���, ���� �Դϴ�.'
		, '������ �λ�'
		, 'skkim@mostisoft.com');
--==>> (1 row affected)

INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_BOARD)
		, '�ȳ��ϼ���, ��ȿ�� �Դϴ�.'
		, '��ȿ���� �λ�'
		, 'hskim@mostisoft.com');
--==>> (1 row affected)

-- BOARD_LIST �Խ��Ǹ���Ʈ�� ��µǴ� ����
SELECT ROW_NUMBER() OVER(ORDER BY B.BOARD_ID) AS [ROWNUM]
     , B.BOARD_ID
	 , B.BOARD_TITLE
	 , B.BOARD_HITCOUNT
	 , B.BOARD_DATE
	 , U.U_NAME
FROM TB_BOARD B JOIN TB_USER U
	 ON B.U_ID = U.U_ID;
--==>> 1	�ȳ��ϼ���, ���� �Դϴ�.	������ �λ�	0	2022-07-13	skkim@mostisoft.com
-- view ����
CREATE VIEW BOARD_LIST_VIEW
AS
SELECT ROW_NUMBER() OVER(ORDER BY B.BOARD_ID) AS [ROWNUM], B.BOARD_ID, B.BOARD_TITLE, B.BOARD_HITCOUNT, B.BOARD_DATE, U.U_NAME FROM TB_BOARD B JOIN TB_USER U 	 ON B.U_ID = U.U_ID;
--==>> Commands completed successfully.

SELECT *
FROM BOARD_LIST_VIEW;

-- �� �� ����
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME FROM BOARD_LIST_VIEW;



-- 004. ������ ����

-- 005. ������ ����

-- 005. ������ ��ȸ




