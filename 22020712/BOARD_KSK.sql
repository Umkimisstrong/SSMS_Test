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

SELECT *
FROM TB_BOARD;






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
--==>> Commands completed successfully.
----------------------------------------------------------------------------------------
-- 003. 데이터 입력(1) 회원 / TB_USER
INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('skkim@mostisoft.com', '961004-1030721', '김상기', '010-5693-4223');
--==>> (1 row affected)

INSERT INTO TB_USER(U_ID, U_PWD, U_NAME, U_TEL)
VALUES('hskim@mostisoft.com', '961004-1112223', '김효섭', '010-2233-4443');
--==>> (1 row affected)
-----------------------------------------------------------------------------------------

-- 003. 데이터 입력(2) 게시물 / TB_BOARD
INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(SELECT COUNT(*) + 1 AS [COUNT]
		FROM TB_BOARD)
		, '안녕하세요, 김상기 입니다.'
		, '김상기의 인삿말'
		, 'skkim@mostisoft.com');
--==>> (1 row affected)

INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_BOARD)
		, '안녕하세요, 김효섭 입니다.'
		, '김효섭의 인삿말'
		, 'hskim@mostisoft.com');

--==>> (1 row affected)

INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID)
VALUES(
		(SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_BOARD)
		, '안녕하세요, 김효섭 아닙니다..'
		, '김효섭의 인상말'
		, 'hskim@mostisoft.com');
--==>>(1 row affected)

-- 한 줄 구성
INSERT INTO TB_BOARD(BOARD_ID, BOARD_TITLE, BOARD_CONTENT, U_ID) VALUES( (SELECT COUNT(*) + 1 AS [COUNT] FROM TB_BOARD), '안녕하세요, 김효섭 아닙니다..', '김효섭의 인상말', 'hskim@mostisoft.com')
---------------------------------------------------------------
-- 003. 데이터 입력(3) 댓글 / TB_REPLY
INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)
VALUES( (SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_REPLY)
		 , '안녕하세요 저는 김효섭 이에요'
		 , 'hskim@mostisoft.com'
		 , 1);
--==>> (1 row affected)
INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)
VALUES( (SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_REPLY)
		 , '안녕하세요 저는 김효섭 이아니에요'
		 , 'hskim@mostisoft.com'
		 , 1);

INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)
VALUES( (SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_REPLY)
		 , '안녕하세요 저는 김효섭 바보에요'
		 , 'hskim@mostisoft.com'
		 , 1);

INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)
VALUES( (SELECT COUNT(*) + 1 AS [COUNT]
		 FROM TB_REPLY)
		 , '안녕하세요 저는 김상기에요'
		 , 'skkim@mostisoft.com'
		 , 2); 

--==>> (1 row affected)

-- 한 줄 구성
INSERT INTO TB_REPLY(REPLY_ID, REPLY_CONTENT, U_ID, BOARD_ID)VALUES ( (SELECT COUNT(*) + 1 AS [COUNT] FROM TB_REPLY), '안녕하세요 저는 김상기에요', 'skkim@mostisoft.com', 2)






-- BOARD_LIST 게시판리스트에 출력되는 내용
SELECT ROW_NUMBER() OVER(ORDER BY B.BOARD_ID) AS [ROWNUM]
     , B.BOARD_ID
	 , B.BOARD_TITLE
	 , B.BOARD_HITCOUNT
	 , B.BOARD_DATE
	 , U.U_NAME
FROM TB_BOARD B JOIN TB_USER U
	 ON B.U_ID = U.U_ID;
--==>> 1	안녕하세요, 김상기 입니다.	김상기의 인삿말	0	2022-07-13	skkim@mostisoft.com
-- view 생성
CREATE VIEW BOARD_LIST_VIEW
AS
SELECT ROW_NUMBER() OVER(ORDER BY B.BOARD_ID) AS [ROWNUM], B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, B.BOARD_DATE, U.U_NAME FROM TB_BOARD B JOIN TB_USER U 	 ON B.U_ID = U.U_ID;
--==>> Commands completed successfully.

ALTER VIEW BOARD_LIST_VIEW
AS
SELECT B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, B.BOARD_DATE, B.U_ID, B.DEL_CHECK, U.U_NAME FROM TB_BOARD B JOIN TB_USER U ON B.U_ID = U.U_ID;
--==>> Commands completed successfully.

SELECT *
FROM BOARD_LIST_VIEW;

-- 한 줄 구성
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME FROM BOARD_LIST_VIEW;




-- 004. 데이터 수정
UPDATE TB_BOARD
SET BOARD_TITLE = '안녕하세요 수정했어요', BOARD_CONTENT = '안녕하세요 진짜수정한거이에요'
WHERE BOARD_ID = 3;
--==>> (1 row affected)

UPDATE TB_BOARD SET BOARD_TITLE = '안녕하세요 수정했어요', BOARD_CONTENT = '안녕하세요 진짜수정한거이에요' WHERE BOARD_ID = 3
;


-- 005. 데이터 삭제 -- TB_BOARD 의 DEL_CHECK 을 1로 업데이트
UPDATE TA_BOARD SET DEL_CHECK = 1 WHERE BOARD_ID = 1;
SELECT *
FROM TB_BOARD;


SELECT *
FROM TB_BOARD;
DELETE
FROM TB_BOARD;

DELETE
FROM TB_REPLY;


-- 005. 데이터 조회

-- BOARD_LIST 에서 게시물 출력
SELECT ROWNUM, BOARD_ID, BOARD_TITLE, BOARD_HITCOUNT, BOARD_DATE, U_NAME FROM BOARD_LIST_VIEW;
-- BOARD_DETAIL 에서 게시물 내용까지 출력
-- 필요한 데이터 : BOARD_CONTENT / TB_REPLY 의 댓글


