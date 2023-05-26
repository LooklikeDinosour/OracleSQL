--DDL�� CREATE, ALTER, DROP
--����Ŭ ��ǥ ������ Ÿ�� (VARCHAR2 - ���� ����, CHAR - ���� ����, NUMBER - ����, DATE - ��¥)
--���̺� ����
CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2), -- ���� 2�ڸ��� 
    DEPT_NAME VARCHAR(20), -- �ִ� 20����Ʈ, ���� ������
    DEPT_YN CHAR(1), -- 1BYTE ����������
    DEPT_DATE DATE,
    DEPT_BOBUS NUMBER(10, 3) -- ���� 10�ڸ�, �Ҽ��� 3�ڸ�
);

DROP TABLE DEPT2; -- ���̺� �����

DESC DEPT2;
INSERT INTO DEPT2 VALUES(99, 'SALES', 'Y', SYSDATE, 3.14);
SELECT * FROM DEPT2;
INSERT INTO DEPT2 VALUES(98, 'SALES', 'ȫ', SYSDATE, 3.14); --�ѱ��� 2����Ʈ, ������ �Է� X
COMMIT;

--------------------------------------------------------------------------------
--���̺� ���� ����
--�� �߰�
SELECT * FROM DEPT2;
ALTER TABLE DEPT2 ADD (DEPT_COUNT NUMBER(3)); -- DEPT_COUNT �÷� �߰�

--�� �̸� ����
ALTER TABLE DEPT2 RENAME COLUMN DEPT_COUNT TO EMP_COUNT; -- �÷� �̸� ����

--�� ����(Ÿ�Ժ���)
ALTER TABLE DEPT2 MODIFY (EMP_COUNT NUMBER(10));

--�� ����
ALTER TABLE DEPT2 DROP COLUMN EMP_COUNT;

DESC DEPT2;
SELECT * FROM DEPT2;
-- ���� ���� ������ �ȳ��� �Ʒ��� ���� ������� ����
-- ���� -> ���� -> ���̺� -> �����ϰ� ���� ���̺� ������Ŭ���ؼ� �������� ���� ���� ����

--------------------------------------------------------------------------------
--���̺� ����
DROP TABLE DEPT2;
--DROP TABLE DEPT2 CASCADE �������Ǹ�; -- ��������FK�� ����, ���̺� ����


--------------------------------------------------------------------------------
--��������
--������ ��������(���̺� ���� ��ÿ� �� ���� ���´�.)
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM DEPTS2;
DESC DEPTS2;

--�������� �̸��� �ڵ�����
CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2)       PRIMARY KEY,
    DEPT_NAME VARCHAR(20)   NOT NULL,
    DEPT_DATE DATE          DEFAULT SYSDATE, -- ��������X (�÷��⺻��) 
    DEPT_PHONE VARCHAR2(20) UNIQUE,
    DEPT_BONUS NUMBER(10)   CHECK(DEPT_BONUS > 0), 
    LOCA NUMBER(4)          REFERENCES LOCATIONS(LOCATION_ID)--�������̺�(�����÷�), --FK
);

DROP TABLE DEPTS2;

--�������� �̸��� ����

CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2)       CONSTRAINT DEPT2_PK PRIMARY KEY,
    DEPT_NAME VARCHAR(20)   CONSTRAINT DEPT2_NAME_NN NOT NULL,
    DEPT_DATE DATE          DEFAULT SYSDATE, -- ��������X (�÷��⺻��) 
    DEPT_PHONE VARCHAR2(20) CONSTRAINT DEPT2_PHONE_UK UNIQUE,
    DEPT_BONUS NUMBER(10)   CONSTRAINT DEPT2_BONUS_CK CHECK(DEPT_BONUS > 0), 
    LOCA NUMBER(4)          CONSTRAINT DPET2_LOCA_FK REFERENCES LOCATIONS(LOCATION_ID)--�������̺�(�����÷�), --FK
);

DROP TABLE DEPTS2;

--���̺� ���� �������� (���� Ű��, ���� FK�� ���� ����)
CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR(20) NOT NULL, --���̺� �������� ������ �ȵż� ���� ����
    DEPT_DATE DATE          DEFAULT SYSDATE, -- ��������X (�÷��⺻��) 
    DEPT_PHONE VARCHAR2(20),
    DEPT_BONUS NUMBER(10), 
    LOCA NUMBER(4),--�������̺�(�����÷�), --FK
    CONSTRAINT DEPT_PK PRIMARY KEY (DEPT_NO /*DEPT_NAME*/), -- ����Ű ����
    CONSTRAINT DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
    CONSTRAINT DEPT_BONUS_CK CHECK(DEPT_BONUS > 0),
    CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(LOCATION_ID)
);

DESC DEPTS2;
INSERT INTO DEPTS2 VALUES(NULL, 'HONG', SYSDATE, '010...', 10000, 1000); --PK ���� ������Ű��
--��ü���Ἲ (NULL�� �ߺ����� ������� ����)
INSERT INTO DEPTS2 VALUES(10, 'HONG', SYSDATE, '010...', 10000, 1000);
--�Ʒ� �����ϸ� ���� �߻�
INSERT INTO DEPTS2 VALUES(10, 'HONG', SYSDATE, '010...', 10000, 1000); 

--�������Ἲ (�������̺��� PK�� �ƴ� ���� FK�� �� �� ����)
--LOCA 500�� LOCATIONS�� PK�� �ƴ� 
INSERT INTO DEPTS2 VALUES(20, 'HONG', SYSDATE, '0101111111111', 10000, 500);
--������ ���Ἲ(���� �÷��� ���ǵ� ���̾�� �Ѵ�.) DEPT_BONUS
INSERT INTO DEPTS2 VALUES(30, 'HONG', SYSDATE, '0102222222222', -1000, 1000);

--------------------------------------------------------------------------------
-- ���������� �߰� OR ����
DROP TABLE DEPTS2;

CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR(20), 
    DEPT_DATE DATE          DEFAULT SYSDATE, -- ��������X (�÷��⺻��) 
    DEPT_PHONE VARCHAR2(20),
    DEPT_BONUS NUMBER(10), 
    LOCA NUMBER(4)--�������̺�(�����÷�), --FK
--    CONSTRAINT DEPT_PK PRIMARY KEY (DEPT_NO /*DEPT_NAME*/), -- ����Ű ����
--    CONSTRAINT DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
--    CONSTRAINT DEPT_BONUS_CK CHECK(DEPT_BONUS > 0),
--    CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(LOCATION_ID)
);

--���� ������ ���� �Ұ�, �߰� OR ������ ������ �����ؾ߉�
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_PK PRIMARY KEY (DEPT_NO);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_BONUS_CK CHECK (DEPT_BONUS > 0);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID);

--NOT NULL�� MODIFY�������� ������ �մϴ�.
ALTER TABLE DEPTS2 MODIFY DEPT_NAME VARCHAR2(20) NOT NULL;

--�������� ����
ALTER TABLE DEPTS2 DROP CONSTRAINT DEPT_LOCA_FK;

--------------------------------------------------------------------------------
--��������

--���� 1.

--M_NAME M_NUM REG_DATE GENDER LOCA
--AAA       1   2018-07-01 M    1800
--BBB       2   2018-07-02 F    1900
--CCC       3   2018-07-03 M    2000
--DDD       4   ���ó�¥    M     2000

--������ ���� ���̺��� �����ϰ� �����͸� insert�ϼ��� (Ŀ��)
--����) M_NAME �� ����������, �ΰ��� ������� ����
--����) M_NUM �� ������, �̸�(mem_memnum_pk) primary key
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, �̸�:(mem_regdate_uk) UNIQUEŰ
--����) GENDER ���������� ('M' OR 'F')
--����) LOCA ������, �̸�:(mem_loca_loc_locid_fk) foreign key ? ���� locations���̺�(location_id)
--���� 2.
--MEMBERS���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� m_name, m_mum, street_address, location_id
--�÷��� ��ȸ
--m_num�������� �������� ��ȸ
CREATE TABLE MEMBERS (
M_NAME VARCHAR2(30) NOT NULL,
M_NUM NUMBER(5),
REG_DATE DATE,
GENDER CHAR(1),
LOCA NUMBER(4)
);

ALTER TABLE MEMBERS ADD CONSTRAINT MEM_MEM








CREATE TABLE TEST1 (
    M_NAME VARCHAR2(30) CONSTRAINT M_NAME_NN NOT NULL,
    M_NUM NUMBER(10) CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE CONSTRAINT MEM_REGDATE_UK NOT NULL UNIQUE,
    GENDER CHAR(1) CONSTRAINT MEM_GENDER_CK CHECK (GENDER IN ('M', 'F')),
    LOCA NUMBER(10) CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO TEST1 VALUES('AAA', 1, '2018-07-01', 'M', 1800);
INSERT INTO TEST1 VALUES('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO TEST1 VALUES('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO TEST1 VALUES('DDD', 4, SYSDATE, 'M', 2000);

SELECT * FROM TEST1;
SELECT * FROM LOCATIONS;
COMMIT;

SELECT T.M_NAME,
       T.M_NUM,
       L.STREET_ADDRESS,
       L.LOCATION_ID
FROM TEST1 T INNER JOIN LOCATIONS L ON T.LOCA = L.LOCATION_ID
ORDER BY T.M_NUM;
