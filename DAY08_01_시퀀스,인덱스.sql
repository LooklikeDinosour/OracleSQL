--시퀀스 : 순차적으로 증가하는 값 -> PK에 많이 사용

SELECT * FROM USER_SEQUENCES;

--사용자 시퀀스 생성 (테이블명_SEQ)
CREATE SEQUENCE DEPTS_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10 -- 시퀀스의 최대값에 도달하면 더 이상 사용할 수 없음
    MINVALUE 1
    NOCACHE
    NOCYCLE;
    
--시퀀스 삭제(단, 사용되고 있는 시퀀스라면 주의)
DROP SEQUENCE DEPTS2_SEQ;

DROP TABLE DEPTS;
--테스트를 위해 구조만 복제한 테이블 형성 및 PK지정
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 2);
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID); --PK
SELECT * FROM DEPTS;
--시퀀스 사용
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 시퀀스의 다음값(공유)
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- 시퀀스의 현재값
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'TEST', 100, 1000); -- 위에서 최대값을 10으로 설정해서 10 이상 안들어감 
--시퀀스 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;
--시퀀스 빠른 생성(기본 옵션으로 생성됨)
CREATE SEQUENCE DEPTS2_SEQ NOCACHE; -- 기본값으로 설정되어 형성됌. NOCACHE 꼭 달아주기
SELECT * FROM USER_SEQUENCES;

--시퀀스 초기화(시퀀스가 테이블에서 사용되고 있는 경우, 시퀀스를 드롭하며 안됩니다.)
--1.현재시퀀스
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--2.증가값을 음수로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -29; --(현재시퀀스 -1)로 감소
--3.시퀀스실행
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--4.시퀀스 증가값을 다시 1로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--이후부터 시퀀스는 2에서 시작

--시퀀스 VS 년별로 시퀀스 VS 랜덤한문자열
--2022230523-00001-상품번호
CREATE TABLE DEPTS3 ( 
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);
CREATE SEQUENCE DEPTS3_SEQ NOCACHE;
--TO CHAR(SYSDATE, 'YYYYMMDD'), LPAD(데이터, 자리수, '채울값')
INSERT INTO DEPTS3 
VALUES(TO_CHAR(SYSDATE  , 'YYYYMMDD') || '-' || LPAD(DEPTS_SEQ.NEXTVAL, 5, '0') || '-' || '상품번호', 'TEST');
SELECT * FROM DEPTS3;

--------------------------------------------------------------------------------
--INDEX
--인덱스는 PK, UK에서 자동생성되는 UNIQUE인덱스가 있다.
--인덱스 조회를 빠르게해주는 HINT역할 담당
--많이 변경되지 않는 일반컬럼에 인덱스 적용 가능

CREATE TABLE EMPS_IT AS ( SELECT * FROM EMPLOYEES WHERE 1=1);
DROP TABLE EMPS_IT;
--인덱스가 없을 때 조회 VS 인덱스 생성 후 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan';

--인덱스생성 (인덱스는 조회를 빠르게 하긴 하지만, 무작위 하게 많이 생성하면, 오히려 성능 저하 가능성)
CREATE INDEX EMPS_IT_IDX ON EMPS_IT ( FIRST_NAME );
CREATE UNIQUE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME); -- 유니크인덱스(컬럼값이 유니크해야함)
--인덱스삭제
DROP INDEX EMPS_IT_IDX;
--인덱스는 (결합인덱스) 여러컬럼을 지정할 수 있습니다.
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; -- 인덱스 적용됨
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME ='McEwen'; -- 인덱스 적용됨
SELECT * FROM EMPS_IT WHERE LAST_NAME ='McEwen'; -- 인덱스 적용안됨

--FIRST_NAME기준으로 순서
--인덱스를 기준으로 힌트를 주는 방법
SELECT *
FROM (SELECT /*+ INDEX_DESC (E EMPS_IT_IDX) */
            ROWNUM RN,
            E.* 
      FROM EMPS_IT E
ORDER BY FIRST_NAME DESC)
WHERE RN >10 AND RN <=20;
