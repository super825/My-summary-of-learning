/************************************** 004 PL/SQL �쳣���������� *****************************************/

/**
    �쳣����
    �쳣����������
    Ԥ�����쳣 - ��PL/SQL ����Υ��Oracle�����Խϵͳ����ʱ��ʽ����
    �û������쳣 - �û�������PL/SQL����������ֶ����쳣,�Զ�����쳣ͨ��RAISE�����ʽ����
    ������ϵͳ�쳣
    NO_DATA_FOUND
    TOO_MANY_ROWS
    VALUE_ERROR
    CURSOR_ALREADY_OPEN
    COLLECTION_IS_NULL
    ACCESS_INTO_NULL
    TIMEOUT_ON_RESOURCE
    ZERO_DIVIDE
    ...
    
    RAISE APPLICATION_ERROR ����
    ���ڴ����û��Զ���Ĵ�����Ϣ
    ������ִ�в��ֺ��쳣������ʹ��
    �����ű������ -20000 �� - 20999 ֮��
    ������Ϣ������� 2048���ֽ�
    ����Ӧ�ó��������﷨:
    RASIE_APPLICATION_ERROR(-20001,'���֤��Ϣ��������ڲ���');
    
    ע��RAISE �쳣��ʹ����ֹͣ,������к����κβ���
*/

/**
-- ʵ��׼��
CREATE TABLE STUDENT (
SID CHAR(18) PRIMARY KEY,
SNAME CHAR(10),
SBIRTH DATE
);
*/

CREATE OR REPLACE PROCEDURE PROC4(P1 CHAR, P2 CHAR, P3 DATE)
IS
-- �Զ����쳣
INVALID_DATE EXCEPTION;
V_A CHAR(8);
V_B CHAR(8);
BEGIN
  INSERT INTO STUDENT VALUES (P1, P2, P3);
  SELECT SUBSTR(P1, 7, 8) INTO V_A FROM STUDENT S  WHERE S.SID = P1;
  SELECT TO_CHAR(P3,'yyyymmdd') INTO V_B FROM STUDENT S  WHERE S.SID = P1;
  IF V_A = V_B THEN
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('����ɹ�');
  ELSE 
    ROLLBACK;
    --�����쳣
    RAISE INVALID_DATE;
  END IF;
  EXCEPTION
    WHEN INVALID_DATE THEN
    --DBMS_OUTPUT.PUT_LINE('���֤��Ϣ��������ڲ�����');
    RAISE_APPLICATION_ERROR(-20001,'���֤��Ϣ��������ڲ���');
END;

DECLARE
    V_SID CHAR(18);
    V_SNAME CHAR(10);
    V_SBIRTH DATE;
BEGIN
    V_SID := '220104196708274110';
    V_SNAME := 'BHZ';
    V_SBIRTH := TO_DATE('19770827','yyyymmdd');
    PROC4(V_SID, V_SNAME, V_SBIRTH);
END;

/**
    ������
    �����������������:
    1 ���������(�¼�)
    ���弯�ϴ�������DML�¼���DDL�¼�
    2 ����������
    ִ�д����������� ����������Ϊ����ܼ������
    3 ����������(����)
    ����һЩSQL���ʹ���,�����ڷ����˴���������Ҵ������Ƶ�ֵΪ��ʱ����
    CREATE [OR REPLACE] TRIGGER trigger_name
    AFTER | BEFORE | INSTEAD OF
    [INSERT] [ [OR] UPDATE [OF column_list] ]
    [[OR] DELETE]
    ON table_or_view_name
    [REFERENCING { OLD [AS] OLD/NEW [AS] new}]
    [FOR EACH ROW]
    [WHEN (condition)]
    PL/SQL_BLOCK
    
    1 DDL ����������ģʽ��ִ�� DDL���ʱִ��
    2 ���ݿⴥ�������ڷ����򿪡��رա���½���˳����ݿ��ϵͳ�¼�ʱִ��
    3 DML �����������ڶԱ����ͼִ��DML���ʱִ��
          ��伶��������������Ӱ��������Ƕ��٣���ִֻ��һ��
          �м�����������DML����޸ĵ�ÿ��ִ��һ��
          INSTEAD OF �������������û�����ֱ��ʹ��DML����޸ĵ���ͼ 
    4 ע��: ���������治��ʹ��(TCL��DDL���)��
      rollback��commit��savepoint��create��drop��alter��..      
     
*/

/**
-- 001 ���û����롢����EMP1���еļ�¼ʱ,������һ����ʾ"TRIG1 BEGIN TO WORK"
ʵ��׼��
CREATE TABLE EMP1 AS SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP1;
*/

CREATE OR REPLACE TRIGGER TRIG1
AFTER INSERT OR UPDATE ON EMP1
BEGIN
      DBMS_OUTPUT.PUT_LINE('TRIG1 RESPONDED!');
END;

-- ����
INSERT INTO EMP1 SELECT * FROM EMP E WHERE E.EMPNO = '7788';
-- ����
UPDATE EMP1 SET SAL = 3000 WHERE EMPNO = '7782';


/**
-- 002 �м�������
*/
CREATE OR REPLACE TRIGGER TRIG2 
AFTER UPDATE ON EMP1 
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('TRIG2 ROW UPDATE!');
END;

UPDATE EMP1 SET SAL = 4000;
ROLLBACK;

/**
-- 003 :OLD.FIELD  :NEW.FIELD ʹ��,������������

--׼��ʵ��
create table PRODUCTS
(
  product_id   NUMBER(38),
  product_name VARCHAR2(60),
  category     VARCHAR2(60),
  CONSTRAINT PK_PRODUCTS PRIMARY KEY (product_id)
);

create table TLOG
(
   CHANGE_ID            VARCHAR2(32)         NOT NULL,
   DATA_CODE            VARCHAR2(40)         NOT NULL,
   CHANGE_TYPE          VARCHAR2(10)          NOT NULL,
   CHANGE_BY            VARCHAR2(80)         NOT NULL,
   CHANGE_TIME          TIMESTAMP            NOT NULL,
   CONSTRAINT PK_MST_CHANGE PRIMARY KEY (CHANGE_ID)
);

create table TCOL
(
  CHANGE_ID   VARCHAR2(32) not null,
  COLNAME     VARCHAR2(40),
  BEFOREVALUE VARCHAR2(256),
  AFTERVALUE  VARCHAR2(256),
  CONSTRAINT PK_TCOL PRIMARY KEY (CHANGE_ID, COLNAME)
);
ALTER TABLE TCOL
   ADD CONSTRAINT FK_TCOL FOREIGN KEY (CHANGE_ID)
      REFERENCES TLOG (CHANGE_ID);

insert into PRODUCTS (product_id, product_name, category) values (1501, 'VIVITAR 35MM', 'ELECTRNCS');
insert into PRODUCTS (product_id, product_name, category) values (1502, 'OLYMPUS IS50', 'ELECTRNCS');
insert into PRODUCTS (product_id, product_name, category) values (1600, 'PLAY GYM', 'TOYS');
insert into PRODUCTS (product_id, product_name, category) values (1601, 'LAMAZE', 'TOYS');
insert into PRODUCTS (product_id, product_name, category) values (1717, 'HARRY POTTER', 'DVD');
insert into PRODUCTS (product_id, product_name, category) values (1666, 'HARRY POTTER', 'DVD');
insert into PRODUCTS (product_id, product_name, category) values (1718, 'AAA', 'TTT');
commit;

*/

CREATE OR REPLACE TRIGGER t_case_change
AFTER INSERT OR UPDATE
ON PRODUCTS
FOR EACH ROW
DECLARE
  v_uid   TLOG. CHANGE_ID%TYPE;
  v_type  TLOG.CHANGE_TYPE%TYPE;
BEGIN
  SELECT sys_guid() INTO v_uid FROM DUAL;
  IF INSERTING THEN
     v_type := 'INSERT';
     INSERT INTO TLOG VALUES (v_uid, 'PRODUCTS', v_type, :NEW.PRODUCT_ID, SYSTIMESTAMP);
     INSERT INTO TCOL VALUES (v_uid, 'PRODUCT_NAME', :NEW.PRODUCT_NAME, :NEW.PRODUCT_NAME);
     INSERT INTO TCOL VALUES (v_uid, 'CATEGORY', :NEW.CATEGORY, :NEW.CATEGORY);
  END IF;
  IF UPDATING THEN
     v_type := 'UPDATE';
     INSERT INTO TLOG VALUES (v_uid, 'PRODUCTS', v_type, :OLD.PRODUCT_ID, SYSTIMESTAMP);
     IF UPDATING('PRODUCT_NAME') THEN 
         INSERT INTO TCOL VALUES (v_uid, 'PRODUCT_NAME', :OLD.PRODUCT_NAME, :NEW.PRODUCT_NAME);
     END IF;
     IF UPDATING('CATEGORY') THEN
         INSERT INTO TCOL VALUES (v_uid, 'CATEGORY', :OLD.CATEGORY, :NEW.CATEGORY); 
     END IF;
  END IF;
END;

/**
--��������
insert into products values(2001, '��������2001', '�������2001');
insert into products values(2002, '��������2002', '�������2002');
update products set PRODUCT_NAME = '����PRODUCT_NAME�ֶ�-1' where PRODUCT_ID = '1717' ;
update products set PRODUCT_NAME = '����PRODUCT_NAME�ֶ�-2', CATEGORY = '����CATEGORY�ֶ�-2' where PRODUCT_ID = '1718';
--��ѯ���
select * from products
select * from TLOG
select * from TCOL

truncate table PRODUCTS
truncate table TLOG
truncate table TCOL
*/
















