/**************************************   003 PL/SQL �α�     *****************************************/


/**
    �α꣺���ࣺ1�����α�(SQL%FOUND.ȱʡд�����ڡ����Բ�׽����������)  
                2��ʽ�α�  
                3����(REF)�α�
                
    ��������: �����α� -> ���α� -> ��ȡ�� -> ���� -> �ر��α�.
*/

-- (1)��ʽ�α�д��1:
DECLARE
  V_SAL EMP.SAL%TYPE;
  CURSOR MYCURSOR IS 
  SELECT SAL FROM EMP WHERE SAL > 2500;
BEGIN
  OPEN MYCURSOR;
  LOOP
    FETCH MYCURSOR INTO V_SAL;
    EXIT WHEN MYCURSOR%NOTFOUND;
    DBMS_OUTPUT.put_line('����Ϊ:' || V_SAL);
  END LOOP;
  CLOSE MYCURSOR;
END;


-- (2)��ʽ�α�д��2��
DECLARE
  V_SAL EMP.SAL%TYPE;
  --��ʾ�α�һ��Ҫ��DECLARE�������
  CURSOR MYCURSOR IS
  SELECT SAL FROM EMP WHERE SAL > 2500;
BEGIN
  --���α�
  OPEN MYCURSOR;
  --��ȡ��һ��ֵ
  FETCH MYCURSOR INTO V_SAL;
    --ѭ��
    WHILE MYCURSOR%FOUND LOOP
          DBMS_OUTPUT.put_line('����Ϊ:' || V_SAL);
          FETCH MYCURSOR INTO V_SAL;
    END LOOP;
  --�ر��α�
  CLOSE MYCURSOR;
END;


/** 
    ��ʽ�α���Դ�������������
    CURSOR <cursor_name>(<param_name> <param_type>)
    IS SELECT STATEMENT
    ����ʹ���α�ɾ������»���е���
    �����α�ʱ����ʹ�� SELECT ... FOR UPDATE���
    CURSOR <cursor_name> 
    IS SELECT STATEMENT FOR UPDATE;
    UPDATE <table_name>
    SET <set_clause>
    WHERE CURRENT OF <cursor_name>
    DELETE FROM <table_name>
    WHERE CURRENT OF <cursor_name>
    
    ѭ���α����ڼ��α괦�����
    ���û���Ҫ���α�����ȡ���Լ�¼ʱʹ��
    ѭ���α���﷨����:
    
    FOR<record_index> IN <cursor_name>
    LOOP
      <executable statements>
    END LOOP;
*/

-- (3)���������α�
DECLARE
 -- ����ѧ�ű���
 V_SNO STUDENT.STU_NO%TYPE;
 -- һ�ж�����¼
 V_STU STUDENT%ROWTYPE;
 CURSOR MYCURSOR(INPUT_NO NUMBER) 
 IS
 SELECT * FROM STUDENT WHERE STU_NO > INPUT_NO;
BEGIN
  V_SNO := &ѧ��ѧ��;
  OPEN MYCURSOR(V_SNO);
  LOOP
    FETCH MYCURSOR INTO V_STU;
    EXIT WHEN MYCURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ѧ����:' || V_STU.STU_NO || '������:' || V_STU.NAME);
  END LOOP;
  CLOSE MYCURSOR;
END;


-- (4)��ʽ�α� ���и��� 
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

-- (5)��ʽ�α�ͼ�¼���ͽ��
DECLARE 
   --����һ����¼����
   TYPE EMP_RECORD_TYPE IS RECORD(NAME EMP.ENAME%TYPE, SALARY EMP.SAL%TYPE);
   --�������
   V_ET EMP_RECORD_TYPE;
   CURSOR MYCURSOR 
   IS
   SELECT ENAME, SAL FROM EMP WHERE DEPTNO = 10;
BEGIN
   OPEN MYCURSOR;
   LOOP
        FETCH MYCURSOR INTO V_ET;
        EXIT WHEN MYCURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('����:'|| V_ET.NAME || 'нˮ:' || V_ET.SALARY);
   END LOOP;
   CLOSE MYCURSOR;
END;


-- (6)��ʽ�α�ͱ����ͽ��
DECLARE 
   -- ����һ��������
   TYPE ENAME_TABLE_TYPE
   IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER;
   -- �������
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

-- (7)��ʽ�α������ӳ���UPDATE
/**
   --ʵ��׼��
   CREATE TABLE PERSON (XH NUMBER, XM VARCHAR2(10));
   INSERT INTO PERSON VALUES(1, 'A');
   INSERT INTO PERSON VALUES(2, 'B');
   INSERT INTO PERSON VALUES(3, 'C');
   INSERT INTO PERSON VALUES(4, 'D');
   COMMIT;
   CREATE TABLE ADDRESS (XH NUMBER, ZZ VARCHAR2(20));
   INSERT INTO ADDRESS VALUES(2, '����');
   INSERT INTO ADDRESS VALUES(1, '����');
   INSERT INTO ADDRESS VALUES(3, '�Ϻ�');
   INSERT INTO ADDRESS VALUES(4, '����');
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
-- ʹ��SQLҲ����ʵ������Ĳ���
UPDATE PERSON P SET P.ZZ = (SELECT A.ZZ FROM ADDRESS A WHERE A.XH = P.XH);
*/
   

/**
       �����α�(REF)
       �α���α�������ڴ�������ʱ��ִ̬�е�SQL��ѯ
       �����α������Ҫ��������:
       ���� REF �α�����
       ���� REF �α����͵ı���
       �������� REF �α����͵��﷨Ϊ:
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
    V_TBNAME := '&����';
    IF V_TBNAME = 'STUDENT' THEN
       OPEN MYCURSOR FOR SELECT STU_NO,NAME FROM STUDENT;
       LOOP
            FETCH MYCURSOR INTO V_NO, V_NAME;
            EXIT WHEN MYCURSOR%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ѧ��:' || V_NO || '����:' || V_NAME);
       END LOOP;
       CLOSE MYCURSOR;
    ELSE 
       DBMS_OUTPUT.PUT_LINE('��������ȷ');
    END IF;
END;








