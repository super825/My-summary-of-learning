-- �����αꣻCURSOR cursor_name IS select_statement

--For ѭ���α�
--��1�������α�
--��2�������α����
--��3��ʹ��forѭ����ʹ������α�
declare
       --���Ͷ���
       cursor c_job
       is
       select empno,ename,job,sal
       from emp
       where job='MANAGER';
       --����һ���α����v_cinfo c_emp%ROWTYPE ��������Ϊ�α�c_emp�е�һ����������
       c_row c_job%rowtype;
begin
       for c_row in c_job loop
         dbms_output.put_line(c_row.empno||'-'||c_row.ename||'-'||c_row.job||'-'||c_row.sal);
       end loop;
end;


      
--Fetch�α�
--ʹ�õ�ʱ�����Ҫ��ȷ�Ĵ򿪺͹ر�

declare 
       --���Ͷ���
       cursor c_job
       is
       select empno,ename,job,sal
       from emp
       where job='MANAGER';
       --����һ���α����
       c_row c_job%rowtype;
begin
       open c_job;
         loop
           --��ȡһ�����ݵ�c_row
           fetch c_job into c_row;
           --�ж��Ƿ���ȡ��ֵ��ûȡ��ֵ���˳�
           --ȡ��ֵc_job%notfound ��false 
           --ȡ����ֵc_job%notfound ��true
           exit when c_job%notfound;
            dbms_output.put_line(c_row.empno||'-'||c_row.ename||'-'||c_row.job||'-'||c_row.sal);
         end loop;
       --�ر��α�
      close c_job;
end;

--1������ִ��һ��update����������ʽ�α�sql������%found,%notfound,%rowcount,%isopen�۲�update����ִ�������
       begin
         update emp set ENAME='ALEARK' WHERE EMPNO=7469;
         if sql%isopen then
           dbms_output.put_line('Openging');
           else
             dbms_output.put_line('closing');
             end if;
          if sql%found then
            dbms_output.put_line('�α�ָ������Ч��');--�ж��α��Ƿ�ָ����Ч��
            else
              dbms_output.put_line('Sorry');
              end if;
              if sql%notfound then
                dbms_output.put_line('Also Sorry');
                else
                  dbms_output.put_line('Haha');
                  end if;
                   dbms_output.put_line(sql%rowcount);
                   exception 
                     when no_data_found then
                       dbms_output.put_line('Sorry No data');
                       when too_many_rows then
                         dbms_output.put_line('Too Many rows');
                         end;
declare
       empNumber emp.EMPNO%TYPE;
       empName emp.ENAME%TYPE;
       begin
         if sql%isopen then
           dbms_output.put_line('Cursor is opinging');
           else
             dbms_output.put_line('Cursor is Close');
             end if;
             if sql%notfound then
               dbms_output.put_line('No Value');
               else
                 dbms_output.put_line(empNumber);
                 end if;
                 dbms_output.put_line(sql%rowcount);
                 dbms_output.put_line('-------------');
                 
                 select EMPNO,ENAME into  empNumber,empName from emp where EMPNO=7499;
                 dbms_output.put_line(sql%rowcount);
                 
                if sql%isopen then
                dbms_output.put_line('Cursor is opinging');
                else
                dbms_output.put_line('Cursor is Closing');
                end if;
                 if sql%notfound then
                 dbms_output.put_line('No Value');
                 else
                 dbms_output.put_line(empNumber);
                 end if;
                 exception 
                   when no_data_found then
                     dbms_output.put_line('No Value');
                     when too_many_rows then
                       dbms_output.put_line('too many rows');
                       end;
                   
                 
       
--2,ʹ���α��loopѭ������ʾ���в��ŵ�����
--�α�����
declare 
       cursor csr_dept
       is
       --select���
       select DNAME
       from Depth;
       --ָ����ָ��,��仰Ӧ����ָ����csr_dept��������ͬ�ı���
       row_dept csr_dept%rowtype;
begin
       --forѭ��
       for row_dept in csr_dept loop
           dbms_output.put_line('��������:'||row_dept.DNAME);
       end loop;
end;


--3,ʹ���α��whileѭ������ʾ���в��ŵĵĵ���λ�ã���%found���ԣ�
declare
       --�α�����
       cursor csr_TestWhile
       is
       --select���
       select  LOC
       from Depth;
       --ָ����ָ��
       row_loc csr_TestWhile%rowtype;
begin
  --���α�
       open csr_TestWhile;
       --����һ��ι����
       fetch csr_TestWhile into row_loc;
       --�����Ƿ������ݣ���ִ��ѭ��
         while csr_TestWhile%found loop
           dbms_output.put_line('���ŵص㣺'||row_loc.LOC);
           --����һ��ι����
           fetch csr_TestWhile into row_loc;
         end loop;
       close csr_TestWhile;
end; 
select * from emp



       
--4,�����û�����Ĳ��ű�ţ���forѭ�����α꣬��ӡ���˲��ŵ����й�Ա��������Ϣ(ʹ��ѭ���α�)
--CURSOR cursor_name[(parameter[,parameter],...)] IS select_statement;
--����������﷨����:Parameter_name [IN] data_type[{:=|DEFAULT} value]  

declare 
      CURSOR 
      c_dept(p_deptNo number)
      is
      select * from emp where emp.depno=p_deptNo;
      r_emp emp%rowtype;
begin
        for r_emp in c_dept(20) loop
            dbms_output.put_line('Ա���ţ�'||r_emp.EMPNO||'Ա������'||r_emp.ENAME||'���ʣ�'||r_emp.SAL);
        end loop;
end;
select * from emp   
--5�����α괫��һ�����֣���ʾ�˹��ֵ����й�Ա��������Ϣ(ʹ�ò����α�)
declare 
       cursor
       c_job(p_job nvarchar2)
       is 
       select * from emp where JOB=p_job;
       r_job emp%rowtype;
begin 
       for r_job in c_job('CLERK') loop
           dbms_output.put_line('Ա����'||r_job.EMPNO||' '||'Ա������'||r_job.ENAME);
        end loop;
end;
SELECT * FROM EMP

--6���ø����α���Ϊ��Ա��Ӷ��(��ifʵ��,����һ����emp��һ��һ����emp1����emp1������޸Ĳ���),��������ǰ�������������� 
--http://zheng12tian.iteye.com/blog/815770 
        create table emp1 as select * from emp;
        
declare
        cursor
        csr_Update
        is
        select * from  emp1 for update OF SAL;
        empInfo csr_Update%rowtype;
        saleInfo  emp1.SAL%TYPE;
begin
    FOR empInfo IN csr_Update LOOP
      IF empInfo.SAL<1500 THEN
        saleInfo:=empInfo.SAL*1.2;
       elsif empInfo.SAL<2000 THEN
        saleInfo:=empInfo.SAL*1.5;
        elsif empInfo.SAL<3000 THEN
        saleInfo:=empInfo.SAL*2;
      END IF;
      UPDATE emp1 SET SAL=saleInfo WHERE CURRENT OF csr_Update;
     END LOOP;
END;

--7:��дһ��PL/SQL����飬�������ԡ�A����S����ʼ�����й�Ա�����ǵĻ���нˮ(sal)��10%�����Ǽ�н(��emp1������޸Ĳ���)
declare 
     cursor
      csr_AddSal
     is
      select * from emp1 where ENAME LIKE 'A%' OR ENAME LIKE 'S%' for update OF SAL;
      r_AddSal csr_AddSal%rowtype;
      saleInfo  emp1.SAL%TYPE;
begin
      for r_AddSal in csr_AddSal loop
          dbms_output.put_line(r_AddSal.ENAME||'ԭ���Ĺ���:'||r_AddSal.SAL);
          saleInfo:=r_AddSal.SAL*1.1;
          UPDATE emp1 SET SAL=saleInfo WHERE CURRENT OF csr_AddSal;
      end loop;
end;
--8����дһ��PL/SQL����飬�����е�salesman����Ӷ��(comm)500
declare
      cursor
          csr_AddComm(p_job nvarchar2)
      is
          select * from emp1 where   JOB=p_job FOR UPDATE OF COMM;
      r_AddComm  emp1%rowtype;
      commInfo emp1.comm%type;
begin
    for r_AddComm in csr_AddComm('SALESMAN') LOOP
        commInfo:=r_AddComm.COMM+500;
         UPDATE EMP1 SET COMM=commInfo where CURRENT OF csr_AddComm;
    END LOOP;
END;

--9����дһ��PL/SQL����飬������2���ʸ����ϵ�ְԱΪMANAGER������ʱ��Խ�����ʸ�Խ�ϣ�
--����ʾ�����Զ���һ��������Ϊ�����������α�ֻ��ȡ�������ݣ�Ҳ�����������α��ʱ��ѹ�Ա���ʸ����ϵ������˲�����ŵ��α��С���
declare
    cursor crs_testComput
    is
    select * from emp1 order by HIREDATE asc;
    --������
    top_two number:=2;
    r_testComput crs_testComput%rowtype;
begin
    open crs_testComput;
       FETCH crs_testComput INTO r_testComput;
          while top_two>0 loop
             dbms_output.put_line('Ա��������'||r_testComput.ENAME||' ����ʱ�䣺'||r_testComput.HIREDATE);
             --��������һ
             top_two:=top_two-1;
             FETCH crs_testComput INTO r_testComput;
           end loop;
     close crs_testComput;
end;
    

--10����дһ��PL/SQL����飬�����й�Ա�����ǵĻ���нˮ(sal)��20%Ϊ���Ǽ�н��
--������ӵ�нˮ����300��ȡ����н(��emp1������޸Ĳ�������������ǰ��������������) 
declare
    cursor
        crs_UpadateSal
    is
        select * from emp1 for update of SAL;
        r_UpdateSal crs_UpadateSal%rowtype;
        salAdd emp1.sal%type;
        salInfo emp1.sal%type;
begin
        for r_UpdateSal in crs_UpadateSal loop
           salAdd:= r_UpdateSal.SAL*0.2;
           if salAdd>300 then
             salInfo:=r_UpdateSal.SAL;
              dbms_output.put_line(r_UpdateSal.ENAME||':  ��нʧ�ܡ�'||'нˮά���ڣ�'||r_UpdateSal.SAL);
             else 
              salInfo:=r_UpdateSal.SAL+salAdd;
              dbms_output.put_line(r_UpdateSal.ENAME||':  ��н�ɹ�.'||'нˮ��Ϊ��'||salInfo);
           end if;
           update emp1 set SAL=salInfo where current of crs_UpadateSal;
        end loop;
end;
     
--11:��ÿλԱ�������˶��������������������������   
--����
  --CEIL(n)������ȡ���ڵ�����ֵn����С����
  --FLOOR(n)������ȡС�ڵ�����ֵn���������
  --truc���÷� http://publish.it168.com/2005/1028/20051028034101.shtml
declare
  cursor
   crs_WorkDay
   is
   select ENAME,HIREDATE, trunc(months_between(sysdate, hiredate) / 12) AS SPANDYEARS,
       trunc(mod(months_between(sysdate, hiredate), 12)) AS months,
       trunc(mod(mod(sysdate - hiredate, 365), 12)) as days
   from emp1;
  r_WorkDay crs_WorkDay%rowtype;
begin
    for   r_WorkDay in crs_WorkDay loop
    dbms_output.put_line(r_WorkDay.ENAME||'�Ѿ�������'||r_WorkDay.SPANDYEARS||'��,��'||r_WorkDay.months||'��,��'||r_WorkDay.days||'��');
    end loop;
end;
  
--12:���벿�ű�ţ��������м�н����ִ��(��CASEʵ�֣�����һ��emp1���޸�emp1�������),��������ǰ��������������
--  deptno  raise(%)
--  10      5%
--  20      10%
--  30      15%
--  40      20%
--  ��н���������е�salΪ��׼
--CASE expr WHEN comparison_expr THEN return_expr
--[, WHEN comparison_expr THEN return_expr]... [ELSE else_expr] END
declare
     cursor
         crs_caseTest
          is
          select * from emp1 for update of SAL;
          r_caseTest crs_caseTest%rowtype;
          salInfo emp1.sal%type;
     begin
         for r_caseTest in crs_caseTest loop
         case 
           when r_caseTest.DEPNO=10
           THEN salInfo:=r_caseTest.SAL*1.05;
           when r_caseTest.DEPNO=20
           THEN salInfo:=r_caseTest.SAL*1.1;
           when r_caseTest.DEPNO=30
           THEN salInfo:=r_caseTest.SAL*1.15;
            when r_caseTest.DEPNO=40
           THEN salInfo:=r_caseTest.SAL*1.2;
         end case;
          update emp1 set SAL=salInfo where current of crs_caseTest;
        end loop;
end;

--13:��ÿλԱ����нˮ�����жϣ������Ա��нˮ���������ڲ��ŵ�ƽ��нˮ������нˮ��50Ԫ���������ǰ���нˮ��Ա�����������ڲ��ű�š�
--AVG([distinct|all] expr) over (analytic_clause)
---���ã�
--����analytic_clause�еĹ��������ƽ��ֵ��
  --���������﷨:
  --FUNCTION_NAME(<argument>,<argument>...)
  --OVER
  --(<Partition-Clause><Order-by-Clause><Windowing Clause>)
     --PARTITION�Ӿ�
     --���ձ��ʽ����(���Ƿ���),���ʡ���˷����Ӿ�,��ȫ���Ľ������������һ����һ����
     select * from emp1
DECLARE
     CURSOR 
     crs_testAvg
     IS
     select EMPNO,ENAME,JOB,SAL,DEPNO,AVG(SAL) OVER (PARTITION BY DEPNO ) AS DEP_AVG
     FROM EMP1 for update of SAL;
     r_testAvg crs_testAvg%rowtype;
     salInfo emp1.sal%type;
     begin
     for r_testAvg in crs_testAvg loop
     if r_testAvg.SAL>r_testAvg.DEP_AVG then
     salInfo:=r_testAvg.SAL-50;
     end if;
     update emp1 set SAL=salInfo where current of crs_testAvg;
     end loop;
end;
