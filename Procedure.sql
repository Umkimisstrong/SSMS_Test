-- ���ν��� ���� ����

-- 1. ���� ��ȸ
CREATE PROCEDURE UP_USER_R
AS
BEGIN
	SELECT U_ID, U_NAME, U_TEL
	FROM TB_USER;
END;
--==>> ����� �Ϸ�Ǿ����ϴ�.

-- ���ν��� ���౸��
EXEC UP_USER_R;
/*
hskim@mostisoft.com	��ȿ��	010-2233-4443
skkim@mostisoft.com	����	010-5693-4223
*/

-- 2. ���� �Է�
GO 
CREATE PROCEDURE UP_USER_C
(
	 @U_ID		VARCHAR(200)
   , @U_PWD		CHAR(14)
   , @U_NAME	VARCHAR(20)
   , @U_TEL		VARCHAR(13)
)
AS
BEGIN
	INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
	VALUES(@U_ID, @U_PWD, @U_NAME, @U_TEL);
END;

-- ���ν��� ����
GO
	-- ���� ����
	DECLARE @U_ID	VARCHAR(200)
	DECLARE @U_PWD  CHAR(14)
	DECLARE @U_NAME VARCHAR(20)
	DECLARE @U_TEL  VARCHAR(13)

	-- ���� ����
	SET @U_ID = 'shkim@mostisoft.com'
	SET @U_PWD = '961004-1111112'
	SET @U_NAME = '�����'
	SET @U_TEL = '010-3333-2222'

	-- ���� ����
	EXEC UP_USER_C @U_ID, @U_PWD, @U_NAME, @U_TEL;

SELECT *
FROM TB_USER
/*
hskim@mostisoft.com	961004-1112223	��ȿ��	010-2233-4443
shkim@mostisoft.com	961004-1111112	�����	010-3333-2222
skkim@mostisoft.com	961004-1030721	����	010-5693-4223
*/