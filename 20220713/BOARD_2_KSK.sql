-- 2022-07-13 
-- 게시판
-- 1. 회원 테이블에 해당 회원(ID, PWD 가 일치하는)이 존재하는지
--    확인하는 쿼리문

SELECT COUNT(*) AS [U_COUNT]
FROM TB_USER
WHERE U_ID = 'skkim@mostisoft.com'
  AND U_PWD = '961004-1030721';
--==>> 있으면 : 1 / 없으면 : 0 반환

-- 한줄 구성
SELECT COUNT(*) AS [U_COUNT] FROM TB_USER WHERE U_ID = 'skkim@mostisoft.com' AND U_PWD = '961004-1030721'

SELECT *
FROM TB_BOARD;

-- 2. 게시물 제목을 클릭하면 해당 게시물 내용이 출력되는 쿼리문
-- 2-1. 뷰View 생성
CREATE VIEW BOARD_DETAIL_VIEW
AS
SELECT B.BOARD_ID, B.BOARD_TITLE, B.BOARD_CONTENT, B.BOARD_HITCOUNT, B.BOARD_DATE
     , U.U_ID, U.U_NAME
	 , ISNULL(R.REPLY_ID, 0) AS [REPLY_ID], ISNULL(R.REPLY_CONTENT, '없음') AS [REPLY_CONTENT]
	 , ISNULL(CONVERT(VARCHAR(8), R.REPLY_DATE, 112), '없음') AS [REPLY_DATE]
FROM TB_BOARD B JOIN TB_USER U
     ON B.U_ID = U.U_ID
	 LEFT OUTER JOIN TB_REPLY R
	 ON B.BOARD_ID = R.BOARD_ID;
--==>> Commands completed successfully.

ALTER VIEW BOARD_DETAIL_VIEW
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