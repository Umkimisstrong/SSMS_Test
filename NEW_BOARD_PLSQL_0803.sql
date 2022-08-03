USE TEST_KSK;
GO
-- ● 프로시저 실행 구문
-- 1. 추가 : C

-- ● 회원 추가 ( USER_C )
DECLARE	@U_ID			VARCHAR(200)
DECLARE @U_PWD			CHAR(14)
DECLARE @U_NAME			VARCHAR(20)
DECLARE @U_TEL			VARCHAR(13)

SET @U_ID = 'skkim@mostisoft.com'
SET @U_PWD = '961004-1111111'
SET @U_NAME = '김상기'
SET @U_TEL = '010-5555-4444'

	EXEC USER_C @U_ID, @U_PWD, @U_NAME, @U_TEL;

--==>> (1 row affected)

-- ● 회원 조회
SELECT *
FROM TB_USER;
--==>> skkim@mostisoft.com	961004-1111111	김상기	010-5555-4444	2022-08-03	ACTIVE


-- ● 게시물 추가 ( BOARD_C )
GO
DECLARE @BOARD_TITLE		VARCHAR(300)
DECLARE @BOARD_CONTENT		VARCHAR(8000)
DECLARE @U_ID				VARCHAR(200)


SET @BOARD_TITLE = '김상기의 게시물'
SET @BOARD_CONTENT = '프로시저로 입력한 게시물 내용'
SET @U_ID = 'skkim@mostisoft.com'

	EXEC BOARD_C @BOARD_TITLE, @BOARD_CONTENT, @U_ID;

--==>> (1 row affected)

-- ● 게시물 조회
SELECT *
FROM TB_BOARD;
--==>> BOARD_ID	BOARD_TITLE		BOARD_CONTENT					BOARD_HITCOUNT	BOARD_DATE	U_ID					DEL_CHECK
--==>> 1		김상기의 게시물	프로시저로 입력한 게시물 내용	0				2022-08-03	skkim@mostisoft.com		0




-- ● 답글 추가 ( REPLY_C )
GO
DECLARE @REPLY_CONTENT		VARCHAR(100)
DECLARE @U_ID				VARCHAR(200)
DECLARE @BOARD_ID			INT


SET @REPLY_CONTENT = '김상기의 게시물 에 댓글달기'
SET @U_ID = 'skkim@mostisoft.com'
SET @BOARD_ID = 1

	EXEC REPLY_C @REPLY_CONTENT, @U_ID, @BOARD_ID;
--==>> (1 row affected)

-- ● 답글 조회
SELECT *
FROM TB_REPLY;
--==>> 2	김상기의 게시물 에 댓글달기	2022-08-03	skkim@mostisoft.com	1	0

-- ● 답변 추가 ( ANSWER_C )
GO
DECLARE @ANSWER_CONTENT	    VARCHAR(100)
DECLARE @BOARD_ID			INT
DECLARE @REPLY_ID			INT
DECLARE @U_ID				VARCHAR(200)


SET @ANSWER_CONTENT = '김상기의 게시물 댓글에 답변달기'
SET @BOARD_ID = 1
SET @REPLY_ID = 2
SET @U_ID = 'skkim@mostisoft.com'


	EXEC ANSWER_C @ANSWER_CONTENT, @BOARD_ID, @REPLY_ID, @U_ID;
--==>> (1 row affected)

-- ● 답변 조회
SELECT *
FROM TB_ANSWER;
--==>> 5	김상기의 게시물 댓글에 답변달기	2022-08-03	1	2	skkim@mostisoft.com	0
