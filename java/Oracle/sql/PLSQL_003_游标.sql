/**************************************   003 PL/SQL 游标     *****************************************/


/**
    游标：三类：1隐性游标(SQL%FOUND.缺省写法存在、可以捕捉到、很少用)  
                2显式游标  
                3参照(REF)游标
                
    操作步骤: 声明游标 -> 打开游标 -> 提取行 -> 变量 -> 关闭游标.
*/

-- (1)显式游标写法1:
DECLARE
  V_SAL EMP.SAL%TYPE;
  CURSOR MYCURSOR IS 
  SELECT SAL FROM EMP WHERE SAL > 2500;
BEGIN
  OPEN MYCURSOR;
  LOOP
    FETCH MYCURSOR INTO V_SAL;
    EXIT WHEN MYCURSOR%NOTFOUND;
    DBMS_OUTPUT.put_line('工资为:' || V_SAL);
  END LOOP;
  CLOSE MYCURSOR;
END;


-- (2)显式游标写法2：
DECLARE
  V_SAL EMP.SAL%TYPE;
  --显示游标一定要在DECLARE里面出现
  CURSOR MYCURSOR IS
  SELECT SAL FROM EMP WHERE SAL > 2500;
BEGIN
  --打开游标
  OPEN MYCURSOR;
  --获取下一个值
  FETCH MYCURSOR INTO V_SAL;
    --循环
    WHILE MYCURSOR%FOUND LOOP
          DBMS_OUTPUT.put_line('工资为:' || V_SAL);
          FETCH MYCURSOR INTO V_SAL;
    END LOOP;
  --关闭游标
  CLOSE MYCURSOR;
END;


/** 
    显式游标可以带参数提高灵活性
    CURSOR <cursor_name>(<param_name> <param_type>)
    IS SELECT STATEMENT
    允许使用游标删除或更新活动集中的行
    声明游标时必须使用 SELECT ... FOR UPDATE语句
    CURSOR <cursor_name> 
    IS SELECT STATEMENT FOR UPDATE;
    UPDATE <table_name>
    SET <set_clause>
    WHERE CURRENT OF <cursor_name>
    DELETE FROM <table_name>
    WHERE CURRENT OF <cursor_name>
    
    循环游标用于简化游标处理代码
    当用户需要从游标中提取所以记录时使用
    循环游标的语法如下:
    
    FOR<record_index> IN <cursor_name>
    LOOP
      <executable statements>
    END LOOP;
*/

-- (3)带参数的游标
DECLARE
 -- 声明学号变量
 V_SNO STUDENT.STU_NO%TYPE;
 -- 一行多利记录
 V_STU STUDENT%ROWTYPE;
 CURSOR MYCURSOR(INPUT_NO NUMBER) 
 IS
 SELECT * FROM STUDENT WHERE STU_NO > INPUT_NO;
BEGIN
  V_SNO := &学生学号;
  OPEN MYCURSOR(V_SNO);
  LOOP
    FETCH MYCURSOR INTO V_STU;
    EXIT WHEN MYCURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('学号是:' || V_STU.STU_NO || '姓名是:' || V_STU.NAME);
  END LOOP;
  CLOSE MYCURSOR;
END;


-- (4)显式游标 进行更新 
DECLARE
 V_STU STUDENT%ROWTYPE;
 CURSOR MYCURSOR 
 IS
 SELECT * FROM STUDENT WHERE STU_NO = 2 OR STU_NO = 3 
 FOR UPDATE;
BEGIN 
  OPEN MYCURSOR;
  LOOP    
       FETCH MYCURSOR INTO V_STU;
       EXIT WHEN MYCURSOR%NOTFOUND;
       UPDATE STUDENT SET STU_NO = STU_NO + 100
       WHERE CURRENT OF MYCURSOR;
  END LOOP;
  CLOSE MYCURSOR; 
END;

-- (5)显式游标和记录类型结合
DECLARE 
   --定义一个记录类型
   TYPE EMP_RECORD_TYPE IS RECORD(NAME EMP.ENAME%TYPE, SALARY EMP.SAL%TYPE);
   --定义变量
   V_ET EMP_RECORD_TYPE;
   CURSOR MYCURSOR 
   IS
   SELECT ENAME, SAL FROM EMP WHERE DEPTNO = 10;
BEGIN
   OPEN MYCURSOR;
   LOOP
        FETCH MYCURSOR INTO V_ET;
        EXIT WHEN MYCURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('姓名:'|| V_ET.NAME || '薪水:' || V_ET.SALARY);
   END LOOP;
   CLOSE MYCURSOR;
END;


-- (6)显式游标和表类型结合
DECLARE 
   -- 定义一个表类型
   TYPE ENAME_TABLE_TYPE
   IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER;
   -- 定义变量
   V_ET ENAME_TABLE_TYPE;
   CURSOR MYCURSOR
   IS 
   SELECT ENAME FROM EMP WHERE DEPTNO = 10;
BEGIN
   OPEN MYCURSOR;
   FETCH MYCURSOR BULK COLLECT INTO V_ET;
   FOR I IN 1..V_ET.COUNT LOOP
       DBMS_OUTPUT.PUT_LINE(V_ET(I));
   END LOOP;
   CLOSE MYCURSOR;
END;

-- (7)显式游标用于子程序UPDATE
/**
   --实验准备
   CREATE TABLE PERSON (XH NUMBER, XM VARCHAR2(10));
   INSERT INTO PERSON VALUES(1, 'A');
   INSERT INTO PERSON VALUES(2, 'B');
   INSERT INTO PERSON VALUES(3, 'C');
   INSERT INTO PERSON VALUES(4, 'D');
   COMMIT;
   CREATE TABLE ADDRESS (XH NUMBER, ZZ VARCHAR2(20));
   INSERT INTO ADDRESS VALUES(2, '北京');
   INSERT INTO ADDRESS VALUES(1, '广州');
   INSERT INTO ADDRESS VALUES(3, '上海');
   INSERT INTO ADDRESS VALUES(4, '西安');
   COMMIT;
   SELECT * FROM PERSON;
   SELECT * FROM ADDRESS;
   ALTER TABLE PERSON ADD ZZ CHAR(10);
*/
DECLARE 
   V_XH NUMBER;
   V_ZZ VARCHAR2(10);
   CURSOR MYCURSOR 
   IS
   SELECT XH, ZZ FROM ADDRESS;
BEGIN
   OPEN MYCURSOR;
   LOOP
        FETCH MYCURSOR INTO V_XH, V_ZZ;
        EXIT WHEN MYCURSOR%NOTFOUND;
        UPDATE PERSON SET ZZ = V_ZZ WHERE XH = V_XH;
   END LOOP;
   CLOSE MYCURSOR;
END;

/**   
UPDATE PERSON P SET P.ZZ = '';
-- 使用SQL也可以实现上面的操作
UPDATE PERSON P SET P.ZZ = (SELECT A.ZZ FROM ADDRESS A WHERE A.XH = P.XH);
*/
   

/**
       参照游标(REF)
       游标和游标变量用于处理运行时动态执行的SQL查询
       创建游标变量需要俩个步骤:
       声明 REF 游标类型
       声明 REF 游标类型的变量
       用于声明 REF 游标类型的语法为:
       TYPE <ref_cursor_name> IS REF CURSOR
       [RETURN <return_type>]
*/
DECLARE 
    TYPE REFCUR IS REF CURSOR;
    MYCURSOR REFCUR;
    V_TBNAME VARCHAR2(50);
    V_NO STUDENT.STU_NO%TYPE;
    V_NAME STUDENT.NAME%TYPE;
BEGIN
    V_TBNAME := '&表名';
    IF V_TBNAME = 'STUDENT' THEN
       OPEN MYCURSOR FOR SELECT STU_NO,NAME FROM STUDENT;
       LOOP
            FETCH MYCURSOR INTO V_NO, V_NAME;
            EXIT WHEN MYCURSOR%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('学号:' || V_NO || '姓名:' || V_NAME);
       END LOOP;
       CLOSE MYCURSOR;
    ELSE 
       DBMS_OUTPUT.PUT_LINE('表名不正确');
    END IF;
END;








