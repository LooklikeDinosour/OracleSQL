--��������
--SELECT���� SELECT�������� ���� ���� : ��Į�� ��������
--SELECT���� FROM�������� ���� ���� : �ζ��κ�
--SELECT���� WHERE�������� ���� ���� : ��������
--���������� �ݵ�� () �ȿ� �����ϴ�.

--������ �������� - ���ϵǴ� ���� 1���� ��������

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID�� 103���� ����� ������ ����
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--������ ��, ���� ���̾�� �մϴ�. �÷� ���� 1�������մϴ�.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID=104); -- ERROR

--------------------------------------------------------------------------------
--������ �������� - ���� ��������� IN, ANY, ALL�� ���մϴ�.
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

--IN ������ ���� ã�� IN(4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY �ּҰ� ���� ŭ, �ִ밪 ���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --�޿��� 9500���� ���� �����, �޿��� 4800���� ū �����

--ALL �ִ밪���� ŭ, �ּҰ� ���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --�޿��� 9500���� ū �����, �޿��� 4800���� ���� �����

--������ IT_prog�� ������� �޿� �ּҰ����� ū �޿��� �޴� �����
SELECT SALARY FROM EMPLOYEES WHERE JOB_ID ='IT_PROG'; 
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID ='IT_PROG');

--------------------------------------------------------------------------------
--��Į�� ��������
--JOIN�ÿ� Ư�����̺��� 1�÷��� ������ �� �� �����մϴ�.
--�Ʒ� �ΰ��� ���� ����� ���
SELECT FIRST_NAME,
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID )
FROM EMPLOYEES E
ORDER BY FIRST_NAME;
--LEFT ����
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;

--�� �μ��� �Ŵ��� �̸��� ���
--JOIN
SELECT D.*,
       E.FIRST_NAME 
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;

--��Į��
SELECT D.*,
       (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--��Į�������� ������ ����
SELECT * FROM JOBS; --JOB_TITLE
SELECT * FROM DEPARTMENTS ; -- DEPARTMENT_NAME
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E; 

--�� �μ��� ��� ���� ��� + �μ� ����
SELECT DEPARTMENT_ID AS �μ����̵�,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS �μ���,
       COUNT(*) AS �����
FROM EMPLOYEES E
GROUP BY DEPARTMENT_ID;

SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID), 0) AS �����
FROM DEPARTMENTS D;


--------------------------------------------------------------------------------
--�ζ��� ��
--��¥ ���̺� ����
--���ʿ� �� �������� �ۼ�

--ROWNUM�� ��ȸ�� �����̱� ������, ORDER�� ���� ���Ǹ� ROWNUM ���̴� ����
SELECT E.*, ROWNUM
FROM EMPLOYEES E
ORDER BY SALARY DESC;

--�̷��� �ٲ㼭 ó���ؾ߉�.
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
        FROM EMPLOYEES
        ORDER BY SALARY DESC);
--����2        
SELECT ROWNUM, 
       A.*
FROM (SELECT FIRST_NAME,
             SALARY
      FROM EMPLOYEES
      ORDER BY SALARY
      ) A;
      
--ROWNUM�� ������ 1��°���� ��ȸ�� �����ϱ� ������ �׷���.
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
        FROM EMPLOYEES
        ORDER BY SALARY DESC)
WHERE ROWNUM >= 1; -- ��ȸ ��. �ּ����� ���Ʒ� �����ư��鼭 �غ���        
-- WHERE ROWNUM BETWEEN 11 AND 20; --��ȸ �ȉ�.       

--2��° �ζ��κ信�� ROWNUM�� RN�� �÷�ȭ -> ROWNUM�߰���ȣ�� ��°���
SELECT *
FROM ( SELECT FIRST_NAME,
              SALARY,
              ROWNUM AS RN
        FROM (SELECT *
                FROM EMPLOYEES
                ORDER BY SALARY DESC)
        )
WHERE RN >= 51 AND RN <= 60;

--�ζ��� ���� ����
SELECT TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,
       NAME 
FROM (SELECT 'ȫ�浿' AS NAME, SYSDATE AS REGDATE FROM DUAL
        UNION ALL
        SELECT '�̼���', SYSDATE FROM DUAL);
        
--�ζ��� ���� ����(�Ž��� �������� �ٶ󺸱�)
--�μ��� �����
SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D
JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) AS TOTAL
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;


--����
--������(��Һ�) VS ������ ��������(IN, ANY, ALL)
--��Į������ - LEFT JOIN�� ���� ����, �ѹ��� 1���� �÷��� ������ ��
--�ζ��κ� - FROM�� ���� ��¥ ���̺�

--------------------------------------------------------------------------------

--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
SELECT AVG(SALARY) FROM EMPLOYEES;
SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT COUNT(*) 
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID ='IT_PROG'; -- 5760
SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.MANAGER_ID = '100';

SELECT * 
FROM EMPLOYEES E 
WHERE E.DEPARTMENT_ID = (SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.MANAGER_ID = '100');

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat'; --201

SELECT * 
FROM EMPLOYEES 
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');


SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James';

SELECT * 
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');


--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
(SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME DESC) ;
SELECT *
FROM ( SELECT ROWNUM AS RN, 
              FIRST_NAME 
        FROM (SELECT *
              FROM EMPLOYEES 
              ORDER BY FIRST_NAME DESC) E
                )
WHERE RN >= 41 AND RN <= 50;

--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.S
SELECT * FROM EMPLOYEES;

SELECT *
FROM (SELECT E.*, 
             ROWNUM AS RN
        FROM (SELECT EMPLOYEE_ID AS ���ID,
                     FIRST_NAME||' '||LAST_NAME AS �̸�,
                     PHONE_NUMBER AS ��ȣ,
                     HIRE_DATE AS �Ի���,
                     TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH:MI:SS') AS TIME -- �ζ��κ並 ���ؼ� �̷������� �߰�����
              FROM EMPLOYEES
              ORDER BY HIRE_DATE) E
        )
WHERE RN BETWEEN 31 AND 40;        

--����
--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT * FROM DEPARTMENTS; 
SELECT E.EMPLOYEE_ID AS �������̵�, 
       CONCAT(E.FIRST_NAME, E.LAST_NAME) AS �̸�, 
       E.DEPARTMENT_ID AS �μ����̵�, 
       D.DEPARTMENT_NAME AS �μ���  
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
ORDER BY EMPLOYEE_ID;


SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME AS NAME,
       D.DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM DEPARTMENTS D RIGHT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT E.EMPLOYEE_ID AS �������̵�,
       CONCAT(E.FIRST_NAME, E.LAST_NAME) AS �̸�,
       E.DEPARTMENT_ID AS �μ����̵�,
       (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;


--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT D.DEPARTMENT_ID AS �μ����̵�,
       D.DEPARTMENT_NAME AS �μ��̸�,
       D.MANAGER_ID AS �Ŵ������̵�,
       D.LOCATION_ID AS �����̼Ǿ��̵�,
       L.STREET_ADDRESS AS ��Ʈ��_��巹��,
       L.POSTAL_CODE AS ����Ʈ�ڵ�,
       L.CITY AS ��Ƽ
FROM DEPARTMENTS D 
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���-> �̷����� ������ ����.
SELECT D.*,
--SELECT D.DEPARTMENT_ID AS �μ����̵�,
--       D.DEPARTMENT_NAME AS �μ��̸�,
--       D.MANAGER_ID AS �Ŵ������̵�,
--       D.LOCATION_ID AS �����̼Ǿ��̵�,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS ��Ʈ����巹��,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS ����Ʈ�ڵ�,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS ��Ƽ
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT * FROM COUNTRIES;
SELECT * FROM LOCATIONS;

SELECT L.LOCATION_ID AS �����̼Ǿ��̵�, 
       L.STREET_ADDRESS AS �ּ�, 
       L.CITY AS ��Ƽ, 
       C.COUNTRY_ID, 
       C.COUNTRY_NAME 
FROM LOCATIONS L 
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT * FROM COUNTRIES;

SELECT L.LOCATION_ID AS �����̼Ǿ��̵�,
       L.STREET_ADDRESS AS �ּ�,
       L.CITY AS ��Ƽ,
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;


-----------------------------------�ǹ����� ����-----------------------------------
--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.

SELECT *
FROM(SELECT  ROWNUM AS RN,
             A.*
--       EMPLOYEE_ID,
--       FIRST_NAME,
--       PHONE_NUMBER,
--       HIRE_DATE,
--       E.DEPARTMENT_ID, --���� �Ұ����ؼ� ���ʿ��� �з����ֱ�
--       E.DEPARTMENT_NAME
            FROM (SELECT EMPLOYEE_ID,
                          FIRST_NAME,
                          PHONE_NUMBER,
                          HIRE_DATE,
                          E.DEPARTMENT_ID,
                          D.DEPARTMENT_NAME
                    FROM EMPLOYEES E 
                    LEFT JOIN DEPARTMENTS D 
                    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                    ORDER BY HIRE_DATE ) A
    )
WHERE RN > 0 AND RN  <= 10;


        
--���� 13. 
----EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���
SELECT * FROM DEPARTMENTS;

SELECT LAST_NAME,
       JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
        FROM ( SELECT *
                FROM EMPLOYEES 
                WHERE JOB_ID = 'SA_MAN') E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 14
----DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
----�ο��� ���� �������� �����ϼ���.
----����� ���� �μ��� ������� ���� �ʽ��ϴ�

--1. �μ��� ����� ī��Ʈ
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.�ο���
FROM DEPARTMENTS D
INNER JOIN (SELECT DEPARTMENT_ID, -- ���µ����� �ڿ� ���ǵǰ�
                   COUNT(*) AS �ο���
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY �ο��� DESC;


SELECT A.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       MANAGER_ID,       
       A.COUNT
        FROM (SELECT DEPARTMENT_ID, 
                     COUNT(*) COUNT 
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID) A
        RIGHT JOIN DEPARTMENTS D ON A.DEPARTMENT_ID = D.DEPARTMENT_ID
        WHERE A.DEPARTMENT_ID IS NOT NULL
        ORDER BY COUNT DESC;

--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���

SELECT D.*,
       NVL(E.SALARY, 0) AS SALARY,
       L.STREET_ADDRESS,
       L.POSTAL_CODE
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                TRUNC(AVG(SALARY)) AS SALARY
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;


SELECT D.*
FROM (SELECT DEPARTMENT_ID,
             AVG(SALARY) AS SALARY
      FROM EMPLOYEES E 
      GROUP BY DEPARTMENT_ID) AVG
      LEFT JOIN DEPARTMENTS D ON AVG.DEPARTMENT_ID = D.DEPARTMENT_ID
      LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE AVG.DEPARTMENT_ID IS NOT NULL;



--���� 16
---���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���.

SELECT D.*,
       NVL(E.SALARY, 0) AS SALARY,
       L.STREET_ADDRESS,
       L.POSTAL_CODE
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                TRUNC(AVG(SALARY)) AS SALARY
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY D.DEPARTMENT_ID DESC;

SELECT *
FROM(SELECT A.*, ROWNUM AS RN
     FROM (SELECT D.*,
                  NVL(E.SALARY, 0) AS SALARY,
                  L.STREET_ADDRESS,
                  L.POSTAL_CODE
            FROM DEPARTMENTS D
            LEFT JOIN (SELECT DEPARTMENT_ID,
                              TRUNC(AVG(SALARY)) AS SALARY
                        FROM EMPLOYEES
                        GROUP BY DEPARTMENT_ID) E
            ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
            LEFT JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID
            ORDER BY D.DEPARTMENT_ID DESC
            ) A
    )
WHERE RN > 0 AND RN <=10;




FROM(
SELECT *
FROM (SELECT R.*, 
      ROWNUM RN
FROM (SELECT D.*                     
        FROM (SELECT DEPARTMENT_ID,
                     AVG(SALARY) AS SALARY
                FROM EMPLOYEES E 
                GROUP BY DEPARTMENT_ID) AVG
LEFT JOIN DEPARTMENTS D ON AVG.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID)
WHERE AVG.DEPARTMENT_ID IS NOT NULL
ORDER BY AVG.DEPARTMENT_ID DESC) R
)
WHERE RN > 0 AND RN <=10;
