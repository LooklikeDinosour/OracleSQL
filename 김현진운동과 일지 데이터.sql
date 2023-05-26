CREATE TABLE GIS_WORKOUT (
       WORKOUT_NAME VARCHAR2(50) CONSTRAINT WORKOUTS_PK PRIMARY KEY,
       BODY_PART VARCHAR2(50) CONSTRAINT WORKOUT_BP_NN NOT NULL,
       WORKOUT_EXPLAIN VARCHAR2(1000) CONSTRAINT WORKOUT_EX_NN NOT NULL,
       WORKOUT_REPS NUMBER(3) CONSTRAINT WORKOUT_REPS_CK CHECK (WORKOUT_REPS > 0)
       );
DROP TABLE GIS_WORKOUT;       
       
CREATE TABLE GIS_TRAINING_DIARY (
       DAY_N NUMBER CONSTRAINT TD_DAY_N_PK PRIMARY KEY,
       TD_DATE DATE DEFAULT SYSDATE,
       MEMBER_CODE VARCHAR2(30) REFERENCES GIS_MYPAGE(MEMBER_CODE),
       WORKOUT_NAME VARCHAR2(50) CONSTRAINT WORKOUT_NAME_NNN NOT NULL,
       BODY_PART VARCHAR2(50) CONSTRAINT WORKOUT_BP_NNN NOT NULL,
       WORKOUT_TIME NUMBER(2) CONSTRAINT TD_TIME_NN NOT NULL,
       TD_FEEDBACK VARCHAR2(100) CONSTRAINT TD_FEEDBACK_NN NOT NULL, 
       DIFFICULTY VARCHAR2(10) CONSTRAINT TD_DIFFICULTY NOT NULL
);

SELECT * FROM
GIS_TRAINING_DIARY;

INSERT INTO GIS_WORKOUT 
VALUES ('Ǯ��', '��ü', '�� ���� ��� ���� ��ŭ ������ ö���� ���� �ڿ� ����ּ���.', 5);

INSERT INTO GIS_WORKOUT 
VALUES ('����', '��ü', '�� ö���� ������ �ڿ� Ǫ�þ��ϵ��� ���� �����ּ���,', 15);

INSERT INTO GIS_WORKOUT 
VALUES ('Ǫ����', '��ü', 'Ǫ�����Ʒ��ϾƷ���Ö���������ξƷ���;�Ӥ���ä���;�Ʒ��Τ�', 15);

INSERT INTO GIS_WORKOUT 
VALUES ('�˾�', '��ü', '�������ξƷ��׶�ä��פ��ո���������������������������������������������������������������������������������������������������������������������������', 50);

INSERT INTO GIS_WORKOUT 
VALUES ('����Ʈ', '��ü', '���ӹ̤���;�Ӥ������Ϥ�������;�����ϾƷ�;�ϾƷ���;�Ӥ������ѹΤ���ùξƷ���;�Ӥ���ä��ϾƷ�;�Ӥ��Ʒ�;�Ӥ�����', 20);

INSERT INTO GIS_WORKOUT
VALUES ('����', '��ü', '���c�緯�̳����ξƤä�����;�Ӹ��̤�����������Ӹ��;�����;���������Τ���������������', 20);

INSERT INTO GIS_WORKOUT
VALUES ('�÷�ũ', '��ü', '���ʸ����Ʒ����Ƕ�ä����̤���Ф����׶�ä����ϸդ�;�Ӥ����뷳���̤�������;����������;��;���׶�ù�;������', 30);

INSERT INTO GIS_WORKOUT
VALUES ('�긴��', '��ü', '����̾��̤����̷���;�Ʒ���;�Ӥ���ȳ���Ǥ���Ǫ�������������', 50);

SELECT * FROM GIS_WORKOUT;