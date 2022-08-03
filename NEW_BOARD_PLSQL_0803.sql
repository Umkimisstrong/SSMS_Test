USE TEST_KSK;
GO
-- �� ���ν��� ���� ����
-- 1. �߰� : C

-- �� ȸ�� �߰� ( USER_C )
DECLARE	@U_ID			VARCHAR(200)
DECLARE @U_PWD			CHAR(14)
DECLARE @U_NAME			VARCHAR(20)
DECLARE @U_TEL			VARCHAR(13)

SET @U_ID = 'skkim@mostisoft.com'
SET @U_PWD = '961004-1111111'
SET @U_NAME = '����'
SET @U_TEL = '010-5555-4444'

	EXEC USER_C @U_ID, @U_PWD, @U_NAME, @U_TEL;

--==>> (1 row affected)

-- �� ȸ�� ��ȸ
SELECT *
FROM TB_USER;
--==>> skkim@mostisoft.com	961004-1111111	����	010-5555-4444	2022-08-03	ACTIVE


-- �� �Խù� �߰� ( BOARD_C )
GO
DECLARE @BOARD_TITLE		VARCHAR(300)
DECLARE @BOARD_CONTENT		VARCHAR(8000)
DECLARE @U_ID				VARCHAR(200)


SET @BOARD_TITLE = '������ �Խù�'
SET @BOARD_CONTENT = '���ν����� �Է��� �Խù� ����'
SET @U_ID = 'skkim@mostisoft.com'

	EXEC BOARD_C @BOARD_TITLE, @BOARD_CONTENT, @U_ID;

--==>> (1 row affected)

-- �� �Խù� ��ȸ
SELECT *
FROM TB_BOARD;
--==>> BOARD_ID	BOARD_TITLE		BOARD_CONTENT					BOARD_HITCOUNT	BOARD_DATE	U_ID					DEL_CHECK
--==>> 1		������ �Խù�	���ν����� �Է��� �Խù� ����	0				2022-08-03	skkim@mostisoft.com		0




-- �� ��� �߰� ( REPLY_C )
GO
DECLARE @REPLY_CONTENT		VARCHAR(100)
DECLARE @U_ID				VARCHAR(200)
DECLARE @BOARD_ID			INT


SET @REPLY_CONTENT = '������ �Խù� �� ��۴ޱ�'
SET @U_ID = 'skkim@mostisoft.com'
SET @BOARD_ID = 1

	EXEC REPLY_C @REPLY_CONTENT, @U_ID, @BOARD_ID;
--==>> (1 row affected)

-- �� ��� ��ȸ
SELECT *
FROM TB_REPLY;
--==>> 2	������ �Խù� �� ��۴ޱ�	2022-08-03	skkim@mostisoft.com	1	0

-- �� �亯 �߰� ( ANSWER_C )
GO
DECLARE @ANSWER_CONTENT	    VARCHAR(100)
DECLARE @BOARD_ID			INT
DECLARE @REPLY_ID			INT
DECLARE @U_ID				VARCHAR(200)


SET @ANSWER_CONTENT = '������ �Խù� ��ۿ� �亯�ޱ�'
SET @BOARD_ID = 1
SET @REPLY_ID = 2
SET @U_ID = 'skkim@mostisoft.com'


	EXEC ANSWER_C @ANSWER_CONTENT, @BOARD_ID, @REPLY_ID, @U_ID;
--==>> (1 row affected)

-- �� �亯 ��ȸ
SELECT *
FROM TB_ANSWER;
--==>> 5	������ �Խù� ��ۿ� �亯�ޱ�	2022-08-03	1	2	skkim@mostisoft.com	0
