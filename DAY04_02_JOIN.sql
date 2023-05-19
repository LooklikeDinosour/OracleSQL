SELECT * FROM iNFO, AUTH;

--INNER JOIN (INFO 6번 데이터 없어짐) 붙을 수 있는 데이터가 없으면 안나옴
SELECT * FROM INFO JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;
SELECT ID,
       TITLE,
       -- AUTH_ID -- 양쪽테이블에서 가지고 있어서
       -- SELECT에서 테이블명을 함께 적어줘야한다.
       INFO.AUTH_ID,
       NAME
FROM INFO JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;
-- 테이블 엘리어스
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

--INNER JOIN USING 참고용 우린 위처럼 연습예정
SELECT *
FROM INFO
INNER JOIN AUTH
USING (AUTH_ID);

--------------------------------------------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN 왼쪽 테이블 데이터 모두 출력
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
--RIGHT OUTER JOIN 오른쪽 테이블 데이터 모두 출력
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
SELECT * FROM AUTH A LEFT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID; -- 위와 같다
--FULL OUTER JOIN 유실없이 전부 출력
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID; -- 양쪽 유실 없이 전부 나옴
--CROSS JOIN
SELECT * FROM INFO I CROSS JOIN AUTH A;
SELECT * FROM AUTH A CROSS JOIN INFO I;
SELECT * FROM INFO, AUTH;

--------------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--조인은 여러번 들어갈 수 있습니다.
SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                          LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;  

--SELF JOIN 매우 중요 -- 특별한 키워드가 있지 않다.
--쇼핑몰 카테고리 , 시 군 구 등 계층구조를 형성하는 곳에서 사용됌. 
SELECT E1.*,
       E2.FIRST_NAME AS 상급자 
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

--------------------------------------------------------------------------------

--오라클 조인구문
--FROM절 아래에 테이블을 나열, WHERE에 JOIN의 조건을 씁니다.

--INNER JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--LEFT JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

--RIGHT JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID;

--FULL JOIN 없다.
--조건이 있다면 AND로 연결해서 사용