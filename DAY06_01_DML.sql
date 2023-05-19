--INSERT, UPDATE, DELETE ���� �ۼ��ϸ� COMMIT�������� ���� �ݿ��� ó���ϴ� �۾��� �ʿ��մϴ�.
--INSERT

--���̺� ���� Ȯ��
DESC DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES(300, 'DEV', NULL, 1700);
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(310, 'SYSTEM'); --�κ� ���Խ� ��� ������ ����������Ѵ�.

SELECT * FROM DEPARTMENTS;

ROLLBACK;

--�纻���̺�(���̺� ������ ����)
CREATE TABLE EMPSSS AS (SELECT * FROM EMPLOYEES WHERE 1 = 1);

SELECT * FROM EMPSSS;

--���������� �μ�Ʈ
INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'); --��ü�÷��� ����
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (200, 
        (SELECT LAST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
        (SELECT EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
        SYSDATE,
        'TEST'
        );

SELECT * FROM EMPS;
DESC EMPS;

--------------------------------------------------------------------------------
--UPDATE����
SELECT * FROM EMPS;

-- ��ȸ�غ���
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 103;

--EX1
UPDATE EMPS
SET HIRE_DATE = SYSDATE, 
    LAST_NAME = 'HONG',
    SALARY = SALARY + 1000
WHERE EMPLOYEE_ID = 103; -- ���¹�� ���� �� ��밡�� �������� ���

--EX2
UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID IN ('IT_PROG', 'SA_MAN');

--EX3 : ID=200�� 106���� �޿��� ���� (��������)
SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 148;
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 148)
WHERE EMPLOYEE_ID = 200;

--EX4 :
UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT) = (SELECT JOB_ID, SALARY, COMMISSION_PCT FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

COMMIT;
--------------------------------------------------------------------------------
-- DELETE����
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 1); -- ���̺� ���� + ������ ����

SELECT * FROM DEPTS;
SELECT * FROM EMPS;
-- ���� ���� Ű�� �̿��ؼ� ����°� ����Ʈ
--EX1 - ������ ���� �� PK�� �̿��մϴ�.
DELETE FROM EMPS WHERE EMPLOYEE_ID = 200;
DELETE FROM EMPS WHERE SALARY >= 4000;
--EX2 - 
DELETE FROM EMPS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');
ROLLBACK;

-- EMPLOYEE�� 60�� �μ��� ����ϰ� �ֱ� ������ �����Ұ�
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 60;


--MERGE��
--�� ���̺��� ���ؼ� �����Ͱ� ������ UPDATE, ���ٸ� INSERT
SELECT * FROM EMPS;
rollback;
MERGE INTO EMPS E1
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN')) E2
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID) --Ű ��
WHEN MATCHED THEN
    UPDATE SET -- �÷�=��
        E1.HIRE_DATE = E2.HIRE_DATE,
        E1.SALARY = E2.SALARY,
        E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN
    INSERT VALUES 
    (E2.EMPLOYEE_ID, E2.FIRST_NAME, E2.LAST_NAME, E2.EMAIL,
    E2.PHONE_NUMBER, E2.HIRE_DATE, E2.JOB_ID, E2.SALARY,
    E2.COMMISSION_PCT, E2.MANAGER_ID, E2.DEPARTMENT_ID);
    
--MERGE2
SELECT * FROM EMPS;
MERGE INTO EMPS E
USING DUAL
ON (E.EMPLOYEE_ID = 103)
WHEN MATCHED THEN
    UPDATE SET LAST_NAME = 'DEMO'
WHEN NOT MATCHED THEN
    INSERT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID ) VALUES(1000, 'DEMO', 'DEMO', SYSDATE, 'DEMO');

DELETE FROM EMPS WHERE EMPLOYEE_ID = 103;

--
--���� 1.
--DEPTS���̺��� ������ �߰��ϼ���
SELECT * FROM DEPTS;
DESC DEPTS;
INSERT INTO DEPTS
VALUES( 280, '����', null, 1800);
INSERT INTO DEPTS
VALUES(290, 'ȸ���', null, 1800);
INSERT INTO DEPTS
VALUES(300, '����', 301, 1800);
INSERT INTO DEPTS
VALUES(310, '�λ�', 302, 1800);
INSERT INTO DEPTS
VALUES(320, '����', 303, 1700);
        
        
--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. ����,����,�λ��� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.

SELECT * FROM DEPTS;

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT_BANK'
WHERE DEPARTMENT_ID = '210';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

UPDATE DEPTS
SET (DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) = (SELECT 'IT HELP', 303, 1800 FROM DEPTS WHERE DEPARTMENT_ID = 230)
WHERE DEPARTMENT_NAME = 'IT Helpdesk';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID IN (300, 310, 320);


--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���


DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220;



--����
--����4
--1. Depts �纻���̺����� department_id �� 200���� ū �����͸� �����ϼ���.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
SELECT * FROM DEPTS;
SELECT * FROM DEPARTMENTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;

UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

MERGE INTO DEPTS D1
USING (SELECT * FROM DEPARTMENTS)D2
ON(D1.DEPARTMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET
    D1.DEPARTMENT_NAME = D2.DEPARTMENT_NAME,
    D1.MANAGER_ID = D2.MANAGER_ID,
    D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES
    (D2.DEPARTMENT_ID, D2.DEPARTMENT_NAME, D2.MANAGER_ID, D2.LOCATION_ID);


--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺��� ���� �����͸� �߰��ϼ���
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
SELECT * FROM JOBS;
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);

INSERT INTO JOBS_IT
VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT
VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT
VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);
  
MERGE INTO JOBS_IT J1
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J2
ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET
    J1.MIN_SALARY = J2.MIN_SALARY,
    J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES
    (J2.JOB_ID, J2.JOB_TITLE, J2.MIN_SALARY, J2.MAX_SALARY);

COMMIT;
--WHERE MIN_SALARY = (SELECT MIN_SALARY FROM JOBS WHERE MIN_SALARY > 6000 );

