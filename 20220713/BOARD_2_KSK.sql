-- 2022-07-13 
-- �Խ���
-- 1. ȸ�� ���̺� �ش� ȸ��(ID, PWD �� ��ġ�ϴ�)�� �����ϴ���
--    Ȯ���ϴ� ������

SELECT COUNT(*) AS [U_COUNT]
FROM TB_USER
WHERE U_ID = 'skkim@mostisoft.com'
  AND U_PWD = '961004-1030721';
--==>> ������ : 1 / ������ : 0 ��ȯ

-- ���� ����
SELECT COUNT(*) AS [U_COUNT] FROM TB_USER WHERE U_ID = 'skkim@mostisoft.com' AND U_PWD = '961004-1030721'

SELECT *
FROM TB_BOARD;