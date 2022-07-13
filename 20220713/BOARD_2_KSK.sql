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