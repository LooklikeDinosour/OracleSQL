--숫자 함수
--ROUND()
SELECT ROUND(45.523, 2), ROUND(45.523), ROUND(45.523, -1) FROM DUAL;

--TRUNC() 알아두기
SELECT TRUNC(45.523, 2), TRUNC(45.523), TRUNC(45.523, -1) FROM DUAL;

--CEIL() 무조건 올림
SELECT CEIL(3.14) FROM DUAL;
--FLOOR() 무조건 내림
SELECT FLOOR(3.14) FROM DUAL;
--MOD() 나머지
SELECT 5/3 AS 몫, MOD(5, 3) AS 나머지 FROM DUAL;

-------------------------------------------------------------------------------
--날짜함수 꼭 기억해놓기
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL; --년/월/일
SELECT  FROM DUAL; -- 년/월/일 시/분/초.밀리세컨드

--날짜 연산 = 기준이 일수
SELECT SYSDATE + 10, SYSDATE - 10, SYSDATE - HIRE_DATE FROM EMPLOYEES;
SELECT SYSDATE + 10 FROM DUAL; -- +10일
SELECT SYSDATE - 10 FROM DUAL; -- -10일
SELECT SYSDATE - HIRE_DATE FROM EMPLOYEES;

SELECT (SYSDATE - HIRE_DATE) / 7 AS WEEK, TRUNC((SYSDATE - HIRE_DATE) / 365) * 12 AS MONTH, (SYSDATE - HIRE_DATE) / 365 AS YEAR FROM EMPLOYEES;
SELECT (SYSDATE - HIRE_DATE) / 7 AS WEEK FROM EMPLOYEES; -- 근속주차
SELECT (SYSDATE - HIRE_DATE) / 365 AS YEAR FROM EMPLOYEES; -- 근속년차
SELECT TRUNC((SYSDATE - HIRE_DATE) /365) * 12 AS MONTH FROM EMPLOYEES; -- 근속월차

--날짜의 반올림, 절삭
SELECT ROUND(SYSDATE), ROUND(SYSDATE, 'DAY'), ROUND(SYSDATE, 'MONTH'), ROUND(SYSDATE, 'YEAR') FROM DUAL;
SELECT ROUND(SYSDATE, 'DAY') FROM DUAL; -- 해당주의 일요일로
SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; -- 월에 대한 반올림 
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; -- 년에 대한 반올림

SELECT TRUNC(SYSDATE), TRUNC(SYSDATE, 'DAY'), TRUNC(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL; -- 해당주의 일요일
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- 월에 대한 절삭
SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- 년에 대한 절삭




