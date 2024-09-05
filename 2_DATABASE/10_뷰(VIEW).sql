GRANT
    CREATE VIEW
TO kh;
/*
    <VIEW> ��
    SELECT��(������)�� �����ص� �� �ִ� ��ü
    (���� ����ϴ� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ���� ����� �� �ִ�.)
    �ӽ����̺� ���� ����(���������Ͱ� ����ִ� �� �ƴϴ�.-> �����̺�)
*/

--�ѱ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_title,
    salary,
    national_name
FROM
         employee
    JOIN department ON ( dept_id = dept_code )
    JOIN location ON ( location_id = local_code )
    JOIN national USING ( national_code )
WHERE
    national_name = '�ѱ�';
    
    
    /*
        1. VIEW �������
        [ǥ����]
        CREATE VIEW ���
        AS ��������
        
    */
    
    --TB
    --VW
    --�̷��� ���̺�� �䰡 ���� �̸��̶�� ǥ�ø� �ٿ��ش�.
CREATE VIEW vw_employee AS
    ( SELECT
        emp_id,
        emp_name,
        dept_title,
        salary,
        national_name
    FROM
             employee
        JOIN department ON ( dept_id = dept_code )
        JOIN location ON ( location_id = local_code )
        JOIN national USING ( national_code )
    );

SELECT
    *
FROM
    vw_employee;
--���� ����Ǵ� ���� �Ʒ��� ���� ���������� ����ȴٰ� �� �� �ִ�.
SELECT
    *
FROM
    (
        SELECT
            emp_id,
            emp_name,
            dept_title,
            salary,
            national_name
        FROM
                 employee
            JOIN department ON ( dept_id = dept_code )
            JOIN location ON ( location_id = local_code )
            JOIN national USING ( national_code )
    );-- ��� ����
--�ѱ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT
    *
FROM
    vw_employee
WHERE
    national_name = '�ѱ�';

--���þƿ��� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT
    *
FROM
    vw_employee
WHERE
    national_name = '���þ�';

--�Ϻ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT
    *
FROM
    vw_employee
WHERE
    national_name = '�Ϻ�';


--* ���̺��� ���� �� ������ �ȵ����� ��� ���������ϴ�.
--CREATE OR REPLACE�� ����ϸ� VIEW�� ���� ���� ����, �̹� �����Ѵٸ� ������ �� �ִ�.

CREATE OR REPLACE VIEW vw_employee AS
    ( SELECT
        emp_id,
        emp_name,
        dept_title,
        salary,
        national_name,
        bonus
    FROM
             employee
        JOIN department ON ( dept_id = dept_code )
        JOIN location ON ( location_id = local_code )
        JOIN national USING ( national_code )
    );
    
    ----------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
    ���������� SELECT���� �Լ����̳� ���������� ����Ǿ� �ִٸ� �ݵ�� ��Ī�� �ο��ؾ��Ѵ�.
    


*/
CREATE OR REPLACE VIEW vw_emp_job AS
    ( SELECT
        emp_id,
        emp_name,
        decode(job_name, substr(emp_no, 8, 1), '1', '��', '2', '��') AS "����",
        EXTRACT(YEAR FROM sysdate) - EXTRACT(YEAR FROM hire_date)  AS "�ٹ����"
    FROM
             employee
        JOIN job USING ( job_code )
    );

SELECT
    *
FROM
    vw_emp_job;

SELECT
    *
FROM
    vw_emp_job
WHERE
    �ٹ���� >= 20;
    
--�並 �����ϰ� ���� ��
DROP VIEW vw_emp_job;
------------------------------------------------------------------------------

--������ �並 ���ؼ� DML(INSERT, UPDATE, DELETE)��밡�� BUT �ȵǴ� ��찡 �ʹ� ����.
--�並 ���ؼ� �����ϰԵǸ� ���� �����Ͱ� ����ִ� ���̺� �ݿ��� �ȴ�.
CREATE OR REPLACE VIEW vw_job AS
    ( SELECT
        job_code,
        job_name
    FROM
        job
    );

SELECT
    *
FROM
    vw_job;--�����̺�(���������Ͱ� ������� �ʴ�. ���ϻ�!1)
SELECT
    *
FROM
    job;--���̺�!!

--�並 ���ؼ� INSERT-->��Ӹ� �ƴ϶� ���� ���̺��� �ݿ��Ǿ� ���� �߰��ȴ�.
INSERT INTO vw_job VALUES (
    'J8',
    '����'
);

UPDATE vw_job
SET
    job_name = '�˹�'
WHERE
    job_code = 'J8';

/*
    * DML��ɾ�� ������ �Ұ����� ��찡 ����.
    1) �信 ���ǵǾ� ���� ���� �÷��� �����Ϸ��� �ϴ� ���
    2) �信 ���ǵǾ� ���� ���� �÷� �߿� ���̽����̺� �� NOT NULL���������� �����Ǿ� �ִ� ���
    3) ���������̳� �Լ����� ����� ���
    4) �׷��Լ��� GROUP BY���� ������ ���
    5) DISTINCT������ ���Ե� ���
    6) JOIN�� �̿��ؼ� �������̺��� ������ѳ��� ���
    
    ��κ� ��� ��ȸ�� �������� �����Ѵ�. �׳� �並 ���� DML�� �Ⱦ��°� ����.
    
*/

DROP TABLE test;


/*
    VIEW �ɼ�
    [��ǥ����]
    CREATE [OR REPLACE][FORCE|NO FORCE] VIEW ���
    AS ��������
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE : ������ ������ �䰡 ���� ��� �����ϰ�, ���� ��� ���� �����ض�
    2) FORCE | NOFORCE
        > FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǵ��� �ض�
        > NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��߸� �Ѵ�.(�⺻��)
    3) WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�� �����ϵ���
    4) WITH READ ONLY : �信 ���ؼ� ��ȸ�� �����ϵ���
    
*/

--2) FORCE | NOFORCE
CREATE OR REPLACE NOFORCE VIEW vw_emp AS
    SELECT
        tcode,
        tname,
        tcontent
    FROM
        tt;
--���������� ����� ���̺��� �������� �ʾƵ� �䰡 �켱�� ����� �ȴ�.
CREATE OR REPLACE FORCE VIEW vw_emp AS
    SELECT
        tcode,
        tname,
        tcontent
    FROM
        tt;

SELECT
    *
FROM
    vw_emp;

CREATE TABLE tt (
    tcode    NUMBER,
    tname    VARCHAR2(20),
    tcontent VARCHAR2(30)
);

--3) WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ������ �����߻�
--WITH CHECK OPTION�Ⱦ��� 
CREATE OR REPLACE VIEW vw_emp AS
    SELECT
        *
    FROM
        employee
    WHERE
        salary >= 3000000
WITH CHECK OPTION;

SELECT
    *
FROM
    vw_emp;
    
--200�� ��� �޿��� 200�������� ����( salary >= 3000000���ǿ� �������� �ʴ� ����)
UPDATE vw_emp
SET
    salary = 2000000
WHERE
    emp_id = 200;

SELECT
    *
FROM
    vw_emp;
    
    
--4) WITH READ ONLY : �信 ���� ��ȸ�� �����ϵ���
CREATE OR REPLACE VIEW vw_emp AS
    SELECT
        emp_id,
        emp_name,
        bonus
    FROM
        employee
    WHERE
        bonus IS NOT NULL
WITH READ ONLY;

SELECT
    *
FROM
    vw_emp;

DELETE FROM vw_emp
WHERE
    emp_id = 200;