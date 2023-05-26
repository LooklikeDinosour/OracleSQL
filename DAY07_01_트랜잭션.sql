--트랜잭션 (논리적 작업단위)

SHOW AUTOCOMMIT;

--오토커밋 온
SET AUTOCOMMIT ON;
--오토커밋 오프
SET AUTOCOMMIT OFF; -- 기본값

SELECT * FROM DEPTS;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DELETE10; -- 세이브포인트 기록

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;

SAVEPOINT DELETE20;
SELECT * FROM DEPTS;

ROLLBACK TO DELETE10; -- 20번 세이브포인트로 롤백

ROLLBACK; -- 마지막 커밋 시점


--------------------------------------------------
INSERT INTO DEPTS VALUES(300, 'DEMO', NULL, 1800); -- COMMIT하지않으면 들어간 것 처럼 반영되어있음. COMMIT해야 데이터에 진짜로 반영됌

COMMIT; -- 트랜잭션 반영
SELECT * FROM DEPTS;