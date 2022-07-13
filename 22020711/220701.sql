-- �� DB �������� �� SYS ���� ��ȸ
SELECT Roles.Name, Roles.Type_Desc, Members.Name MemberName, Members.Type_Desc
FROM sys.server_role_members RoleMembers
INNER JOIN sys.server_principals Roles ON Roles.Principal_Id = RoleMembers.role_principal_id
INNER JOIN SYS.server_principals Members ON Members.principal_id = RoleMembers.member_principal_id
WHERE MEMBERS.name NOT LIKE '%SYSTEM%'
		AND MEMBERS.name NOT LIKE '%SQLServer%';
/*
sysadmin	SERVER_ROLE	sa	SQL_LOGIN
*/

-- �� ���̺� ����
CREATE TABLE TBL_TEST
(
	  U_ID			VARCHAR(30)	NOT NULL
	, U_NAME		VARCHAR(30)	NOT NULL
	, U_PWD			VARCHAR(30)	NOT NULL
	, CONSTRAINT U_ID_PK PRIMARY KEY(U_ID)
);
--> �����ͺ��̽� 'master'���� CREATE TABLE ��� ������ �źεǾ����ϴ�.

-- tempdb ���̺� �̵�
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
--==>> ����
-- ������ ����
CREATE SEQUENCE TEST_SEQ 
AS DECIMAL(18, 0)
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100
CYCLE
CACHE 1;
--==>>������ ��ü 'TEST_SEQ'�� ���� ĳ�� ũ�Ⱑ NO CACHE�� �����Ǿ����ϴ�.



-- ������ ����
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES('1', '����', 'mosti006$' );
--==>> (1 row affected)

SELECT U_ID, U_NAME, U_PWD
FROM TBL_TEST;
--==>> 1	����	mosti006$

INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES('1', '����', 'mosti006$' );

DELETE
FROM TBL_TEST;
--==>>(1 row affected)

COMMIT;
/*
COMMIT TRANSACTION ��û�� �ش��ϴ� BEGIN TRANSACTION�� �����ϴ�.
*/


ALTER TABLE TBL_TEST
ALTER COLUMN U_ID INT;
/*
Msg 5074, Level 16, State 1, Line 73
��ü 'U_ID_PK'��(��) �� 'U_ID'�� ���ӵǾ� �ֽ��ϴ�.
Msg 4922, Level 16, State 9, Line 73
�ϳ� �̻��� ��ü�� �� ���� �׼����ϹǷ� ALTER TABLE ALTER COLUMN U_ID��(��) �����߽��ϴ�.
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
VALUES(NEXT VALUE FOR TEST_SEQ, '����', 'mosti006$');
/*
(1 row affected)
*/

SELECT U_ID, U_NAME, U_PWD
FROM TBL_TEST;

/*
1	����	mosti006$
*/


INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '��ȿ��', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '������', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '��ȭ', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '������', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, 'ȫ����', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '������', 'mosti006$');
INSERT INTO TBL_TEST(U_ID, U_NAME, U_PWD)
VALUES(NEXT VALUE FOR TEST_SEQ, '������', 'mosti006$');
/*
(1 row affected)
*/

SELECT ROW_NUMBER() OVER(ORDER BY U_ID ) AS ROWNUM, U_ID, U_NAME, U_PWD
FROM TBL_TEST;
/*
1	1	����	mosti006$
2	2	��ȿ��	mosti006$
3	3	������	mosti006$
4	4	��ȭ		mosti006$
5	5	������	mosti006$
6	6	ȫ����	mosti006$
7	7	������	mosti006$
8	8	������	mosti006$
*/