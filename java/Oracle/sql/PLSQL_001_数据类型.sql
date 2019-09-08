/********************************  001 PL/SQL �������� ****************************************/

/**
        1 ��������
        2 �ṹ
        3 �洢����
        4 ����
        5 �α�
        6 �쳣����
        7 ������
        8 ��
        9 JAVA - ORACLE                           
*/

/**
        1 ��������
        (1)PLSQL֧�����е�SQL��������
        (2)��������ֵ���ַ�������������ʱ��
           1>. number ����(decimal��float��integer��real)  
           2>. oracle11g�¼���һ���������ͣ�SIMPLE_INTEGER ��Χ(-2147483648 ~ +2147483647) 
               �������Ͳ�Ϊ��.���ڴ��������ͣ�ORACLE���Խ�����������͵Ĳ���ֱ��������Ӳ�����Ӷ�������ܡ�
           3>. �ַ��ͣ�SQL: char(����2000)/varchar2(����4000) PLSQL: ���ȶ���32767  
           4>. boolean (�߼��ж� true��false��null)
               v_num1 := 50;
               v_num2 := 60;
               v_bool := (v_num1 < v_num2);
           5>. ����ʱ��(DATE��TIMESTAMP)
        (3)LOB����(���ɴ洢4G)�����ڴ洢���ı���ͼ����Ƶ���������������ȷǽṹ�����ݡ�
           BLOB(�����ƶ���洢)
           CLOB(���ı��ַ�)
           NCLOB(�洢UNICODE�ַ�)
           BFILE(�������ƴ洢�ڲ���ϵͳ��,ֻ��)
        (4)��������
           %TYPE      ���ñ��������ݿ��е���������һ��
           %ROWTYPE   �ṩ��ʾ����һ�еļ�¼����
        (5)���ڳ��� ������Ҫ��CONSTANT�ؼ�����������һ��Ҫ��ʼ��ֵ ����: c_salary_rate CONSTANT NUMBER(7,2) := 0.25;   
               
*/

-- 001 ������ȡʾ����(ʾ��׼��)
/**
CREATE TABLE MY_BOOK(
CHARTER_ID NUMBER,
CHARTER_TEXT  CLOB
);
INSERT INTO MY_BOOK (CHARTER_ID, CHARTER_TEXT) VALUES('5','oracle11g�¼���һ���������ͣ�SIMPLE_INTEGER ��Χ(-2147483648 ~ +2147483647) 
               �������Ͳ�Ϊ��.���ڴ��������ͣ�ORACLE���Խ�����������͵Ĳ���ֱ��������Ӳ�����Ӷ��������');
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
          
-- 002 ��������
-- %TYPE(������)
DECLARE
   v_ename EMP.ENAME%TYPE;  --��emp���е�ename������ͬ
BEGIN
   SELECT E.ENAME INTO v_ename FROM EMP E WHERE E.ENAME = 'SMITH';  
   DBMS_OUTPUT.put_line(v_ename);
END;

--%TYPE��ĳһ��  
DECLARE
v_empno emp.empno%TYPE;
v_ename emp.ename%TYPE;
v_hiredate emp.hiredate%TYPE;
BEGIN
  SELECT empno, ename, hiredate INTO v_empno, v_ename, v_hiredate FROM emp WHERE empno='7369';
  dbms_output.put_line('Ա�����:' || v_empno);
  dbms_output.put_line('Ա������:' || v_ename);
  dbms_output.put_line('��ְ����:' || v_hiredate);
END;


--ʹ��%ROWTYPE�����α����͵ı���
DECLARE
  CURSOR cur_emp
  IS 
   SELECT E.EMPNO, E.ENAME, E.JOB  FROM EMP E;   --ʹ��%rowtype�����α����͵ı���
   v_emprow cur_emp%ROWTYPE;
BEGIN
  OPEN cur_emp;
  LOOP
    FETCH cur_emp INTO v_emprow;
    --ע���˳��α�
    EXIT WHEN cur_emp%NOTFOUND;
    dbms_output.put_line(v_emprow.empno || ' ' || v_emprow.ename || ' ' || v_emprow.job);
  END LOOP;     
END;


--�Զ����¼����
/**
--����һ����¼����
--������һ��my_record����
declare
type emp_record_type is record(name emp.ename%type, salary emp.sal%type);
--����һ��my_record���� ���������������emp_record_type
my_record emp_record_type; 
*/
DECLARE
--�Զ�������
TYPE emp_record_type IS RECORD(
     NAME      emp.ename%TYPE,
     salary    emp.sal%TYPE,
     title     emp.job%TYPE);
--���������Զ�������       
emp_record emp_record_type;
--ִ�г���
BEGIN
  SELECT E.ENAME, E.SAL, E.JOB INTO emp_record FROM EMP E 
  WHERE EMPNO = '7788';
  DBMS_OUTPUT.put_line('��Ա����' || emp_record.name);
END;   

-- ������(������)
/**
PL/SQL��ֻ�����У�һ�������к�һ��(һ�в�����һ���ֶ�)
ͨ���������е�����ֵ������PL/SQL���ж�Ӧ���û��Զ�����.

declare
--������һ��pl/sql������my_table_type, �����������ڴ��emp.ename%type
type my_table_type is table of emp.ename%type 
--�����б�����binary_integer���͵�
index by binary_integer
--������һ��my_table����,��������������� my_table_type
my_table my_table_type
*/

DECLARE
TYPE ename_table_type IS TABLE OF emp.ename%TYPE INDEX BY BINARY_INTEGER;
ename_table ename_table_type;
BEGIN
  SELECT ename INTO ename_table(1) FROM emp WHERE empno = 7788;
  dbms_output.put_line(ename_table(1));
END;



























































































































