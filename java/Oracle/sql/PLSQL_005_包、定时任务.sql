/****************************************005 PL/SQL 包、定时任务 *********************************/


/**
     (1)包PACKAGE
     DBMS_OUTPUT
     DBMS_LOB
     DBMS_JOB..
     包(包头、包体)
     包头: 公共类型的变量、常量、异常、过程、函数等的声明。
     包体：私有类型的变量、常量、异常、过程、函数等的声明以及包头内的过程、函数的实现
     
     (2)包规范[包头]
     CREATE [OR REPLACE] 
     PACKAGE <package_name> 
     IS|AS
     [Public item declarations]
     [Subprogram specification]
     END [package_name];
     
     (3)包规范[包体]
     CREATE [OR REPLACE] 
     PACKAGE BODY <package_nams>
     IS|AS
     [Private item declarations]
     [Subprogram bodies]
     [BEGIN Initialization]
     END [package_name];
     
     (4)程序包的优点     
     模块化
     更轻松的应用程序设计
     信息隐藏
     新增功能
     性能更佳
     
*/


/**
-- 01 包示例
-- 实验准备
CREATE TABLE STUDENT (STU_NO NUMBER(3), NAME VARCHAR2(10), SCORE NUMBER(3));
INSERT INTO STUDENT VALUES (1 , '小小', 99);
INSERT INTO STUDENT VALUES (2 , '小G',  80);
INSERT INTO STUDENT VALUES (3 , '诺诺', 98);
INSERT INTO STUDENT VALUES (4 , '小北', 79);
COMMIT;
SELECT * FROM STUDENT;
*/

-- 包头
CREATE OR REPLACE PACKAGE PACK1
IS
V_A INT := 9;
--定义显示游标1
CURSOR MYCURSOR1 RETURN STUDENT%ROWTYPE;
--定义参照游标1
TYPE REFCUR1 IS REF CURSOR;

--定义参照游标2
TYPE REFCUR2 IS REF CURSOR;

PROCEDURE INSERT_STUDENT(P1 IN STUDENT%ROWTYPE);
PROCEDURE UPDATE_STUDENT(P2 IN STUDENT%ROWTYPE);
--定义过程中使用显示游标
PROCEDURE MYCURSOR1_USE;
--定义过程中使用参照游标1
PROCEDURE REFCUR1_USE;
--定义过程中使用参照游标2
PROCEDURE REGCUR2_USE(P_NO IN NUMBER, P_CURSOR OUT PACK1.REFCUR2);

END PACK1;

-- 包体
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
                 DBMS_OUTPUT.PUT_LINE('学号为:' || V_STU.STU_NO || '姓名为:' || V_STU.NAME);
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
                 DBMS_OUTPUT.PUT_LINE('学号为:' || V_STU.STU_NO || '姓名为:' || V_STU.NAME);
            END LOOP;
            CLOSE MYREFCUR1;
      END;
    
 
      PROCEDURE REGCUR2_USE(P_NO IN NUMBER, P_CURSOR OUT PACK1.REFCUR2)
      IS
      BEGIN
            OPEN P_CURSOR FOR SELECT * FROM EMP WHERE DEPTNO = P_NO;
      END;

END PACK1;

--查看包信息
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS 
WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');
--调用PACK1.REGCUR2_USE
DECLARE
  MYCURSOR PACK1.REFCUR2;
  V_EMP EMP%ROWTYPE;
BEGIN
  PACK1.REGCUR2_USE(10,MYCURSOR);
  LOOP
       FETCH MYCURSOR INTO V_EMP;
       EXIT WHEN MYCURSOR%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE('姓名为:' || V_EMP.ENAME);
  END LOOP;
END;


/**
      定时任务
*/    
/**
-- 实验准备
CREATE TABLE TEST(A DATE);

CREATE OR REPLACE PROCEDURE PROC_TEST
IS
BEGIN
     INSERT INTO TEST VALUES (SYSDATE);
END;
*/ 
/**
--定义任务
VARIABLE job1 NUMBER;
BEGIN
     DBMS_JOB.SUBMIT(:job1, 'PROC_TEST;', SYSDATE, 'SYSDATE+1/1440');
END;
--运行任务
BEGIN
     DBMS_JOB.RUN(:job1);
END;
--删除任务
BEGIN
  DBMS_JOB.REMOVE(:job1);
END;
SELECT * FROM TEST;

*/







