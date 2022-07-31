CREATE TABLE TB_TEST
(
	NAME	VARCHAR(30)
	, TEL		CHAR(13)
);

--==>> 명령이 완료되었습니다.

SELECT *
FROM TB_TEST;
--==>> 김상기	010-5693-4223

INSERT INTO TB_TEST
(
	NAME
	, TEL
)
VALUES
(
	'김상기'
	, '010-5693-4223'
);
--==>> (1개 행 적용됨)



