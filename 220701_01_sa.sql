SELECT S.spid,
       S.loginame as '�����ڸ�',
       S.login_time as '�α��� �ð�',
       S.last_batch as '������ ����ð�',
       C.client_net_address  as '���� IP' ,
          S.program_name as '���� ���α׷�',
          S.cmd as '���� �������� ��ɾ�'
FROM   sys.sysprocesses S,
       sys.dm_exec_connections C
WHERE  S.spid = C.session_id;

CREATE TABLE TBL_TEST
(
	  U_ID			VARCHAR(30)	NOT NULL
	, U_NAME		VARCHAR(30)	NOT NULL
	, U_PWD			VARCHAR(30)	NOT NULL
	, CONSTRAINT U_ID_PK PRIMARY KEY(U_ID)
);
--==>> Commands completed successfully.


SELECT *
FROM TBL_TEST;
--==>> ����

USE tempdb;

GRANT SELECT TO mosti_ksk;
GRANT ALTER TO mosti_ksk;
GRANT DELETE TO mosti_ksk;
GRANT UPDATE TO mosti_ksk;
GRANT INSERT TO mosti_ksk;
GRANT CREATE TABLE TO mosti_ksk;
--==>> Commands completed successfully.
