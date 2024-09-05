/*
    <PL/SQL>
    PROCEDURE LANGAUGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    SQL���� ������ ������ ����, ����(IF), �ݺ�(FOR, WHILE)���� �����Ͽ� SQL������ ����
    �ټ��� SQL���� �ѹ��� ���డ��
    
    *PL/SQL ����
    -[�����] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - ����� : BEGIN���� ����, SQL�� �Ǵ� ��� ���� ������ ����ϴ� �κ�
    - [����ó����] : EXCEPTION���� ����, ���� �߻� �� �ذ��ϱ� ���� ����
    
*/

SET SERVEROUTPUT ON;
--HELLO ORACLE ���
BEGIN
--SYSTEM.OUT.PRINT("HELLO ORACLE") �ڹ�
    dbms_output.put_line('HELLO ORALCE');
END;
/


/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ����
    �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
    
    1_1) �Ϲ�Ÿ�� ���� ����� �ʱ�ȭ
        [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��]
        
*/

DECLARE
    eid   NUMBER;
    ename VARCHAR2(20);
    pi    CONSTANT NUMBER := 3.14;
BEGIN
    eid := 800;
    ename := '������';
    dbms_output.put_line('EID :' || eid);
    dbms_output.put_line('EID :' || ename);
    dbms_output.put_line('EID :' || pi);
END;
/

DECLARE
    eid   NUMBER;
    ename VARCHAR2(20);
    pi    CONSTANT NUMBER := 3.14;
BEGIN
    eid := &��ȣ;
    ename := '&�̸�';
    dbms_output.put_line('EID :' || eid);
    dbms_output.put_line('EID :' || ename);
    dbms_output.put_line('EID :' || pi);
END;
/


--1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ(� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
DECLARE
    eid   employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    sal   employee.salary%TYPE;
BEGIN
--EID:=800
--ENAME:='������';
--SAL :=1000000;
/
--����� 200���� ����� ���, �����, �޿���ȸ

DECLARE
    eid   employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    sal   employee.salary%TYPE;
BEGIN
    SELECT
        emp_id,
        emp_name,
        salary
    INTO
        eid,
        ename,
        sal
    FROM
        employee
    WHERE
        emp_id = 200;

    dbms_output.put_line('EID :' || eid);
    dbms_output.put_line('ename :' || ename);
    dbms_output.put_line('SAL :' || sal);
END;
/




DECLARE
    eid   employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    ename employee.job_code%TYPE;
    sal   employee.salary%TYPE;
    sal   employee.department%TYPE;
BEGIN
    SELECT
        emp_id,
        emp_name,
        job_code,
        salary,
        department
    INTO
        eid,
        ename,
        jcode,
        sal,
        dtitle
    FROM
        employee
        JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
        WHERE EMP_ID=&���;
        
    dbms_output.put_line(EID||', 'ename||', 'jcode||', 'sal||', 'dtitle||', ');

END;
/
------------------------------------------------------------------------------
--1_3) ROWŸ�� ���� ����
--���̺��� �� �࿡ ���� ��� �÷����� �ѹ��� ���� �� �մ� ����
--[ǥ����] ������ ���̺�� %ROWTYPE

DECLARE
E EMPLOYEE%ROWTYPE;
BEGIN
SELECT
    *
INTO e
FROM
    employee
WHERE
    emp_id = &���;

dbms_output.put_line('����� : ' || e.emp_name);

dbms_output.put_line('�޿� : ' || e.salary);

dbms_output.put_line('���ʽ� : ' || e.bonus);

end;
/

--------------------------------------------------------------------

--2. BEGIN �����
--<���ǹ�>
--1) IF ���ǽ� THEN ���೻�� END IF;(IF���� �ܵ����� ����� ��)
--�Է¹��� ����� �ش��ϴ� ����� ���, �̸�, �޿�, ���ʽ� ���
--��, ���ʽ��� ���� ���� ����� ���ʽ��� ��� �� '���ʽ���  ���޹��� �ʴ� ����Դϴ�.'���

DECLARE
    eid   employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    sal   employee.salary%TYPE;
    bonus employee.bonus%TYPE;
BEGIN
    SELECT
        emp_id,
        emp_name,
        salary,
        nvl(bonus, 0)
    INTO
        eid,
        ename,
        sal,
        bonus
    FROM
        employee
    WHERE
        emp_id = &���;

    dbms_output.put_line('��� : ' || eid);
    dbms_output.put_line('�̸� : ' || ename);
    dbms_output.put_line('�޿� : ' || sal);
    IF bonus = 0 THEN
        dbms_output.put_line('���ʽ���  ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    dbms_output.put_line('���ʽ� : ' || bonus);
END;
/



--2) IF ���ǽ� THEN ���೻�� ELSE 


DECLARE
    eid   employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    sal   employee.salary%TYPE;
    bonus employee.bonus%TYPE;
BEGIN
SELECT
    emp_id,
    emp_name,
    salary,
    nvl(bonus, 0)
INTO
    eid,
    ename,
    sal,
    bonus
FROM
    employee
WHERE
    emp_id = &���;

dbms_output.put_line('��� : ' || eid);

dbms_output.put_line('�̸� : ' || ename);

dbms_output.put_line('�޿� : ' || sal);

IF bonus = 0 THEN
    dbms_output.put_line('���ʽ���  ���޹��� �ʴ� ����Դϴ�.');
ELSE
    dbms_output.put_line('���ʽ� : ' || bonus);
END IF;

end;
/

--------------------------------�ǽ�----------------------------------------
--DECLARE
--���۷�������(EID, ENAME, DTITLE, NCODE)
--  ��������(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
-- �Ϲ�Ÿ�Ժ���(TEAM ���ڿ�) - ������, �ؿ��� �и��ؼ� ����
--BEGIN
-- ����ڰ� �Է��� ����� ��������� ������ ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
-- NCODE���� KO�� ��� -> TEAM ---> ������
--           KO�� �ƴ� ��� -> TEAM ---> �ؿ���
-- ���, �̸�, �μ�, �Ҽ��� ���
DECLARE
    eid    employee.emp_id%TYPE;
    ename  employee.emp_name%TYPE;
    dtitle department.dept_title%TYPE;
    ncode  location.national_code%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT
        emp_id,
        emp_name,
        dept_title,
        national_code,
        
    INTO
        eid,
        ename,
        dtitle,
        ncode
    FROM
             employee
        JOIN department ON ( dept_id = dept_code )
        JOIN location ON ( location_id = local_code )
    WHERE
        emp_id = &���;

    dbms_output.put_line('��� : ' || eid);
    dbms_output.put_line('�̸� : ' || ename);
    dbms_output.put_line('�μ��� : ' || dtitle);
    dbms_output.put_line('���� : ' || ncode);
    IF ncode = 'KO' THEN
        dbms_output.put_line(TEAM);
    ELSE
        dbms_output.put_line(TEAM);
    END IF;

END;
/
--3) IF ���ǽ�1 THEN ���೻��1 ELSIF  ���ǽ� 2 THEN ���೻��2.....[ELSE ���೻��] END IF;
DECLARE
    score NUMBER;
    grade VARCHAR2(1);
BEGIN
    score := &����;
    IF score >= 90 THEN
        grade := 'A';
    ELSIF score >= 80 THEN
        grade := 'B';
    ELSIF score >= 80 THEN
        grade := 'C';
    ELSIF score >= 80 THEN
        grade := 'D';
    ELSE
        grade := 'F';
    END IF;

    dbms_output.put_line('����� ������ ' || score||'���̸� ������ '||GRADE||'�����Դϴ�.');
END;
/

--<�ݺ���>
/*
    1) BASIC LOOP��
    [ǥ����]
    LOOP
        �ݺ������� ������ ����
        * �ݺ����� �������� �� �ִ� ����
    END LOOP;
    
    * �ݺ����� �������� �� �ִ� ����
    1) IF ���ǽ� THEN EXIT; END IF;
    2) EXIT WHEN  ���ǽ�;
    
    

*/

DECLARE
    i NUMBER := 0;
BEGIN
    LOOP
 
   -- IF i = 10 THEN
    --    EXIT;
  --  END IF;
        EXIT WHEN i = 10;
        dbms_output.put_line(i);
        i := i + 1;
    END LOOP;
END;
/


/*
2) FOR LOOP��
    [ǥ����]
    FOR ���� IN [REVERSE]  �ʱⰪ....������
    LOOP
    �ݺ������� ������ ������
    END
    LOOP;
*/

BEGIN
    FOR i IN 1..5 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

BEGIN
FOR i IN REVERSE 1..5 LOOP
    dbms_output.put_line(i);
END LOOP;

end;
/

CREATE TABLE test (
    tno NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO;


BEGIN
FOR i IN 1..100 LOOP
    INSERT INTO test VALUES (
        SEQ_TNO.NEXTVAL,
        sysdate
    );

END LOOP;

end;
/

SELECT * FROM TEST;



/*
WHILE LOOP��

[ǥ����]
WHILE �ݺ����� ����� ����
LOOP
�ݺ������� �۾�
END LOOP;

*/
DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i < 10 LOOP
        dbms_output.put_line(i);
        i := i + 1;
    END LOOP;
END;
/

-----------------------------------------------------------------------------
/*
    3. ����ó����
    ����(EXCEPTION) : ���� �� �߻��ϴ� ����
    
    EXCEPTION
    WHEN ���ܸ�1 THEN ó������1;
    WHEN ���ܸ�2 THEN ó������2;
    ...
    
    * �ý��� ����(����Ŭ���� �̸� �����ص� ����)
    -NO_DATE_FOUND : SELECT�� ����� ���൵ ���� ��
    -TOO_MANY_ROWS : SELECT�� ����� �������� ���
    - ZERO_DIVICE : 0���� ���� ��
    -DUP_VAL_ON_INDEX: UNIQUE �������� ����
    ...
*/

--����ڰ� �Է��� ���� �������� ����� �⤩��
DECLARE 
RESULT NUMBER; BEGIN
    result := 10 / &����;
    dbms_output.put_line('��� : ' || result);
EXCEPTION
  --  WHEN zero_divide THEN
       -- dbms_output.put_line('������ ���� �� 0���� ���� �� �����ϴ�.');

    WHEN OTHERS THEN
        dbms_output.put_line('������ ���� �� 0���� ���� �� �����ϴ�.');
END;
/

ALTER TABLE EMPLOYEE ADD PRIMARY KEY(EMP_ID);

BEGIN UPDATE EMPLOYEE
SET EMP_ID = '&�����һ��'--���� �ϸ� �νĸ���
WHERE EMP_NAME ='���ö';
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN DBMS_OUPPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
EMD;
/
