--���� 1.
---EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
---EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT * FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; -- �Ѱ� ���� 178��
SELECT * FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; // 107
SELECT * FROM EMPLOYEES E RIGHT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; // 122
SELECT * FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; // 123

--���� 2.
---EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT E.FIRST_NAME || E.LAST_NAME as �̸�,
       E.DEPARTMENT_ID 
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
WHERE EMPLOYEE_ID = '200';


--���� 3.
---EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT * FROM JOBS;
SELECT FIRST_NAME || LAST_NAME,
       E.JOB_ID,
       J.JOB_TITLE 
FROM EMPLOYEES E INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID --USING (JOB_ID);
ORDER BY FIRST_NAME;


--���� 4.
----JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS J LEFT OUTER JOIN JOB_HISTORY JH ON J.JOB_ID = JH.JOB_ID;

--���� 5.
----Steven King�� �μ����� ����ϼ���.
SELECT E.FIRST_NAME ||' '|| E.LAST_NAME,
       D.DEPARTMENT_NAME 
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
WHERE E.FIRST_NAME ||' '|| E.LAST_NAME ='Steven King'; // AND ���� ���

--���� 6.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT * FROM EMPLOYEES CROSS JOIN DEPARTMENTS;

--����
--���� 7.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT E.EMPLOYEE_ID �����ȣ,
       E.FIRST_NAME || E.LAST_NAME �̸�,
       E.SALARY �޿�,
       D.DEPARTMENT_NAME �μ���,
       L.CITY �ٹ��� 
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';

--���� 8.
---- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT * FROM EMPLOYEES E LEFT OUTER JOIN JOBS J ON E.JOB_ID = J.JOB_ID WHERE JOB_TITLE ='Stock Manager'OR JOB_TITLE = 'Stock Clerk'; // in ('Stock manager', 'stock cleark');

--���� 9.
---- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT * 
FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID 
WHERE EMPLOYEE_ID IS NULL;

--���� 10. 
---join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT E1.FIRST_NAME ||' '|| E1.LAST_NAME ����̸�,
       E2.FIRST_NAME||' '||E2.LAST_NAME ���Ŵ��� 
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;


--���� 11. 
----EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
----�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���.
SELECT E1.FIRST_NAME||E1.LAST_NAME ����̸�,
       E1.SALARY ����޿�, 
       E2.EMPLOYEE_ID �Ŵ������̵�, 
       E2.FIRST_NAME||E2.LAST_NAME �Ŵ����̸�, 
       E2.SALARY �Ŵ����޿�
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID 
WHERE E1.MANAGER_ID IS NOT NULL 
ORDER BY E1.SALARY DESC;

