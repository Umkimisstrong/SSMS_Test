-- ■ DB 계정생성 후 SYS 계정 조회
SELECT Roles.Name, Roles.Type_Desc, Members.Name MemberName, Members.Type_Desc
FROM sys.server_role_members RoleMembers
INNER JOIN sys.server_principals Roles ON Roles.Principal_Id = RoleMembers.role_principal_id
INNER JOIN SYS.server_principals Members ON Members.principal_id = RoleMembers.member_principal_id
WHERE MEMBERS.name NOT LIKE '%SYSTEM%'
		AND MEMBERS.name NOT LIKE '%SQLServer%';
/*
sysadmin	SERVER_ROLE	sa	SQL_LOGIN
*/

-- □ 테이블 생성
CREATE TABLE TBL_TEST
(
	  U_ID			VARCHAR(30)	NOT NULL
	, U_NAME		VARCHAR(30)	NOT NULL
	, U_PWD			VARCHAR(30)	NOT NULL
	, CONSTRAINT U_ID_PK PRIMARY KEY(U_ID)
);
--> 데이터베이스 'master'에서 CREATE TABLE 사용 권한이 거부되었습니다.

-- tempdb 테이블 이동
USE tempdb;
--==>> Commands completed successfully.

CREATE TABLE TBL_TEST
(
	  U_ID			VARCHAR(30)	NOT NULL
	, U_NAME		VARCHAR(30)	NOT NULL
	, U_PWD			VARCHAR(30)	NOT NULL
	, CONSTRAINT U_ID_PK PRIMARY KEY(U_ID)
);


SELECT *
FROM TBL_TEST;
--==>> 없음
-- 시퀀스 생성
CREATE SEQUENCE TEST_SEQ 
AS DECIMAL(18, 0)
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100
CYCLE
CACHE 1;
--==>>시퀀스 개체 'TEST_SEQ'에 대한 캐시 크기가 NO CACHE로 설정되었습니다.



-- 데이터 삽입
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES('1', '김상기', 'mosti006$' );
--==>> (1 row affected)

SELECT U_ID, U_NAME, U_PWD
FROM TBL_TEST;
--==>> 1	김상기	mosti006$

INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES('1', '김상기', 'mosti006$' );

DELETE
FROM TBL_TEST;
--==>>(1 row affected)

COMMIT;
/*
COMMIT TRANSACTION 요청에 해당하는 BEGIN TRANSACTION이 없습니다.
*/


ALTER TABLE TBL_TEST
ALTER COLUMN U_ID INT;
/*
Msg 5074, Level 16, State 1, Line 73
개체 'U_ID_PK'은(는) 열 'U_ID'에 종속되어 있습니다.
Msg 4922, Level 16, State 9, Line 73
하나 이상의 개체가 이 열에 액세스하므로 ALTER TABLE ALTER COLUMN U_ID이(가) 실패했습니다.
*/

DROP TABLE TBL_TEST;
--==>> Commands completed successfully.

CREATE TABLE TBL_TEST
(
	  U_ID			INT	NOT NULL
	, U_NAME		VARCHAR(30)	NOT NULL
	, U_PWD			VARCHAR(30)	NOT NULL
	, CONSTRAINT U_ID_PK PRIMARY KEY(U_ID)
);
--==>>Commands completed successfully.


INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '김상기', 'mosti006$');
/*
(1 row affected)
*/

SELECT U_ID, U_NAME, U_PWD
FROM TBL_TEST;

/*
1	김상기	mosti006$
*/


INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '김효섭', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '김태훈', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '김화', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '이정훈', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '홍지혜', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '김지영', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '오종빈', 'mosti006$');
/*
(1 row affected)
*/

SELECT ROW_NUMBER() OVER(ORDER BY U_ID ) AS ROWNUM, U_ID, U_NAME, U_PWD
FROM TBL_TEST;
/*
1	1	김상기	mosti006$
2	2	김효섭	mosti006$
3	3	김태훈	mosti006$
4	4	김화		mosti006$
5	5	이정훈	mosti006$
6	6	홍지혜	mosti006$
7	7	김지영	mosti006$
8	8	오종빈	mosti006$
*/