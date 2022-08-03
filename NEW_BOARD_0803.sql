USE TEST_KSK;
--==>> Commands completed successfully.

SELECT USER
--==>> mosti_ksk

----------------------------------------------------------------------------------------------------
-- �� ���� ���̺� ��ȸ(TB_USER)
SELECT *
FROM TB_USER;
/*
	U_ID U_PWD U_NAME U_TEL
*/

-- �� ���̺� ����(TB_USER)
ALTER TABLE TB_USER
ADD U_DATE DATE	DEFAULT GETDATE();
--==>> Commands completed successfully.

-- �� ������ ���̺� ��ȸ(TB_USER)
SELECT *
FROM TB_USER;
/*
	U_ID U_PWD U_NAME U_TEL U_DATE
*/

-- �� ���� ������ ����(TB_USER)
DELETE
FROM TB_USER;
/*
Msg 547, Level 16, State 0, Line 28
DELETE ���� REFERENCE ���� ���� "ANSWER_UID_FK"��(��) �浹�߽��ϴ�. �����ͺ��̽� "TEST_KSK", ���̺� "dbo.TB_ANSWER", column 'U_ID'���� �浹�� �߻��߽��ϴ�.
���� ����Ǿ����ϴ�.

--> �亯�� �־ ���� �Ұ�
*/

-- �� �亯 ���̺� ��ȸ(TB_ANSWER)
SELECT *
FROM TB_ANSWER;
/*
2	ZXC	2022-07-24	2	1	skkim@mostisoft.com	0
3	ASD	2022-07-24	2	1	skkim@mostisoft.com	0
*/
-- �� �亯���̺� ������ ����(TB_ANSWER)
DELETE
FROM TB_ANSWER;
/*
	(2 rows affected)
*/

-- �� ȸ�� ���̺� ������ ����(TB_USER)
DELETE
FROM TB_USER;
/*
Msg 547, Level 16, State 0, Line 53
DELETE ���� REFERENCE ���� ���� "CT_BOARD_UID_FK"��(��) �浹�߽��ϴ�. �����ͺ��̽� "TEST_KSK", ���̺� "dbo.TB_BOARD", column 'U_ID'���� �浹�� �߻��߽��ϴ�.
���� ����Ǿ����ϴ�.

--> �Խù� ���̺� �����Ͱ� �����ؼ� ���� �Ұ�
*/

-- �� �Խù� ���̺� ������ ����(TB_BOARD)
DELETE
FROM TB_BOARD;
/*
Msg 547, Level 16, State 0, Line 64
DELETE ���� REFERENCE ���� ���� "CT_REPLY_BOARDID_FK"��(��) �浹�߽��ϴ�. �����ͺ��̽� "TEST_KSK", ���̺� "dbo.TB_REPLY", column 'BOARD_ID'���� �浹�� �߻��߽��ϴ�.
���� ����Ǿ����ϴ�.

--> ��� ���̺� �����Ͱ� �����ؼ� ���� �Ұ�
*/

-- �� ��� ���̺� ������ ����(TB_REPLY)
DELETE
FROM TB_REPLY;
--==>> (1 row affected)

-- �� �Խù� ���̺� ������ ����(TB_BOARD)
DELETE
FROM TB_BOARD;
--==>> (1 row affected)

-- �� ȸ�� ���̺� ������ ����(TB_USER)
DELETE
FROM TB_USER;
--==>> (2 rows affected)

----------------------------------------------------------------------------------------------------
-- �� ��ü �����Ͱ� ������ ��Ȳ
--    �ʿ��� �����͸� �߰��� �Է��ϱ� ���� ���̺� ���� ����
--    �� TB_USER   : U_STATUS (����) �÷� �߰� (ACTIVE : Ȱ�� / ��Ȱ�� : NONACTIVE )
--                 : ���� ȸ������ �� ACTIVE, ȸ�� Ż�� �� NONACTIVE �� ����
--    �� TB_BOARD  : ����
--    �� TB_REPLY  : ����
--    �� TB_ANSWER : ����

-- �� ���� ���̺� ���� �÷� �߰�(U_STATUS)
ALTER TABLE TB_USER
ADD U_STATUS	VARCHAR(20) DEFAULT 'ACTIVE';
--==>> Commands completed successfully.

-- �� ���� ���̺� �÷� ��ȸ(TB_USER)
SELECT *
FROM TB_USER;
--==>> U_ID	U_PWD	U_NAME	U_TEL	U_DATE	U_STATUS

-- �� �Խù� ���̺� �÷� ��ȸ(TB_BOARD)
SELECT *
FROM TB_BOARD;
--==>> BOARD_ID	BOARD_TITLE	BOARD_CONTENT	BOARD_HITCOUNT	BOARD_DATE	U_ID	DEL_CHECK

-- �� ��� ���̺� �÷� ��ȸ(TB_REPLY)
SELECT *
FROM TB_REPLY;
--==>> REPLY_ID	REPLY_CONTENT	REPLY_DATE	U_ID	BOARD_ID	DEL_CHECK

-- �� �亯 ���̺� �÷� ��ȸ(TB_ANSWER)
SELECT *
FROM TB_ANSWER;
--==>> ANSWER_ID	ANSWER_CONTENT	ANSWER_DATE	BOARD_ID	REPLY_ID	U_ID	DEL_CHECK

----------------------------------------------------------------------------------------------------
-- �� ���ν��� ���� ���� ��
-- 1. �߰� : C

-- �� ���ν��� ���� : ȸ�� �߰� (USER_C)
GO
CREATE PROCEDURE USER_C
(
   -- �Ķ���� / ������Ÿ��
	@U_ID			VARCHAR(200)
  , @U_PWD			CHAR(14)
  , @U_NAME			VARCHAR(20)
  , @U_TEL			VARCHAR(13)
)
AS
BEGIN
	
	INSERT INTO TB_USER
	(
		  U_ID
		, U_PWD
		, U_NAME
		, U_TEL
	)
	VALUES
	(
		  @U_ID
		, @U_PWD
		, @U_NAME
		, @U_TEL
	);

END;
--==>> Commands completed successfully.



-- �� ���ν��� ���� : �Խù� �߰� (BOARD_C)
GO
CREATE PROCEDURE BOARD_C
(
	  @BOARD_TITLE		VARCHAR(300)
	, @BOARD_CONTENT	VARCHAR(8000)
	, @U_ID				VARCHAR(200)
)
AS
BEGIN
	
	INSERT INTO TB_BOARD
	(
		  BOARD_ID
		, BOARD_TITLE
		, BOARD_CONTENT
		, U_ID
	)
	VALUES
	(
		  NEXT VALUE FOR dbo.USER_SEQ
		, @BOARD_TITLE
		, @BOARD_CONTENT
		, @U_ID
	);

END;
--==>> Commands completed successfully.

-- �� ���ν��� ���� : ��� �߰� (REPLY_C)
GO
CREATE PROCEDURE REPLY_C
(
	@REPLY_CONTENT		VARCHAR(100)
  , @U_ID				VARCHAR(200)
  , @BOARD_ID			INT
)
AS
BEGIN
	
	INSERT INTO TB_REPLY
	(
		  REPLY_ID
		, REPLY_CONTENT
		, U_ID
		, BOARD_ID
	)
	VALUES
	(
		  NEXT VALUE FOR dbo.REPLY_SEQ
	    , @REPLY_CONTENT
		, @U_ID
		, @BOARD_ID
	);

END;
--==>> Commands completed successfully.

-- �� ���ν��� ���� : �亯 �߰� (ANSWER_C)
GO
CREATE PROCEDURE ANSWER_C
(
	  @ANSWER_CONTENT	VARCHAR(100)
	, @BOARD_ID			INT
	, @REPLY_ID			INT	
	, @U_ID				VARCHAR(200)
)
AS
BEGIN

	INSERT INTO TB_ANSWER
	(
		  ANSWER_ID
		, ANSWER_CONTENT
		, BOARD_ID
		, REPLY_ID
		, U_ID
	)
	VALUES
	(
		  NEXT VALUE FOR dbo.ANSWER_SEQ
		, @ANSWER_CONTENT
		, @BOARD_ID
		, @REPLY_ID
		, @U_ID
	);

END;



-- 2. ��ȸ : R
-- �� ���ν��� ���� : ȸ�� ��ȸ 
      --> ȸ�� ��ȸ �� STATUS �� ACTIVE �� ȸ���� ��ȸ

-- �� ���ν��� ���� : �Խù� ��ȸ
      --> �Խù� ��ȸ�� DEL_CHECK �� 0 �� �Խù��� ��ȸ

-- �� ���ν��� ���� : ��� ��ȸ
      --> ��� ��ȸ �� DEL_CHECK �� 0�� ��۸� ��ȸ
	  --> ����� ���Ӽ��� �Խù��� �����Ƿ� BOARD_ID �� �Ű������� �Ѵ�.

-- �� ���ν��� ���� : �亯 ��ȸ
      --> �亯 ��ȸ �� DEL_CHECK �� 0�� �亯�� ��ȸ
	  --> �亯�� ���Ӽ��� �Խù���, ��ۿ� �����Ƿ� BOARD_ID�� REPLY_ID �� �Ű������� �Ѵ�.

-- 3. ���� : U
      -- �� ��� UPDATE ������ ID �� �Ű������� �Ѵ�.
	  --    ID �� ���ٸ� ���ν����� ������� �ʴ´�.
	  --    ID �� �ִٸ� �Ѱܹ��� �Ű������� ID�� ������ �÷��� �ȴ�.

-- �� ���ν��� ���� : ȸ�� ����
-- �� ���ν��� ���� : �Խù� ����
-- �� ���ν��� ���� : ��� ����
-- �� ���ν��� ���� : �亯 ����


-- 4. ���� : D

--    �� ��ǻ� STATUS �� DEL_CHECK �� UPDATE

-- �� ���ν��� ���� : ȸ�� ����
-- �� ���ν��� ���� : �Խù� ����
-- �� ���ν��� ���� : ��� ����
-- �� ���ν��� ���� : �亯 ����










