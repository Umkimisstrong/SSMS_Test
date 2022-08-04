USE TEST_KSK;
--==>> Commands completed successfully.

SELECT USER
--==>> mosti_ksk

----------------------------------------------------------------------------------------------------
-- ● 기존 테이블 조회(TB_USER)
SELECT *
FROM TB_USER;
/*
	U_ID U_PWD U_NAME U_TEL
*/

-- ● 테이블 수정(TB_USER)
ALTER TABLE TB_USER
ADD U_DATE DATE	DEFAULT GETDATE();
--==>> Commands completed successfully.

-- ● 수정한 테이블 조회(TB_USER)
SELECT *
FROM TB_USER;
/*
	U_ID U_PWD U_NAME U_TEL U_DATE
*/

-- ● 기존 데이터 삭제(TB_USER)
DELETE
FROM TB_USER;
/*
Msg 547, Level 16, State 0, Line 28
DELETE 문이 REFERENCE 제약 조건 "ANSWER_UID_FK"과(와) 충돌했습니다. 데이터베이스 "TEST_KSK", 테이블 "dbo.TB_ANSWER", column 'U_ID'에서 충돌이 발생했습니다.
문이 종료되었습니다.

--> 답변이 있어서 삭제 불가
*/

-- ● 답변 테이블 조회(TB_ANSWER)
SELECT *
FROM TB_ANSWER;
/*
2	ZXC	2022-07-24	2	1	skkim@mostisoft.com	0
3	ASD	2022-07-24	2	1	skkim@mostisoft.com	0
*/
-- ● 답변테이블 데이터 삭제(TB_ANSWER)
DELETE
FROM TB_ANSWER;
/*
	(2 rows affected)
*/

-- ● 회원 테이블 데이터 삭제(TB_USER)
DELETE
FROM TB_USER;
/*
Msg 547, Level 16, State 0, Line 53
DELETE 문이 REFERENCE 제약 조건 "CT_BOARD_UID_FK"과(와) 충돌했습니다. 데이터베이스 "TEST_KSK", 테이블 "dbo.TB_BOARD", column 'U_ID'에서 충돌이 발생했습니다.
문이 종료되었습니다.

--> 게시물 테이블에 데이터가 존재해서 삭제 불가
*/

-- ● 게시물 테이블 데이터 삭제(TB_BOARD)
DELETE
FROM TB_BOARD;
/*
Msg 547, Level 16, State 0, Line 64
DELETE 문이 REFERENCE 제약 조건 "CT_REPLY_BOARDID_FK"과(와) 충돌했습니다. 데이터베이스 "TEST_KSK", 테이블 "dbo.TB_REPLY", column 'BOARD_ID'에서 충돌이 발생했습니다.
문이 종료되었습니다.

--> 댓글 테이블에 데이터가 존재해서 삭제 불가
*/

-- ● 댓글 테이블 데이터 삭제(TB_REPLY)
DELETE
FROM TB_REPLY;
--==>> (1 row affected)

-- ● 게시물 테이블 데이터 삭제(TB_BOARD)
DELETE
FROM TB_BOARD;
--==>> (1 row affected)

-- ● 회원 테이블 데이터 삭제(TB_USER)
DELETE
FROM TB_USER;
--==>> (2 rows affected)

----------------------------------------------------------------------------------------------------
-- ● 전체 데이터가 삭제된 상황
--    필요한 데이터를 추가로 입력하기 위해 테이블 구조 변경
--    ▶ TB_USER   : U_STATUS (상태) 컬럼 추가 (ACTIVE : 활성 / 비활성 : NONACTIVE )
--                 : 최초 회원가입 시 ACTIVE, 회원 탈퇴 시 NONACTIVE 로 변경
--    ▶ TB_BOARD  : 없음
--    ▶ TB_REPLY  : 없음
--    ▶ TB_ANSWER : 없음

-- ● 유저 테이블 상태 컬럼 추가(U_STATUS)
ALTER TABLE TB_USER
ADD U_STATUS	VARCHAR(20) DEFAULT 'ACTIVE';
--==>> Commands completed successfully.

-- ● 유저 테이블 컬럼 조회(TB_USER)
SELECT *
FROM TB_USER;
--==>> U_ID	U_PWD	U_NAME	U_TEL	U_DATE	U_STATUS

-- ● 게시물 테이블 컬럼 조회(TB_BOARD)
SELECT *
FROM TB_BOARD;
--==>> BOARD_ID	BOARD_TITLE	BOARD_CONTENT	BOARD_HITCOUNT	BOARD_DATE	U_ID	DEL_CHECK

-- ● 답글 테이블 컬럼 조회(TB_REPLY)
SELECT *
FROM TB_REPLY;
--==>> REPLY_ID	REPLY_CONTENT	REPLY_DATE	U_ID	BOARD_ID	DEL_CHECK

-- ● 답변 테이블 컬럼 조회(TB_ANSWER)
SELECT *
FROM TB_ANSWER;
--==>> ANSWER_ID	ANSWER_CONTENT	ANSWER_DATE	BOARD_ID	REPLY_ID	U_ID	DEL_CHECK

----------------------------------------------------------------------------------------------------

--==================================================================================================
-- ▶ 프로시저 관련 구문 ◀
-- 1. 추가 : C

-- ● 프로시저 생성 : 회원 추가 (USER_C)
GO
CREATE PROCEDURE USER_C
(
   -- 파라미터 / 데이터타입
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



-- ● 프로시저 생성 : 게시물 추가 (BOARD_C)
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

-- ● 프로시저 생성 : 답글 추가 (REPLY_C)
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

-- ● 프로시저 생성 : 답변 추가 (ANSWER_C)
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

--==================================================================================================

-- 2. 조회 : R
-- ● 프로시저 생성 : 회원 조회 
      --> 회원 조회 시 ID를 매개변수로 넘겨받는다.
GO
CREATE PROCEDURE USER_R
(
	@U_ID	VARCHAR(200)
)
AS
BEGIN
	
	SELECT U_ID, U_PWD, U_DATE, U_TEL, U_STATUS
	FROM TB_USER
	WHERE U_ID = @U_ID;

END;
--==>>Commands completed successfully.

-- ● 프로시저 생성 : 게시물 조회
      --> 게시물 조회시 DEL_CHECK 이 0 인 게시물만 조회
	  --> 검색조건중 SEARCH_TYPE, SEARCH_WORD 를 매개변수로 넘겨받아 조회
	      
GO
CREATE PROCEDURE BOARD_R
(
	 @SEARCH_TYPE		VARCHAR(100)
   , @SEARCH_WORD		VARCHAR(100)
)
AS
BEGIN
	
	SELECT
			  ROW_NUMBER() OVER(ORDER BY BOARD_ID DESC) AS [ROWNUM]
			, B.BOARD_ID       AS [BOARD_ID]
			, B.BOARD_TITLE    AS [BOARD_TITLE]
			, B.BOARD_CONTENT  AS [BOARD_CONTENT]
			, B.BOARD_HITCOUNT AS [BOARD_HITCOUNT]
			, B.BOARD_DATE     AS [BOARD_DATE]
			, B.U_ID		   AS [U_ID]
			, U.U_NAME		   AS [U_NAME]
			, U.U_TEL		   AS [U_TEL]
			, U.U_STATUS	   AS [U_STATUS]
	FROM
			TB_BOARD B LEFT OUTER JOIN TB_USER U
			ON B.U_ID = U.U_ID
	WHERE
			DEL_CHECK = 0
	        AND
			@SEARCH_TYPE LIKE @SEARCH_WORD;

END;
--==>> Commands completed successfully.

-- ● 프로시저 생성 : 답글 조회
      --> 답글 조회 시 DEL_CHECK 이 0인 답글만 조회
	  --> 답글의 종속성은 게시물에 있으므로 BOARD_ID 를 매개변수로 한다.

GO
CREATE PROCEDURE REPLY_R
(
	@BOARD_ID	INT
)
AS
BEGIN
	
	SELECT
			  ROW_NUMBER() OVER(ORDER BY REPLY_ID DESC) AS [ROWNUM]
            , R.REPLY_ID AS [REPLY_ID]
		    , R.REPLY_CONTENT AS [REPLY_CONTENT]
			, R.REPLY_DATE AS [REPLY_DATE]
			, R.BOARD_ID AS [BOARD_ID]
			, R.U_ID AS [U_ID]
			, U.U_NAME AS [U_NAME]
			, U.U_TEL AS [U_TEL]
			, U.U_STATUS AS [U_STATUS]
	FROM
			TB_REPLY R LEFT OUTER JOIN TB_USER U
			ON R.U_ID = U.U_ID
	WHERE
			BOARD_ID = @BOARD_ID
			AND
			DEL_CHECK = 0;
END;
--==>> Commands completed successfully.

-- ● 프로시저 생성 : 답변 조회
      --> 답변 조회 시 DEL_CHECK 이 0인 답변만 조회
	  --> 답변의 종속성은 게시물과, 답글에 있으므로 BOARD_ID와 REPLY_ID 를 매개변수로 한다.
GO
CREATE PROCEDURE ANSWER_R
(
	  @BOARD_ID	  INT
	, @REPLY_ID	  INT
)
AS
BEGIN
	
	SELECT
			  ROW_NUMBER() OVER(ORDER BY ANSWER_ID DESC) AS ROWNUM
			, A.ANSWER_ID AS [ANSWER_ID]
			, A.ANSWER_CONTENT AS [ANSWER_CONTENT]
			, A.ANSWER_DATE AS [ANSWER_DATE]
			, A.BOARD_ID AS [BOARD_ID]
			, A.REPLY_ID AS [REPLY_ID]
			, A.U_ID AS [U_ID]
			, U.U_NAME AS [U_NAME]
			, U.U_TEL AS [U_TEL]
			, U.U_STATUS AS [U_STATUS]

	FROM
			TB_ANSWER A LEFT OUTER JOIN TB_USER U
			ON A.U_ID = U.U_ID
	WHERE	
			A.BOARD_ID = @BOARD_ID
			AND
			A.REPLY_ID = @REPLY_ID;

END;
--==>> Commands completed successfully.

--==================================================================================================

-- 3. 수정 : U
      -- ※ 모든 UPDATE 구문은 ID 를 매개변수로 한다.
	  --    ID 가 없다면 프로시저가 실행되지 않는다.
	  --    ID 가 있다면 넘겨받을 매개변수는 ID를 제외한 컬럼이 된다.


-- ● 프로시저 생성 : 회원 수정
GO
CREATE PROCEDURE USER_U
(
	  @U_ID		VARCHAR(200)
    , @U_NAME	VARCHAR(20)
	, @U_TEL	VARCHAR(13)
	, @U_STATUS VARCHAR(20)
)
AS
BEGIN
	
	UPDATE 
			TB_USER
	SET
			  U_NAME = @U_NAME
			, U_TEL = @U_TEL
			, U_STATUS = @U_STATUS
			, U_DATE = GETDATE()
	WHERE
			U_ID = @U_ID;
END;
--==>> --==>> Commands completed successfully.


-- ● 프로시저 생성 : 게시물 수정
GO
CREATE PROCEDURE BOARD_U
(
	  @BOARD_ID			INT
    , @BOARD_TITLE    VARCHAR(300)
	, @BOARD_CONTENT    VARCHAR(8000)
)
AS
BEGIN

		UPDATE 
				TB_BOARD
		SET
				  BOARD_TITLE = @BOARD_TITLE
				, BOARD_CONTENT = @BOARD_CONTENT
		WHERE 
				BOARD_ID = @BOARD_ID;
END;
--==>> Commands completed successfully.


-- ● 프로시저 생성 : 답글 수정
GO
CREATE PROCEDURE REPLY_U
(
	 @BOARD_ID			INT
   , @REPLY_ID			INT
   , @REPLY_CONTENT		VARCHAR(100)
)
AS
BEGIN
	
		UPDATE	
				TB_REPLY
		SET
				REPLY_CONTENT = @REPLY_CONTENT
		WHERE 
				BOARD_ID = @BOARD_ID
				AND
				REPLY_ID = @REPLY_ID;
END;
--==>> Commands completed successfully.

-- ● 프로시저 생성 : 답변 수정

GO
CREATE PROCEDURE ANSWER_U
(
	  @BOARD_ID		    INT
	, @REPLY_ID		    INT
	, @ANSWER_ID		INT
	, @ANSWER_CONTENT VARCHAR(100)
)
AS
BEGIN

		UPDATE
				TB_ANSWER

		SET
				ANSWER_CONTENT = @ANSWER_CONTENT
				
		WHERE 
				BOARD_ID = @BOARD_ID
				AND
				REPLY_ID = @REPLY_ID
				AND
				ANSWER_ID = @ANSWER_ID;
END;
--==>> Commands completed successfully.

-- 4. 삭제 : D

--    ※ 사실상 STATUS 나 DEL_CHECK 을 UPDATE

-- ● 프로시저 생성 : 회원 삭제
GO
CREATE PROCEDURE USER_D
(
	@U_ID	VARCHAR(200)
)
AS
BEGIN
		UPDATE	
				TB_USER
		SET
				U_STATUS = 'NONACTIVE'
		WHERE
				U_ID = @U_ID;

END;
--==>> Commands completed successfully.

-- ● 프로시저 생성 : 게시물 삭제
GO
CREATE PROCEDURE BOARD_D
(
	  @BOARD_ID	INT
	, @U_ID		VARCHAR(200)
)
AS
BEGIN
		UPDATE	
				TB_BOARD
		SET
				DEL_CHECK = 1
		WHERE
				BOARD_ID = @BOARD_ID
				AND
				U_ID = @U_ID;

END;
--==>> Commands completed successfully.

-- ● 프로시저 생성 : 답글 삭제
GO
CREATE PROCEDURE REPLY_D
(
	  @BOARD_ID		  INT
	, @REPLY_ID		  INT
	, @U_ID			  VARCHAR(200)
)
AS
BEGIN
	
		UPDATE	
				TB_REPLY
		SET

				DEL_CHECK = 1
		WHERE
				BOARD_ID = @BOARD_ID
				AND
				REPLY_ID = @REPLY_ID
				AND
				U_ID = @U_ID;
END;
--==>> Commands completed successfully.
-- ● 프로시저 생성 : 답변 삭제
GO
CREATE PROCEDURE ANSWER_D
(
	  @BOARD_ID		  INT
	, @REPLY_ID		  INT
	, @ANSWER_ID	  INT
	, @U_ID			  VARCHAR(200)
)
AS
BEGIN
	
		UPDATE	
				TB_ANSWER
		SET

				DEL_CHECK = 1
		WHERE
				BOARD_ID = @BOARD_ID
				AND
				REPLY_ID = @REPLY_ID
				AND
				ANSWER_ID = @ANSWER_ID
				AND
				U_ID = @U_ID;
END;
--==>> Commands completed successfully.









