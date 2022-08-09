-- 쿼리 연습

-- ● WHERE 절 EXISTS
-- EXISTS 구문은 서브쿼리만 사용 가능
-- 기본구문
/*
--> 서로다른 테이블과 관련 있는지에 대한 구문이다.

SELECT 컬럼명
  FROM 테이블명 1
 WHERE EXISTS
       (
			SELECT *
			  FROM 테이블명 2
			 WHERE 2.조건절 = 값;
	   )
*/
SELECT *
FROM TB_BOARD B
WHERE EXISTS
      (SELECT *
	     FROM TB_USER U
	    WHERE U.U_ID LIKE '%kim%');


-- ● UNION 
-- 기본 구문
/*

SELECT 컬럼명    --> 컬럼명은 두 개의 조회 테이블에서 동일하게 가져와야 한다.
FROM   테이블명
UNION (또는 UNION ALL)
SELECT 컬럼명
FROM   테이블명;
              --> 세미콜론은 항상마지막에
*/
-- SELECT 
SELECT BOARD_ID, BOARD_TITLE
FROM TB_BOARD
WHERE BOARD_TITLE NOT LIKE '%모스티%'
UNION ALL
SELECT BOARD_ID, BOARD_TITLE
FROM TB_BOARD
WHERE BOARD_TITLE LIKE '%모스티%';


-- ● MERGE
-- 기본 구문
/*
MERGE INTO 변경할 테이블
     USING 비교할 테이블
        ON 조건문

      WHEN MATCHED
			THEN UPDATE SET 컬럼 = 값
	  WHEN NOT MATCHED 
			THEN INSERT (컬럼) VALUES (값)


	       
*/
