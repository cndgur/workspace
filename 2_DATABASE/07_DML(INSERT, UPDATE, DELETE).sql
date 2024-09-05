/*
        DQL(QUERY ������ ���Ǿ�) : SELECT
        DML(MANIPULATION ������ ���۾�) : INSERT, UPDATE, DELETE
        DDL(DEFINITION ������ ���Ǿ�) : CREATE, ALTER,DROP
        DCL(CONTROL ������ �����) : GRANT, REVOKE
        TCL(TRANSCATION Ʈ����� �����) : COMMIT, ROLLBACK
        
        
        <DML>
        ������ ���۾��
        ���̺� ���� ����(INSERT), ����(UPDATE), ����(DELETE)�ϴ� ����
    */
    
    /*
    1. INSERT
    ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ǥ����]
    1) INSERT INO ���̺�� VALUES(��, ��, ��....)
    ���̺��� ��� �÷��� ���� ���� ���� �����ؼ� �� ���� INSERT�ϰ��� �� ��
    �÷��� ������ ���Ѽ� VALUES�� ���� �����ؾ���
    
    �����ϰ� ���� ������ ���, ���� �� ���� ������ ��� => ����
    
    */
SELECT
    *
FROM
    employee;

INSERT INTO employee VALUES (
    900,
    '�̼ұ�',
    '880914-1456789',
    'SG8809@NAVER.COM',
    '01078945656',
    'D7',
    'J5',
    4000000,
    0.2,
    200,
    sysdate,
    NULL,
    'N'
);
    
    /*
    2) INSERT INTO ���̺��(�÷�, �÷�, �÷�....)VLAUES (��, ��, ��....)
    ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
    �׷��� �� �� ������ �߰��Ǳ� ������ ���þȵ� �÷��� �⺻������ NULL�� ��
    => NOT NULL ���������� �ɷ��մ� �÷��� �ݵ�� ���� ���� �־���� �Ѵ�.
    ��, �⺻���� �����Ǿ� ������ NULL�� �ƴ� �⺻���� ��
    */

INSERT INTO employee (
    emp_id,
    emp_name,
    emp_no,
    job_code,
    hire_date
) VALUES (
    901,
    '������',
    '440701-1234567',
    'J7',
    sysdate
);

SELECT
    *
FROM
    employee;
------------------------------------------------------------------------------------------

/*
    3) INSERT INTO ���̺��(��������);
    VALUES�� ���� ���� ����ϴ� �� ��� ���������� ��ȸ�� ���� ��ä�� INSERT ����
*/

CREATE TABLE emp_01 (
    emp_id     NUMBER,
    emp_name   VARCHAR2(20),
    dept_title VARCHAR2(20)
);

SELECT
    *
FROM
    emp_01;

INSERT INTO emp_01
    ( SELECT
        emp_id,
        emp_name,
        dept_title
    FROM
        employee
        LEFT JOIN department ON ( dept_code = dept_id )
    );

SELECT
    *
FROM
    emp_01;--���� ���������� ������� ���� INSERT�Ǿ���.
    
    
-------------------------------------------------------------------------

/*
    2. INSERT ALL
    �� �� �̻��� ���̺� ���� INSERT�� ��
    �� �� ���Ǵ� ���������� ������ ���
*/

CREATE TABLE emp_dept
    AS
        ( SELECT
            emp_id,
            emp_name,
            dept_code,
            hire_date
        FROM
            employee
        WHERE
            1 = 0-- ������ ����!! ���� ������� �ʴ´�.
        );

SELECT
    *
FROM
    emp_dept;

CREATE TABLE emp_manager
    AS
        ( SELECT
            emp_id,
            emp_name,
            manager_id
        FROM
            employee
        WHERE
            1 = 0
        );
        
        
-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, �������� ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_code,
    hire_date,
    manager_id
FROM
    employee
WHERE
    dept_code = 'D1';
    
    
    /*
    [ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷�, �÷�, �÷�....)
    INTO ���̺��2 VALUES(�÷�, �÷�, �÷�....)
    ��������;
    */
INSERT ALL INTO emp_dept VALUES (
    emp_id,
    emp_name,
    dept_code,
    hire_date
) INTO emp_manager VALUES (
    emp_id,
    emp_name,
    manager_id
) ( SELECT
      emp_id,
      emp_name,
      dept_code,
      hire_date,
      manager_id
  FROM
      employee
  WHERE
      dept_code = 'D1'
  );

SELECT
    *
FROM
    emp_dept;

SELECT
    *
FROM
    emp_manager;
  ----------------------------------------------------------------------------
  
  /*
    3. UPDATE
    ���̺� ��ϵǾ� �ִ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷� = '��'
        �÷� = '��'
        ...
    [WHERE ����] -> ������ ��ü ��� ���� �����Ͱ� ����ȴ�.
    
    
    * ������Ʈ �ÿ��� ���� ���� �� Ȯ���ؾ��Ѵ�.
    
  */


CREATE TABLE dept_table
    AS
        ( SELECT
            *
        FROM
            department
        );

SELECT
    *
FROM
    dept_table;

--D9�μ��� �μ����� '������ȹ������ ����'
UPDATE dept_table
SET
    dept_title = '������ȹ��'
WHERE
    dept_id = 'D9';

SELECT
    *
FROM
    dept_table;

CREATE TABLE emp_salary
    AS
        ( SELECT
            emp_id,
            emp_name,
            dept_code,
            salary,
            bonus
        FROM
            employee
        );

SELECT
    *
FROM
    emp_salary;
-- EMP_SALARY ���̺��� ���ö ����� �޿��� 100�������� ����
UPDATE emp_salary
SET
    salary = '1000000'
WHERE
    emp_name = '���ö';

SELECT
    *
FROM
    emp_salary;
-- ������ ����� �޿��� 700����, ���ʽ��� 0.2�� ����
UPDATE emp_salary
SET
    salary = '7000000',
    bonus = '0.2'
WHERE
    emp_name = '������';

SELECT
    *
FROM
    emp_salary;
    
-- ��ü����� �޿��� ���� �޿��� 10���� �λ�� �ݾ����� �����ض�
UPDATE emp_salary
SET
    salary = salary * 1.1;

SELECT
    *
FROM
    emp_salary;
/*
   UPDATE���� �������� ���
   
   UPDATE ���̺��
   SET �÷��� = (��������)
   WHERE ����


*/
     --���� ����� �޿��� ���ʽ����� ����� ����� �޿��� ���ʽ� ������ ����
UPDATE emp_salary
SET
    salary = (
        SELECT
            salary
        FROM
            emp_salary
        WHERE
            emp_name = '�����'
    ),
    bonus = (
        SELECT
            bonus
        FROM
            emp_salary
        WHERE
            emp_name = '�����'
    )
WHERE
    emp_name = '����';

SELECT
    *
FROM
    emp_salary
WHERE
    emp_name = '����'
    OR emp_name = '�����';
    
    --ASIA�������� �ٹ��ϴ� ������� ���ʽ����� 0.3���� ����
   
    
    --ASIA�������� �ٹ��ϴ� �����
SELECT
    emp_id,
    emp_name
FROM
         emp_salary
    JOIN department ON ( dept_code = dept_id )
    JOIN location ON ( location_id = local_code )
WHERE
    location_id IN ( 'L1', 'L2', 'L3' );
    --������ ���� ������� ���ʽ����� 0.3���� ����
UPDATE emp_salary
SET
    bonus = 0.3
WHERE
    emp_id IN (
        SELECT
            emp_id
        FROM
                 emp_salary
            JOIN department ON ( dept_code = dept_id )
            JOIN location ON ( location_id = local_code )
        WHERE
            location_id IN ( 'L1', 'L2', 'L3' )
    );

COMMIT;

SELECT
    *
FROM
    emp_salary;
    
    
    /*
    4. DELETE
    ���̺� ��ϵ� �����͸� �����ϴ� ����(�� �� ������ ������ �ȴ�.)
    
    [ǥ����]
    DELETE FROM ���̺��
    [WHERE ����]-> WHRER�� ���� ���ϸ� ��ü �� �� ������.
    */

DELETE FROM employee;

SELECT
    *
FROM
    employee;

ROLLBACK;

DELETE FROM employee
WHERE
    emp_name = '�̼ұ�';

DELETE FROM employee
WHERE
    emp_id = '901';

COMMIT;

DELETE FROM department
WHERE
    dept_id = 'D1';--�ܷ�Ű �������ǿ��� ����� ������.�������ǿ��� ���������� ���������.
    
