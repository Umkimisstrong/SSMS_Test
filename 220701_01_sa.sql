SELECT S.spid,
       S.loginame as '접속자명',
       S.login_time as '로그인 시간',
       S.last_batch as '마지막 실행시간',
       C.client_net_address  as '접속 IP' ,
          S.program_name as '접속 프로그램',
          S.cmd as '현재 실행중인 명령어'
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
--==>> 없음

USE tempdb;

GRANT SELECT TO mosti_ksk;
GRANT ALTER TO mosti_ksk;
GRANT DELETE TO mosti_ksk;
GRANT UPDATE TO mosti_ksk;
GRANT INSERT TO mosti_ksk;
GRANT CREATE TABLE TO mosti_ksk;
--==>> Commands completed successfully.
