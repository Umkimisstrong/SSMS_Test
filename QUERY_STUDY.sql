-- ���� ����

-- �� WHERE �� EXISTS
-- EXISTS ������ ���������� ��� ����
-- �⺻����
/*
--> ���δٸ� ���̺�� ���� �ִ����� ���� �����̴�.

SELECT �÷���
  FROM ���̺�� 1
 WHERE EXISTS
       (
			SELECT *
			  FROM ���̺�� 2
			 WHERE 2.������ = ��;
	   )
*/
SELECT *
FROM TB_BOARD B
WHERE EXISTS
      (SELECT *
	     FROM TB_USER U
	    WHERE U.U_ID LIKE '%kim%');


-- �� UNION 
-- �⺻ ����
/*

SELECT �÷���    --> �÷����� �� ���� ��ȸ ���̺��� �����ϰ� �����;� �Ѵ�.
FROM   ���̺��
UNION (�Ǵ� UNION ALL)
SELECT �÷���
FROM   ���̺��;
              --> �����ݷ��� �׻�������
*/
-- SELECT 
SELECT BOARD_ID, BOARD_TITLE
FROM TB_BOARD
WHERE BOARD_TITLE NOT LIKE '%��Ƽ%'
UNION ALL
SELECT BOARD_ID, BOARD_TITLE
FROM TB_BOARD
WHERE BOARD_TITLE LIKE '%��Ƽ%';


-- �� MERGE
-- �⺻ ����
/*
MERGE INTO ������ ���̺�
     USING ���� ���̺�
        ON ���ǹ�

      WHEN MATCHED
			THEN UPDATE SET �÷� = ��
	  WHEN NOT MATCHED 
			THEN INSERT (�÷�) VALUES (��)


	       
*/
