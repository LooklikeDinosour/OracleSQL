-- ����Ŭ �ּ���
/*
������ �ּ�
����Ŭ�� ��ҹ��� ���о���
��Ÿ �� �ȳ���
*/
SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME, EMAIL, HIRE_DATE FROM EMPLOYEES;
SELECT JOB_ID, SALARY, DEPARTMENT_ID FROM EMPLOYEES; -- ������ ���� ��� ������ �޶���

SELECT * FROM DEPARTMENTS;

--����
--�÷��� ��ȸ�ϴ� ��ġ���� * / + -
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM EMPLOYEES;

--NULL
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES;

-- ����� AS
SELECT FIRST_NAME AS �̸�, 
       LAST_NAME AS ��, 
       SALARY �޿�, 
       SALARY + SALARY * 0.1 �ѱ޿� 
FROM EMPLOYEES; --������ �̷��� �ۼ��ص��ȴ�

-- ���ڿ��� ���� ||
-- ����Ŭ�� ���ڸ� ''�� ǥ���Ѵ�. ���ڿ� �ȿ��� ''�ȿ��� ����ϰ� ������ '' �ι�����
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES;
SELECT FIRST_NAME || ' ' ||LAST_NAME FROM EMPLOYEES; -- ���� ���غ���
SELECT FIRST_NAME || ' ' ||LAST_NAME || '''s salary $' || SALARY AS �޿����� 
FROM EMPLOYEES;

--DISTINCT �ߺ��� ���� (���� : ������ �൥���Ͱ� ��� ��ġ��, �߰� ���� �ٸ��� ��������)
SELECT DISTINCT FIRST_NAME, DEPARTMENT_ID FROM EMPLOYEES; -- �̸�, �μ����� ���� ������ �ߺ����� ����
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

--ROWID(�������� �ּ�), ROWNUM(��ȸ�� ����)
SELECT ROWNUM, ROWID, EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES; --ROWNUM ���⼭�� EMPLOYEE_ID ����

--����Ŭ�� ���� ���� ���� �ʼ�, �ȱ׷��� ���� ���ư�. 


