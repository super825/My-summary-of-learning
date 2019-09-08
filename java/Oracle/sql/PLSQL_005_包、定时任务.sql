/****************************************005 PL/SQL ������ʱ���� *********************************/


/**
     (1)��PACKAGE
     DBMS_OUTPUT
     DBMS_LOB
     DBMS_JOB..
     ��(��ͷ������)
     ��ͷ: �������͵ı������������쳣�����̡������ȵ�������
     ���壺˽�����͵ı������������쳣�����̡������ȵ������Լ���ͷ�ڵĹ��̡�������ʵ��
     
     (2)���淶[��ͷ]
     CREATE [OR REPLACE] 
     PACKAGE <package_name> 
     IS|AS
     [Public item declarations]
     [Subprogram specification]
     END [package_name];
     
     (3)���淶[����]
     CREATE [OR REPLACE] 
     PACKAGE BODY <package_nams>
     IS|AS
     [Private item declarations]
     [Subprogram bodies]
     [BEGIN Initialization]
     END [package_name];
     
     (4)��������ŵ�     
     ģ�黯
     �����ɵ�Ӧ�ó������
     ��Ϣ����
     ��������
     ���ܸ���
     
*/


/**
-- 01 ��ʾ��
-- ʵ��׼��
CREATE TABLE STUDENT (STU_NO NUMBER(3), NAME VARCHAR2(10), SCORE NUMBER(3));
INSERT INTO STUDENT VALUES (1 , 'СС', 99);
INSERT INTO STUDENT VALUES (2 , 'СG',  80);
INSERT INTO STUDENT VALUES (3 , 'ŵŵ', 98);
INSERT INTO STUDENT VALUES (4 , 'С��', 79);
COMMIT;
SELECT * FROM STUDENT;
*/

-- ��ͷ
CREATE OR REPLACE PACKAGE PACK1
IS
V_A INT := 9;
--������ʾ�α�1
CURSOR MYCURSOR1 RETURN STUDENT%ROWTYPE;
--��������α�1
TYPE REFCUR1 IS REF CURSOR;

--��������α�2
TYPE REFCUR2 IS REF CURSOR;

PROCEDURE INSERT_STUDENT(P1 IN STUDENT%ROWTYPE);
PROCEDURE UPDATE_STUDENT(P2 IN STUDENT%ROWTYPE);
--���������ʹ����ʾ�α�
PROCEDURE MYCURSOR1_USE;
--���������ʹ�ò����α�1
PROCEDURE REFCUR1_USE;
--���������ʹ�ò����α�2
PROCEDURE REGCUR2_USE(P_NO IN NUMBER, P_CURSOR OUT PACK1.REFCUR2);

END PACK1;

-- ����
CREATE OR REPLACE PACKAGE BODY PACK1
IS
    V_B INT := 5;

    CURSOR MYCURSOR1 RETURN STUDENT%ROWTYPE
      IS 
      SELECT * FROM STUDENT; 
    
    PROCEDURE INSERT_STUDENT(P1 IN STUDENT%ROWTYPE)
      IS
      BEGIN
        INSERT INTO STUDENT(STU_NO, NAME, SCORE)
        VALUES(P1.STU_NO, P1.NAME, P1.SCORE);
        COMMIT;
      END;

    PROCEDURE UPDATE_STUDENT(P2 IN STUDENT%ROWTYPE)
      IS
      BEGIN
        UPDATE STUDENT SET NAME = P2.NAME, SCORE = P2.SCORE
        WHERE STU_NO = P2.STU_NO;
        COMMIT;
      END;
    
    PROCEDURE MYCURSOR1_USE
      IS 
      V_STU STUDENT%ROWTYPE;
      BEGIN
            OPEN MYCURSOR1;
            LOOP
                 FETCH MYCURSOR1 INTO V_STU;
                 EXIT WHEN MYCURSOR1%NOTFOUND;
                 DBMS_OUTPUT.PUT_LINE('ѧ��Ϊ:' || V_STU.STU_NO || '����Ϊ:' || V_STU.NAME);
            END LOOP;
            CLOSE MYCURSOR1;
      END MYCURSOR1_USE;
    
    PROCEDURE REFCUR1_USE
      IS
      MYREFCUR1 REFCUR1;
      V_STU STUDENT%ROWTYPE;
      BEGIN
            OPEN MYREFCUR1 FOR SELECT * FROM STUDENT;
            LOOP
                 FETCH MYREFCUR1 INTO V_STU;
                 EXIT WHEN MYREFCUR1%NOTFOUND;
                 DBMS_OUTPUT.PUT_LINE('ѧ��Ϊ:' || V_STU.STU_NO || '����Ϊ:' || V_STU.NAME);
            END LOOP;
            CLOSE MYREFCUR1;
      END;
    
 
      PROCEDURE REGCUR2_USE(P_NO IN NUMBER, P_CURSOR OUT PACK1.REFCUR2)
      IS
      BEGIN
            OPEN P_CURSOR FOR SELECT * FROM EMP WHERE DEPTNO = P_NO;
      END;

END PACK1;

--�鿴����Ϣ
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS 
WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');
--����PACK1.REGCUR2_USE
DECLARE
  MYCURSOR PACK1.REFCUR2;
  V_EMP EMP%ROWTYPE;
BEGIN
  PACK1.REGCUR2_USE(10,MYCURSOR);
  LOOP
       FETCH MYCURSOR INTO V_EMP;
       EXIT WHEN MYCURSOR%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE('����Ϊ:' || V_EMP.ENAME);
  END LOOP;
END;


/**
      ��ʱ����
*/    
/**
-- ʵ��׼��
CREATE TABLE TEST(A DATE);

CREATE OR REPLACE PROCEDURE PROC_TEST
IS
BEGIN
     INSERT INTO TEST VALUES (SYSDATE);
END;
*/ 
/**
--��������
VARIABLE job1 NUMBER;
BEGIN
     DBMS_JOB.SUBMIT(:job1, 'PROC_TEST;', SYSDATE, 'SYSDATE+1/1440');
END;
--��������
BEGIN
     DBMS_JOB.RUN(:job1);
END;
--ɾ������
BEGIN
  DBMS_JOB.REMOVE(:job1);
END;
SELECT * FROM TEST;

*/







