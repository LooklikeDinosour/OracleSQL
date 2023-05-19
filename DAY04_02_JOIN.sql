SELECT * FROM iNFO, AUTH;

--INNER JOIN (INFO 6�� ������ ������) ���� �� �ִ� �����Ͱ� ������ �ȳ���
SELECT * FROM INFO JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;
SELECT ID,
       TITLE,
       -- AUTH_ID -- �������̺��� ������ �־
       -- SELECT���� ���̺���� �Բ� ��������Ѵ�.
       INFO.AUTH_ID,
       NAME
FROM INFO JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;
-- ���̺� �����
SELECT I.ID,
       I.TITLE,
       I.AUTH_ID,
       A.NAME       
FROM INFO I
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;
-- WHERE 
SELECT * 
FROM INFO I INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID
WHERE ID IN(1,2,3)
ORDER BY ID DESC;

--INNER JOIN USING ����� �츰 ��ó�� ��������
SELECT *
FROM INFO
INNER JOIN AUTH
USING (AUTH_ID);

--------------------------------------------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN ���� ���̺� ������ ��� ���
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
--RIGHT OUTER JOIN ������ ���̺� ������ ��� ���
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
SELECT * FROM AUTH A LEFT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID; -- ���� ����
--FULL OUTER JOIN ���Ǿ��� ���� ���
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID; -- ���� ���� ���� ���� ����
--CROSS JOIN
SELECT * FROM INFO I CROSS JOIN AUTH A;
SELECT * FROM AUTH A CROSS JOIN INFO I;
SELECT * FROM INFO, AUTH;

--------------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--������ ������ �� �� �ֽ��ϴ�.
SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                          LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;  

--SELF JOIN �ſ� �߿� -- Ư���� Ű���尡 ���� �ʴ�.
--���θ� ī�װ� , �� �� �� �� ���������� �����ϴ� ������ ����. 
SELECT E1.*,
       E2.FIRST_NAME AS ����� 
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

--------------------------------------------------------------------------------

--����Ŭ ���α���
--FROM�� �Ʒ��� ���̺��� ����, WHERE�� JOIN�� ������ ���ϴ�.

--INNER JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--LEFT JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

--RIGHT JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID;

--FULL JOIN ����.
--������ �ִٸ� AND�� �����ؼ� ���