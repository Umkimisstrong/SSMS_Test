-- TB_BOARD 관련 모든 쿼리문

-- 001. DB 접근 : TEST_KSK
USE TEST_KSK;

-- 002. 테이블 생성(1) / 회원 / TB_USER
CREATE TABLE TB_USER
(
	U_ID	VARCHAR(200)	NOT NULL	-- 아이디(이메일)
  ,	U_PWD	CHAR(14)		NOT NULL	-- 비밀번호(주민번호)
  , U_NAME  VARCHAR(20)		NOT NULL	-- 이름 
  , U_TEL	VARCHAR(13)		NOT NULL	-- 전화번호 010-1111-1111
  , CONSTRAINT CT_USER_ID_PK PRIMARY KEY(U_ID)
);
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 002. 테이블 생성(2) / 게시물 / TB_BOARD
CREATE TABLE TB_BOARD
(
	BOARD_ID		INT				NOT NULL  -- 번호
  , BOARD_TITLE		VARCHAR(300)	NOT NULL  -- 제목
  , BOARD_CONTENT	VARCHAR(8000)	NOT NULL  -- 내용
  , BOARD_HITCOUNT  INT				DEFAULT 0 -- 조회수
  , BOARD_DATE		DATE			DEFAULT GETDATE()   -- 날짜
  , U_ID			VARCHAR(200)	NOT NULL  -- 작성자 ID(이메일)
  , CONSTRAINT CT_BOARD_ID_PK PRIMARY KEY(BOARD_ID)
  , CONSTRAINT CT_BOARD_UID_FK FOREIGN KEY(U_ID)
			   REFERENCES TB_USER(U_ID)
);
--==>> Commands completed successfully.
ALTER TABLE TB_BOARD
ADD DEL_CHECK	INT	DEFAULT 0;

----------------------------------------------------------------------
-- 002. 테이블 생성(3) / 댓글 / TB_REPLY
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
-- 003. 데이터 입력(1) 회원 / TB_USER
INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('skkim@mostisoft.com', '961004-1030721', '김상기', '010-5693-4223');
--==>> (1 row affected)

INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('hskim@mostisoft.com', '961004-1112223', '김효섭', '010-2233-4443');
--==>> (1 row affected)

----------------------------------------------------------------------
-- 003. 데이터 입력(2) 게시물 / TB_BOARD
INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(NEXT VALUE FOR BOARD_SEQ)
		, '안녕하세요, 김상기 입니다.'
		, '김상기의 인삿말'
		, 'skkim@mostisoft.com');
--==>> (1 row affected)

INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(NEXT VALUE FOR BOARD_SEQ)
		, '안녕하세요, 김상기 입니다.'
		, '김상기의 인삿말'
		, 'skkim@mostisoft.com');
DELETE
FROM TB_BOARD;
----------------------------------------------------------------------
-- 003. 데이터 입력(3) 댓글 / TB_REPLY
INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)
VALUES( (NEXT VALUE FOR REPLY_SEQ)
		 , '안녕하세요 저는 김효섭 이에요'
		 , 'hskim@mostisoft.com'
		 , 1);
--==>> (1 row affected)

----------------------------------------------------------------------

-- 004. 데이터 수정
UPDATE TB_BOARD
SET BOARD_TITLE = '안녕하세요 수정했어요', BOARD_CONTENT = '안녕하세요 진짜수정한거이에요'
WHERE BOARD_ID = 3;
--==>> (1 row affected)

----------------------------------------------------------------------

-- 005. 데이터 삭제 -- TB_BOARD 의 DEL_CHECK 을 1로 업데이트
UPDATE TA_BOARD SET DEL_CHECK = 1 WHERE BOARD_ID = 1;
SELECT *
FROM TB_BOARD;

----------------------------------------------------------------------

-- 006. 게시물 전체 조회를 위한 BASE VIEW 생성
CREATE VIEW BOARD_LIST_VIEW
AS
SELECT B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, B.BOARD_DATE, B.U_ID, B.DEL_CHECK, U.U_NAME FROM TB_BOARD B JOIN TB_USER U ON B.U_ID = U.U_ID;
--==>> Commands completed successfully.


-- 006-1. 게시물 전체 조회를 위한 최종 VIEW 생성
CREATE VIEW BOARD_LIST_VIEW2
AS
SELECT B.ROWNUM, B.BOARD_ID, B.BOARD_TITLE, B.BOARD_HITCOUNT, B.BOARD_CONTENT, B.BOARD_DATE, B.U_NAME FROM (SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY BOARD_ID)) AS [ROWNUM], BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_CONTENT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], U_NAME FROM BOARD_LIST_VIEW WHERE DEL_CHECK = 0 )B

-- 게시물 전체 조회를 위한 최종 VIEW 수정
ALTER VIEW BOARD_LIST_VIEW2
AS
SELECT B.ROWNUM, B.BOARD_ID, B.BOARD_TITLE, B.BOARD_HITCOUNT, B.BOARD_CONTENT, B.BOARD_DATE, B.U_NAME FROM (SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY BOARD_ID)) AS [ROWNUM], BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_CONTENT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], U_NAME FROM BOARD_LIST_VIEW WHERE DEL_CHECK = 0 )B

----------------------------------------------------------------------

-- 007. 단일 게시물 조회를 위한 BASE VIEW 생성
CREATE VIEW BOARD_DETAIL_VIEW
AS
SELECT B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, CONVERT(VARCHAR(8), B.BOARD_DATE, 112) AS [BOARD_DATE]
     , U.U_ID, U.U_NAME, ISNULL(R.U_ID, '없음') AS [REPLY_U_ID]
	 , ISNULL(R.REPLY_ID, 0) AS [REPLY_ID], ISNULL(R.REPLY_CONTENT, '없음') AS [REPLY_CONTENT]
	 , ISNULL(CONVERT(VARCHAR(8), R.REPLY_DATE, 112), '없음') AS [REPLY_DATE]
FROM TB_BOARD B JOIN TB_USER U
     ON B.U_ID = U.U_ID
	 LEFT OUTER JOIN TB_REPLY R
	 ON B.BOARD_ID = R.BOARD_ID;
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 007-1. 단일 게시물 조회를 위한 최종 VIEW 생성
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

-- 008. 단일 게시물의 댓글 조회를 위한 최종 VIEW 생성
CREATE VIEW REPLY_LIST_VIEW
AS
SELECT R.REPLY_ID, R.REPLY_CONTENT, CONVERT(VARCHAR(8), R.REPLY_DATE, 112) AS [REPLY_DATE]
     , R.BOARD_ID, U.U_NAME
FROM TB_REPLY R JOIN TB_USER U
	 ON R.U_ID = U.U_ID;
--==>> Commands completed successfully.

----------------------------------------------------------------------

-- 009. 전체 게시물 조회 쿼리
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME 
FROM BOARD_LIST_VIEW2
WHERE ROWNUM >= ? AND ROWNUM <= ?; 

-- 수정 : 검색과 통합된 쿼리
SELECT BOARD.ROWNUM, BOARD.BOARD_ID, BOARD.BOARD_TITLE, BOARD.BOARD_HITCOUNT, BOARD.BOARD_DATE, BOARD.U_NAME 
FROM
(
	SELECT ROW_NUMBER() OVER(ORDER BY BOARD_ID) AS [ROWNUM], BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME
	FROM BOARD_LIST_VIEW2 WHERE {0} LIKE '{1}'
) [BOARD]
WHERE BOARD.ROWNUM >= {2} AND BOARD.ROWNUM <= {3}; 


----------------------------------------------------------------------

-- 010. 단일 게시물 조회 쿼리
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, CONVERT(VARCHAR(8), BOARD_DATE, 112) AS [BOARD_DATE], BOARD_CONTENT, U_ID, U_NAME
FROM BOARD_DETAIL_VIEW2 
WHERE BOARD_ID = ?

----------------------------------------------------------------------

-- 011. 단일 게시물 댓글 조회 쿼리
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY REPLY_ID)) AS [ROWNUM], REPLY_ID, REPLY_CONTENT, CONVERT(VARCHAR(8), REPLY_DATE, 112) AS [REPLY_DATE], BOARD_ID, U_NAME 
FROM REPLY_LIST_VIEW 
WHERE BOARD_ID = ?

----------------------------------------------------------------------

-- 012. LOGIN 시 USER 확인을 위한 쿼리
SELECT COUNT(*) AS [U_COUNT]
FROM TB_USER
WHERE U_ID = ? AND U_PWD = ?;

----------------------------------------------------------------------

-- 013. 페이징을 위한 전체 데이터 조회 쿼리(DEL_CHECK 이 0인 것만)
SELECT COUNT(*) AS [DATACOUNT]
FROM BOARD_LIST_VIEW2

----------------------------------------------------------------------

-- 014. 사용자 이름을 반환하는 쿼리
SELECT U_NAME
FROM TB_USER
WHERE U_ID = ?

----------------------------------------------------------------------

-- 015. 검색을 위한 데이터 수를 조회하는 쿼리
SELECT COUNT(*) AS [DATACOUNT]
FROM BOARD_LIST_VIEW2
WHERE U_NAME LIKE '%김상기%';

SELECT COUNT(*) AS [DATACOUNT] FROM BOARD_LIST_VIEW2 WHERE 'BOARD_TITLE' LIKE '%안녕하세요%';



