/********************************  001 PL/SQL 数据类型 ****************************************/

/**
        1 数据类型
        2 结构
        3 存储过程
        4 函数
        5 游标
        6 异常处理
        7 触发器
        8 包
        9 JAVA - ORACLE                           
*/

/**
        1 数据类型
        (1)PLSQL支持所有的SQL数据类型
        (2)标量：数值、字符、布尔、日期时间
           1>. number 包括(decimal、float、integer、real)  
           2>. oracle11g新加入一种数据类型：SIMPLE_INTEGER 范围(-2147483648 ~ +2147483647) 
               数据类型不为空.对于此数据类型，ORACLE可以将这个数据类型的操作直接作用于硬件，从而提高性能。
           3>. 字符型：SQL: char(长度2000)/varchar2(长度4000) PLSQL: 长度都是32767  
           4>. boolean (逻辑判断 true、false、null)
               v_num1 := 50;
               v_num2 := 60;
               v_bool := (v_num1 < v_num2);
           5>. 日期时间(DATE、TIMESTAMP)
        (3)LOB类型(最大可存储4G)，用于存储大文本、图像、视频剪辑和声音剪辑等非结构化数据。
           BLOB(二进制对象存储)
           CLOB(大文本字符)
           NCLOB(存储UNICODE字符)
           BFILE(讲二进制存储在操作系统中,只读)
        (4)复合类型
           %TYPE      引用变量和数据库列的数据类型一致
           %ROWTYPE   提供表示表中一行的记录类型
        (5)对于常量 就是需要用CONSTANT关键字声明并且一定要初始化值 形如: c_salary_rate CONSTANT NUMBER(7,2) := 0.25;   
               
*/

-- 001 大对象读取示例：(示例准备)
/**
CREATE TABLE MY_BOOK(
CHARTER_ID NUMBER,
CHARTER_TEXT  CLOB
);
INSERT INTO MY_BOOK (CHARTER_ID, CHARTER_TEXT) VALUES('5','oracle11g新加入一种数据类型：SIMPLE_INTEGER 范围(-2147483648 ~ +2147483647) 
               数据类型不为空.对于此数据类型，ORACLE可以将这个数据类型的操作直接作用于硬件，从而提高性能');
SELECT * FROM MY_BOOK;
-- drop table my_book;
*/
DECLARE
    v_clob    CLOB;
    v_amount  INTEGER;
    v_offset  INTEGER;
    v_outdata VARCHAR2(1000);
BEGIN 
  SELECT M.CHARTER_TEXT INTO v_clob FROM MY_BOOK M WHERE M.CHARTER_ID = '5';
  v_amount := 300;
  v_offset := 1;
  dbms_lob.read(v_clob, v_amount, v_offset, v_outdata);
  dbms_output.put_line(v_outdata);
END;  
          
-- 002 复合类型
-- %TYPE(列类型)
DECLARE
   v_ename EMP.ENAME%TYPE;  --与emp表中的ename类型相同
BEGIN
   SELECT E.ENAME INTO v_ename FROM EMP E WHERE E.ENAME = 'SMITH';  
   DBMS_OUTPUT.put_line(v_ename);
END;

--%TYPE绑定某一列  
DECLARE
v_empno emp.empno%TYPE;
v_ename emp.ename%TYPE;
v_hiredate emp.hiredate%TYPE;
BEGIN
  SELECT empno, ename, hiredate INTO v_empno, v_ename, v_hiredate FROM emp WHERE empno='7369';
  dbms_output.put_line('员工编号:' || v_empno);
  dbms_output.put_line('员工姓名:' || v_ename);
  dbms_output.put_line('入职日期:' || v_hiredate);
END;


--使用%ROWTYPE定义游标类型的变量
DECLARE
  CURSOR cur_emp
  IS 
   SELECT E.EMPNO, E.ENAME, E.JOB  FROM EMP E;   --使用%rowtype定义游标类型的变量
   v_emprow cur_emp%ROWTYPE;
BEGIN
  OPEN cur_emp;
  LOOP
    FETCH cur_emp INTO v_emprow;
    --注意退出游标
    EXIT WHEN cur_emp%NOTFOUND;
    dbms_output.put_line(v_emprow.empno || ' ' || v_emprow.ename || ' ' || v_emprow.job);
  END LOOP;     
END;


--自定义记录类型
/**
--定义一个记录类型
--定义了一个my_record变量
declare
type emp_record_type is record(name emp.ename%type, salary emp.sal%type);
--定义一个my_record变量 这个变量的类型是emp_record_type
my_record emp_record_type; 
*/
DECLARE
--自定义类型
TYPE emp_record_type IS RECORD(
     NAME      emp.ename%TYPE,
     salary    emp.sal%TYPE,
     title     emp.job%TYPE);
--变量接受自定义类型       
emp_record emp_record_type;
--执行程序
BEGIN
  SELECT E.ENAME, E.SAL, E.JOB INTO emp_record FROM EMP E 
  WHERE EMPNO = '7788';
  DBMS_OUTPUT.put_line('雇员名：' || emp_record.name);
END;   

-- 表类型(索引表)
/**
PL/SQL表只有俩列，一个索引列和一列(一列不代表一个字段)
通过索引列中的索引值来操作PL/SQL表中对应的用户自定义列.

declare
--定义了一个pl/sql表类型my_table_type, 该类型是用于存放emp.ename%type
type my_table_type is table of emp.ename%type 
--索引列必须是binary_integer类型的
index by binary_integer
--定义了一个my_table变量,这个变量的类型是 my_table_type
my_table my_table_type
*/

DECLARE
TYPE ename_table_type IS TABLE OF emp.ename%TYPE INDEX BY BINARY_INTEGER;
ename_table ename_table_type;
BEGIN
  SELECT ename INTO ename_table(1) FROM emp WHERE empno = 7788;
  dbms_output.put_line(ename_table(1));
END;



























































































































