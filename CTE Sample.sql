---------------------------------------- 
---------------------------------------- 
-- 설 명: 사용자 목록 조회
-----------------------------------------
-----------------------------------------
-- EXEC UP_LIC_AUTH_L 
-- EXEC UP_LIC_AUTH_L @PAGE_NUMBER=3
-----------------------------------------
ALTER PROCEDURE [dbo].[UP_LIC_AUTH_L]
	   @USER_ID			VARCHAR(20)		= ''
	  ,@USER_NAME		NVARCHAR(10)	= ''
	  ,@PAGE_NUMBER		INT				= 1
	  ,@ROW_COUNT		INT				= 10
AS
BEGIN
		-- 페이징 처리를 위한 변수
		DECLARE @START_NUM INT
		DECLARE @END_NUM INT

		SET @START_NUM = (@PAGE_NUMBER - 1) * @ROW_COUNT + 1;
		SET @END_NUM = @PAGE_NUMBER * @ROW_COUNT;

		-- 검색 조건, 선택 된 페이지에 따른 목록 조회
		WITH CTE_LIST
		AS
		(
				SELECT
						 ROW_NUMBER() OVER (ORDER BY CREATE_DATE DESC) AS ROWNUMBER
						,SUM(Case WHEN USER_ID IS NOT NULL THEN 1 ELSE 1 END) OVER() TOTAL_COUNT
						,USER_ID
						,USER_PWD
						,USER_NAME
						,USER_TELEPHONE_NO
						,USER_EMAIL
						,USER_COMPANY
						,CREATE_USER
						,CREATE_DATE
						,UPDATE_USER
						,UPDATE_DATE
				FROM 
						[dbo].[TB_LIC_AUTH]
				WHERE
						USER_ID LIKE '%' + @USER_ID + '%'
						AND
						USER_NAME LIKE '%' + @USER_NAME + '%'
		)
		SELECT
				 ROWNUMBER
				,TOTAL_COUNT
				,USER_ID
				,USER_PWD
				,USER_NAME
				,USER_TELEPHONE_NO
				,USER_EMAIL
				,USER_COMPANY
				,CREATE_USER
				,CREATE_DATE
				,UPDATE_USER
				,UPDATE_DATE
		FROM
				CTE_LIST
		WHERE
				ROWNUMBER BETWEEN @START_NUM AND @END_NUM
END