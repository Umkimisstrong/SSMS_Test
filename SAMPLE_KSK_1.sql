-- Logtrace

SELECT USER;
--==>>> logtraceuser

SELECT *
FROM TB_SAMPLE_USER;
/*
12312312	czc			zxczx		19961031	zxc		NULL		NULL	NULL	NULL	SUMMER	N	2022-07-28 14:33:53.790	ghkim2	2022-07-28 14:33:53.790	ghkim2
2342tsd		123123123	asdasdasd	19961004	��	��ȭ		���asd	���Ѵ�	����	WINTER	N	2022-07-29 08:35:46.033	ghkim2	2022-07-29 08:35:46.033	ghkim2
��������	������		������		19961031	������	NULL		NULL	NULL	NULL	0		N	2022-07-28 17:25:00.837	ghkim2	2022-07-28 17:25:00.837	ghkim2
��������	����������	��������	19961031	��	����������	������	����	����	SUMMER	N	2022-07-28 17:21:12.907	ghkim2	2022-07-28 17:21:12.907	ghkim2
dfg			dfg			dfgdfgdfg	19961031	xcv		xcv			xcv		xcv		xcv		AUTUMN	N	2022-07-28 14:34:40.293	ghkim2	2022-07-28 14:34:40.293	ghkim2
*/

DELETE
FROM TB_SAMPLE_USER
WHERE USER_ID = '�̻���';
