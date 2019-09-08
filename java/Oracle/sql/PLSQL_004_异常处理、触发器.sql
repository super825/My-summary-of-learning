/************************************** 004 PL/SQL 异常处理、触发器 *****************************************/

/**
    异常处理
    异常有俩种类型
    预定义异常 - 当PL/SQL 程序违反Oracle规则或超越系统限制时隐式引发
    用户定义异常 - 用户可以在PL/SQL块的声明部分定义异常,自定义的异常通过RAISE语句显式引发
    命名的系统异常
    NO_DATA_FOUND
    TOO_MANY_ROWS
    VALUE_ERROR
    CURSOR_ALREADY_OPEN
    COLLECTION_IS_NULL
    ACCESS_INTO_NULL
    TIMEOUT_ON_RESOURCE
    ZERO_DIVIDE
    ...
    
    RAISE APPLICATION_ERROR 过程
    用于创建用户自定义的错误信息
    可以在执行部分和异常处理部分使用
    错误编号必须介于 -20000 和 - 20999 之间
    错误消息长度最多 2048个字节
    引发应用程序错误的语法:
    RASIE_APPLICATION_ERROR(-20001,'身份证信息与出生日期不符');
    
    注意RAISE 异常会使程序停止,不会进行后续任何操作
*/

/**
-- 实验准备
CREATE TABLE STUDENT (
SID CHAR(18) PRIMARY KEY,
SNAME CHAR(10),
SBIRTH DATE
);
*/

CREATE OR REPLACE PROCEDURE PROC4(P1 CHAR, P2 CHAR, P3 DATE)
IS
-- 自定义异常
INVALID_DATE EXCEPTION;
V_A CHAR(8);
V_B CHAR(8);
BEGIN
  INSERT INTO STUDENT VALUES (P1, P2, P3);
  SELECT SUBSTR(P1, 7, 8) INTO V_A FROM STUDENT S  WHERE S.SID = P1;
  SELECT TO_CHAR(P3,'yyyymmdd') INTO V_B FROM STUDENT S  WHERE S.SID = P1;
  IF V_A = V_B THEN
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('插入成功');
  ELSE 
    ROLLBACK;
    --升起异常
    RAISE INVALID_DATE;
  END IF;
  EXCEPTION
    WHEN INVALID_DATE THEN
    --DBMS_OUTPUT.PUT_LINE('身份证信息与出生日期不符！');
    RAISE_APPLICATION_ERROR(-20001,'身份证信息与出生日期不符');
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
    触发器
    触发器由三部分组成:
    1 触发器语句(事件)
    定义集合触发器的DML事件和DDL事件
    2 触发器限制
    执行触发器的条件 该条件必须为真才能激活触发器
    3 触发器操作(主体)
    包含一些SQL语句和代码,他们在发出了触发器语句且触发限制的值为真时运行
    CREATE [OR REPLACE] TRIGGER trigger_name
    AFTER | BEFORE | INSTEAD OF
    [INSERT] [ [OR] UPDATE [OF column_list] ]
    [[OR] DELETE]
    ON table_or_view_name
    [REFERENCING { OLD [AS] OLD/NEW [AS] new}]
    [FOR EACH ROW]
    [WHEN (condition)]
    PL/SQL_BLOCK
    
    1 DDL 触发器：在模式中执行 DDL语句时执行
    2 数据库触发器：在发生打开、关闭、登陆和退出数据库等系统事件时执行
    3 DML 触发器：正在对表或视图执行DML语句时执行
          语句级触发器：无论受影响的行数是多少，都只执行一次
          行级触发器：对DML语句修改的每个执行一次
          INSTEAD OF 触发器：用于用户不能直接使用DML语句修改的视图 
    4 注意: 触发器里面不能使用(TCL、DDL语句)：
      rollback、commit、savepoint、create、drop、alter等..      
     
*/

/**
-- 001 当用户插入、更新EMP1表中的记录时,就输入一个提示"TRIG1 BEGIN TO WORK"
实验准备
CREATE TABLE EMP1 AS SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP1;
*/

CREATE OR REPLACE TRIGGER TRIG1
AFTER INSERT OR UPDATE ON EMP1
BEGIN
      DBMS_OUTPUT.PUT_LINE('TRIG1 RESPONDED!');
END;

-- 新增
INSERT INTO EMP1 SELECT * FROM EMP E WHERE E.EMPNO = '7788';
-- 更新
UPDATE EMP1 SET SAL = 3000 WHERE EMPNO = '7782';


/**
-- 002 行级触发器
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
-- 003 :OLD.FIELD  :NEW.FIELD 使用,级联触发更新

--准备实验
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
--测试数据
insert into products values(2001, '新增数据2001', '新增版块2001');
insert into products values(2002, '新增数据2002', '新增版块2002');
update products set PRODUCT_NAME = '更新PRODUCT_NAME字段-1' where PRODUCT_ID = '1717' ;
update products set PRODUCT_NAME = '更新PRODUCT_NAME字段-2', CATEGORY = '更新CATEGORY字段-2' where PRODUCT_ID = '1718';
--查询语句
select * from products
select * from TLOG
select * from TCOL

truncate table PRODUCTS
truncate table TLOG
truncate table TCOL
*/
















