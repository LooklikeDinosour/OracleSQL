--Ʈ����� (���� �۾�����)

SHOW AUTOCOMMIT;

--����Ŀ�� ��
SET AUTOCOMMIT ON;
--����Ŀ�� ����
SET AUTOCOMMIT OFF; -- �⺻��

SELECT * FROM DEPTS;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DELETE10; -- ���̺�����Ʈ ���

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;

SAVEPOINT DELETE20;
SELECT * FROM DEPTS;

ROLLBACK TO DELETE10; -- 20�� ���̺�����Ʈ�� �ѹ�

ROLLBACK; -- ������ Ŀ�� ����


--------------------------------------------------
INSERT INTO DEPTS VALUES(300, 'DEMO', NULL, 1800); -- COMMIT���������� �� �� ó�� �ݿ��Ǿ�����. COMMIT�ؾ� �����Ϳ� ��¥�� �ݿ���

COMMIT; -- Ʈ����� �ݿ�
SELECT * FROM DEPTS;