--서브쿼리
--SELECT문이 SELECT구문으로 들어가는 형태 : 스칼라 서브쿼리
--SELECT문이 FROM구문으로 들어가는 형태 : 인라인뷰
--SELECT문이 WHERE구문으로 들어가는 형태 : 서브쿼리
--서브쿼리는 반드시 () 안에 적습니다.

--단일행 서브쿼리 - 리턴되는 행이 1개인 서브쿼리

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID가 103번인 사람과 동일한 직군
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--주의할 점, 단일 행이어야 합니다. 컬럼 값도 1개여야합니다.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID=104); -- ERROR

--------------------------------------------------------------------------------
--다중행 서브쿼리 - 행이 여러개라며 IN, ANY, ALL로 비교합니다.
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

--IN 동일한 값을 찾음 IN(4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY 최소값 보다 큼, 최대값 보다 작음
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --급여가 9500보다 작은 사람들, 급여가 4800보다 큰 사람들

--ALL 최대값보다 큼, 최소갑 보다 작음
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --급여가 9500보다 큰 사람들, 급여가 4800보다 작은 사람들

--직업이 IT_prog인 사람들의 급여 최소값보다 큰 급여를 받는 사람들
SELECT SALARY FROM EMPLOYEES WHERE JOB_ID ='IT_PROG'; 
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID ='IT_PROG');

--------------------------------------------------------------------------------
--스칼라 서브쿼리
--JOIN시에 특정테이블의 1컬럼을 가지고 올 때 유리합니다.
--아래 두개는 같은 결과를 출력
SELECT FIRST_NAME,
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID )
FROM EMPLOYEES E
ORDER BY FIRST_NAME;
--LEFT 조인
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;

--각 부서의 매니저 이름을 출력
--JOIN
SELECT D.*,
       E.FIRST_NAME 
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;

--스칼라
SELECT D.*,
       (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--스칼라쿼리는 여러번 가능
SELECT * FROM JOBS; --JOB_TITLE
SELECT * FROM DEPARTMENTS ; -- DEPARTMENT_NAME
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E; 

--각 부서의 사원 수를 출력 + 부서 정보
SELECT DEPARTMENT_ID AS 부서아이디,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS 부서명,
       COUNT(*) AS 사원수
FROM EMPLOYEES E
GROUP BY DEPARTMENT_ID;

SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID), 0) AS 사원수
FROM DEPARTMENTS D;


--------------------------------------------------------------------------------
--인라인 뷰
--가짜 테이블 형태
--안쪽에 들어갈 구문먼저 작성

--ROWNUM는 조회된 순서이기 때문에, ORDER와 같이 사용되면 ROWNUM 섞이는 문제
SELECT E.*, ROWNUM
FROM EMPLOYEES E
ORDER BY SALARY DESC;

--이렇게 바꿔서 처리해야됌.
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
        FROM EMPLOYEES
        ORDER BY SALARY DESC);
--문법2        
SELECT ROWNUM, 
       A.*
FROM (SELECT FIRST_NAME,
             SALARY
      FROM EMPLOYEES
      ORDER BY SALARY
      ) A;
      
--ROWNUM는 무조건 1번째부터 조회가 가능하기 때문에 그렇다.
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
        FROM EMPLOYEES
        ORDER BY SALARY DESC)
WHERE ROWNUM >= 1; -- 조회 됌. 주석으로 위아래 번갈아가면서 해보기        
-- WHERE ROWNUM BETWEEN 11 AND 20; --조회 안됌.       

--2번째 인라인뷰에서 ROWNUM을 RN을 컬럼화 -> ROWNUM중간번호도 출력가능
SELECT *
FROM ( SELECT FIRST_NAME,
              SALARY,
              ROWNUM AS RN
        FROM (SELECT *
                FROM EMPLOYEES
                ORDER BY SALARY DESC)
        )
WHERE RN >= 51 AND RN <= 60;

--인라인 뷰의 예시
SELECT TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,
       NAME 
FROM (SELECT '홍길동' AS NAME, SYSDATE AS REGDATE FROM DUAL
        UNION ALL
        SELECT '이순식', SYSDATE FROM DUAL);
        
--인라인 뷰의 응용(거시적 관점에서 바라보기)
--부서별 사원수
SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D
JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) AS TOTAL
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;


--정리
--단일행(대소비교) VS 다중행 서브쿼리(IN, ANY, ALL)
--스칼라쿼리 - LEFT JOIN과 같은 역할, 한번에 1개의 컬럼을 가져올 때
--인라인뷰 - FROM에 들어가는 가짜 테이블

--------------------------------------------------------------------------------

--문제 1.
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
---EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요
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

--문제 2.
---DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
--EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.
SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.MANAGER_ID = '100';

SELECT * 
FROM EMPLOYEES E 
WHERE E.DEPARTMENT_ID = (SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.MANAGER_ID = '100');

--문제 3.
---EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
---EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 같은 모든 사원의 데이터를 출력하세요.
SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat'; --201

SELECT * 
FROM EMPLOYEES 
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');


SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James';

SELECT * 
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');


--문제 4.
---EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요
(SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME DESC) ;
SELECT *
FROM ( SELECT ROWNUM AS RN, 
              FIRST_NAME 
        FROM (SELECT *
              FROM EMPLOYEES 
              ORDER BY FIRST_NAME DESC) E
                )
WHERE RN >= 41 AND RN <= 50;

--문제 5.
---EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요.S
SELECT * FROM EMPLOYEES;

SELECT *
FROM (SELECT E.*, 
             ROWNUM AS RN
        FROM (SELECT EMPLOYEE_ID AS 사원ID,
                     FIRST_NAME||' '||LAST_NAME AS 이름,
                     PHONE_NUMBER AS 번호,
                     HIRE_DATE AS 입사일,
                     TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH:MI:SS') AS TIME -- 인라인뷰를 통해서 이런식으로 추가가능
              FROM EMPLOYEES
              ORDER BY HIRE_DATE) E
        )
WHERE RN BETWEEN 31 AND 40;        

--문제
--문제 6.
--employees테이블 departments테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬
SELECT * FROM DEPARTMENTS; 
SELECT E.EMPLOYEE_ID AS 직원아이디, 
       CONCAT(E.FIRST_NAME, E.LAST_NAME) AS 이름, 
       E.DEPARTMENT_ID AS 부서아이디, 
       D.DEPARTMENT_NAME AS 부서명  
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
ORDER BY EMPLOYEE_ID;


SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME AS NAME,
       D.DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM DEPARTMENTS D RIGHT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT E.EMPLOYEE_ID AS 직원아이디,
       CONCAT(E.FIRST_NAME, E.LAST_NAME) AS 이름,
       E.DEPARTMENT_ID AS 부서아이디,
       (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;


--문제 8.
--departments테이블 locations테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT D.DEPARTMENT_ID AS 부서아이디,
       D.DEPARTMENT_NAME AS 부서이름,
       D.MANAGER_ID AS 매니저아이디,
       D.LOCATION_ID AS 로케이션아이디,
       L.STREET_ADDRESS AS 스트릿_어드레스,
       L.POSTAL_CODE AS 포스트코드,
       L.CITY AS 시티
FROM DEPARTMENTS D 
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;

--문제 9.
--문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요-> 이런경우는 조인이 낫다.
SELECT D.*,
--SELECT D.DEPARTMENT_ID AS 부서아이디,
--       D.DEPARTMENT_NAME AS 부서이름,
--       D.MANAGER_ID AS 매니저아이디,
--       D.LOCATION_ID AS 로케이션아이디,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS 스트릿어드레스,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS 포스트코드,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS 시티
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

--문제 10.
--locations테이블 countries 테이블을 left 조인하세요
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬
SELECT * FROM COUNTRIES;
SELECT * FROM LOCATIONS;

SELECT L.LOCATION_ID AS 로케이션아이디, 
       L.STREET_ADDRESS AS 주소, 
       L.CITY AS 시티, 
       C.COUNTRY_ID, 
       C.COUNTRY_NAME 
FROM LOCATIONS L 
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;

--문제 11.
--문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT * FROM COUNTRIES;

SELECT L.LOCATION_ID AS 로케이션아이디,
       L.STREET_ADDRESS AS 주소,
       L.CITY AS 시티,
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;


-----------------------------------실무에서 쓰임-----------------------------------
--문제 12. 
--employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 1-10번째 데이터만 출력합니다
--조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 부서아이디, 부서이름 을 출력합니다.
--조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.

SELECT *
FROM(SELECT  ROWNUM AS RN,
             A.*
--       EMPLOYEE_ID,
--       FIRST_NAME,
--       PHONE_NUMBER,
--       HIRE_DATE,
--       E.DEPARTMENT_ID, --참조 불가능해서 안쪽에서 분류해주기
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


        
--문제 13. 
----EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요
SELECT * FROM DEPARTMENTS;

SELECT LAST_NAME,
       JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
        FROM ( SELECT *
                FROM EMPLOYEES 
                WHERE JOB_ID = 'SA_MAN') E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--문제 14
----DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
----인원수 기준 내림차순 정렬하세요.
----사람이 없는 부서는 출력하지 뽑지 않습니다

--1. 부서별 사람수 카운트
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.인원수
FROM DEPARTMENTS D
INNER JOIN (SELECT DEPARTMENT_ID, -- 없는데이터 자연 유실되게
                   COUNT(*) AS 인원수
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY 인원수 DESC;


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

--문제 15
----부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요
----부서별 평균이 없으면 0으로 출력하세요

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



--문제 16
---문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
--출력하세요.

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
