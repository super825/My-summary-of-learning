/**************************************002 PLSQL结构、存储过程、函数 *****************************************/
/**
  [DECLARE declarations]
  BEGIN
    executable statements
    [EXCEPTION handlers]
  END;  
*/
DECLARE
  v_ename emp.ename%TYPE;
BEGIN
  SELECT ename INTO v_ename FROM emp WHERE empno = &empno;
  dbms_output.put_line('员工姓名:' || v_ename);
  EXCEPTION
    WHEN NO_DATA_FOUND 
    THEN dbms_output.put_line('查无此人!');  
END;

/**
    条件判断
    IF boolean THEN executable END IF;
    IF boolean THEN executable ELSE executable END IF;
    IF boolean THEN executable ELSIF boolean THEN executable ELSE executable END IF;  
*/

/**
    循环 (LOOP WHILE FOR)
*/
-- LOOP
DECLARE
   j NUMBER := 0;
BEGIN
   j := 1;
   LOOP
     dbms_output.put_line(j);
     EXIT WHEN j >= 7;  
     j := j + 1;
   END LOOP;
END;

-- WHILE
DECLARE
   j NUMBER := 0;
BEGIN
   j := 1;
   WHILE j <= 8
   LOOP
       dbms_output.put_line(j || '---');
       j := j+1;
   END LOOP;
END;

-- FOR
DECLARE 
  j NUMBER := 0;
BEGIN
  FOR j IN 1..8
  LOOP
    dbms_output.put_line(j || '---');
  END LOOP;  
END;


/**
   存储过程.PROCEDURE
   参数形式三种 (in, outm in out)
*/

-- 001 in example
CREATE OR REPLACE PROCEDURE PROC1(i IN NUMBER)
AS 
 a VARCHAR2(50);
BEGIN
  a := '';
  FOR j IN 1..i 
  LOOP
    a := a || '*';
    dbms_output.put_line(a);
  END LOOP;
END;  

-- 两种方式调用存储过程 1 通过exec执行 2 通过块执行
-- exec PROC1(4);
BEGIN
  PROC1(7);
END;

-- 002 out example

CREATE OR REPLACE PROCEDURE PROC2(i OUT NUMBER)
AS
BEGIN
  i := 100;
  dbms_output.put_line(i);
END;

DECLARE
 k NUMBER;
BEGIN
  PROC2(K);
  dbms_output.put_line(k);
END; 

-- 003 in out example

CREATE OR REPLACE PROCEDURE PROC3(p1 IN OUT NUMBER , p2 IN OUT NUMBER)
AS
  v_temp NUMBER;
BEGIN
  v_temp := p1;
  p1 :=  p2;
  p2 := v_temp;
END;

DECLARE 
num1 NUMBER := 10; 
num2 NUMBER := 20;
BEGIN
  PROC3(num1, num2);
  dbms_output.put_line(num1); 
  dbms_output.put_line(num2); 
END;

/**
     函数：（函数是可以返回值的命名的PL/SQL 子程序）
     CREATE [OR REPLACE] FUNCTION <FUNCTION NAME> [(PARAM...)]
     RETURN <DATATYPE> IS|AS 
     [LOCAL DECLARATIONS]
     BEGIN
       EXECUTABLE STATEMENTS;
       RETURN RESULT;
       EXCEPTION 
         EXCEPTION HANDLERS; 
     END;
*/

-- 001 要求：创建一个函数,可以接受用户输入的学号，得到该学生的名次，输出名次。
/**
-- 实验准备
CREATE TABLE STUDENT (STU_NO NUMBER(3), NAME VARCHAR2(10), SCORE NUMBER(3));
INSERT INTO STUDENT VALUES (1 , '小小', 99);
INSERT INTO STUDENT VALUES (2 , '小G',  80);
INSERT INTO STUDENT VALUES (3 , '诺诺', 98);
INSERT INTO STUDENT VALUES (4 , '小北', 79);
COMMIT;
SELECT * FROM STUDENT;
*/

CREATE OR REPLACE FUNCTION FUNC1(SNO INT) RETURN INT
AS
 v_score NUMBER;
 v_mingci NUMBER;
BEGIN
 SELECT SCORE INTO v_score FROM STUDENT WHERE STU_NO = SNO;
 SELECT COUNT(*) INTO v_mingci FROM STUDENT WHERE SCORE > v_score;
 v_mingci := v_mingci + 1;
 RETURN v_mingci;
END;

SELECT FUNC1(3) FROM DUAL;



