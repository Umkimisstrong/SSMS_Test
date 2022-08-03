-- 프로시저 생성 구문

-- 1. 유저 조회
CREATE PROCEDURE UP_USER_R
AS
BEGIN
	SELECT U_ID, U_NAME, U_TEL
	FROM TB_USER;
END;
--==>> 명령이 완료되었습니다.

-- 프로시저 실행구문
EXEC UP_USER_R;
/*
hskim@mostisoft.com	김효섭	010-2233-4443
skkim@mostisoft.com	김상기	010-5693-4223
*/

-- 2. 유저 입력
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

-- 프로시저 실행
GO
	-- 변수 선언
	DECLARE @U_ID	VARCHAR(200)
	DECLARE @U_PWD  CHAR(14)
	DECLARE @U_NAME VARCHAR(20)
	DECLARE @U_TEL  VARCHAR(13)

	-- 변수 대입
	SET @U_ID = 'shkim@mostisoft.com'
	SET @U_PWD = '961004-1111112'
	SET @U_NAME = '김소형'
	SET @U_TEL = '010-3333-2222'

	-- 변수 전달
	EXEC UP_USER_C @U_ID, @U_PWD, @U_NAME, @U_TEL;

SELECT *
FROM TB_USER
/*
hskim@mostisoft.com	961004-1112223	김효섭	010-2233-4443
shkim@mostisoft.com	961004-1111112	김소형	010-3333-2222
skkim@mostisoft.com	961004-1030721	김상기	010-5693-4223
*/