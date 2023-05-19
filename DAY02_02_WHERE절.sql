--WHERE 절
SELECT * FROM EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE SALARY = 4800; -- 같다
SELECT * FROM EMPLOYEES WHERE SALARY <> 4800; -- 같지 않다.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID >= 100; 
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID < 50;
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'AD_ASST';
SELECT * FROM EMPLOYEES WHERE HIRE_DATE = '03/09/17';

--BETWEEN~AND, IN, LIKE

SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 6000 AND 9000; -- 이상 ~ 이하
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '08/01/01' AND '08/12/31'; -- 날짜도 대소 비교 가능

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (10, 20, 30, 40, 50); --정확히 일치하는
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('ST_MAN', 'IT_PROG', 'HR-REF');

SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE 'IT%'; -- IT로 시작하는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03'; --3일
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%12%'; -- 12가 포함된
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '___05%';
SELECT * FROM EMPLOYEES WHERE EMAIL LIKE '_A%'; --A가 두번째에 있는

--IS NULL, IS NOT NULL
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL; -- X
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

--NOT, OR, AND
SELECT * FROM EMPLOYEES WHERE NOT SALARY >= 6000; -- 조건의 반대가 된다. NOT은 <>과 동일한 표현
--AND가 OR보다 우선순위가 빠름
SELECT * FROM EMPLOYEES WHERE SALARY >= 6000 AND SALARY <= 12000; --BETWEEN 6000 AND 12000 
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' AND SALARY >= 6000;
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR SALARY >= 6000;

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR' AND SALARY >= 6000; -- AND 먼저 실행 FI중 6000이상인 사람 OR IT_PROG 이렇게 해석해야함. -> 이따 다시 해석하기
SELECT * FROM EMPLOYEES WHERE (JOB_ID = 'IT-PROG' OR JOB_ID = 'FI_MGR') AND SALARY >= 6000; -- 위와 아래 잘 비교하고 명확하게 조건 작성해야한다.

--------------------------------------------------------------------------------
--ORDER BY 컬럼(엘리어스)
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE; -- 날짜 기준 ASC를 표기 안해도 기본값으로 오름차순
SELECT * FROM EMPLOYEES ORDER BY HIRE_dATE DESC; -- 내림차순

SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'ST_MAN') ORDER BY FIRST_NAME DESC;
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 6000 AND 12000 ORDER BY EMPLOYEE_ID;

--ALIAS도 ORDER절에 사용할 수 있음
SELECT FIRST_NAME, SALARY * 12 AS PAY FROM EMPLOYEES ORDER BY PAY ASC;

--정렬 여러개 , ,로 나열 첫번째 기준으로 우선정렬 후 같은 ID내에서 SALARY 기준 DESC 됐음
SELECT FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES ORDER BY JOB_ID ASC, SALARY DESC;









