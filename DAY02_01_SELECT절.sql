-- 오라클 주석문
/*
여러줄 주석
오라클은 대소문자 구분안함
오타 잘 안내줌
*/
SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME, EMAIL, HIRE_DATE FROM EMPLOYEES;
SELECT JOB_ID, SALARY, DEPARTMENT_ID FROM EMPLOYEES; -- 순서에 따라 출력 순서도 달라짐

SELECT * FROM DEPARTMENTS;

--연산
--컬럼을 조회하는 위치에서 * / + -
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM EMPLOYEES;

--NULL
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES;

-- 엘리어스 AS
SELECT FIRST_NAME AS 이름, 
       LAST_NAME AS 성, 
       SALARY 급여, 
       SALARY + SALARY * 0.1 총급여 
FROM EMPLOYEES; --많으면 이렇게 작성해도된댜

-- 문자열의 연결 ||
-- 오라클은 문자를 ''로 표현한다. 문자열 안에서 ''안에서 사용하고 싶으면 '' 두번쓰기
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES;
SELECT FIRST_NAME || ' ' ||LAST_NAME FROM EMPLOYEES; -- 위랑 비교해보기
SELECT FIRST_NAME || ' ' ||LAST_NAME || '''s salary $' || SALARY AS 급여내역 
FROM EMPLOYEES;

--DISTINCT 중복행 제거 (기준 : 나열된 행데이터가 모두 일치시, 중간 값이 다르면 안지워짐)
SELECT DISTINCT FIRST_NAME, DEPARTMENT_ID FROM EMPLOYEES; -- 이름, 부서명이 전부 동일한 중복행을 제거
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

--ROWID(데이터의 주소), ROWNUM(조회된 순서)
SELECT ROWNUM, ROWID, EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES; --ROWNUM 여기서는 EMPLOYEE_ID 기준

--오라클은 끄기 전에 저장 필수, 안그러면 전부 날아감. 


