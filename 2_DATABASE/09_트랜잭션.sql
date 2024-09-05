/*
    <DCL : ������ ���>
    ������ �ý��� ���� �Ǵ� ��ü���ٱ����� �ο��ϰų� ȸ���ϴ� ����
    
    > �ý��۱��� : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
    > ��ü ���� ���� : Ư�� ��ü���� ������ �� �ִ� ����
    
    CREATE USER ������--���躼�� ������ ����. ������ �������� ��������!
    CREATE USER ������ IDENTIFIED BY ��й�ȣ; --> ��й�ȣ�� ��ҹ��ڸ� ������
    GRANT ����(RESOURCE, CONNECT) TO ����;
    
*/
SELECT
    *
FROM
    role_sys_privs;
     
    
/*
    <TCL : Ʈ����� ���>
    - ������ ���̽��� ���� �������
    - �������� �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
     DML�� �Ѱ��� ������ �� Ʈ������� �������� �ʴ´ٸ� Ʈ������� ���� �����ش�.
                                    �����Ѵٸ� �ش� Ʈ����ǿ� ��� ó��
    COMMIT�ϱ� �������� ������׵��� �ϳ��� Ʈ����ǿ� ��´�.
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE  EX)ȯ�Ҹ��, ȯ�ҳ���, ȯ�һ�ǰ?
    
    COMMIT(Ʈ����� ���� ó�� �� Ȯ��)
    ROLLBACK(Ʈ����ǿ� �մ� �۾��� ���)
    SAVEPOINT(�ӽ�����)
    
    -COMMIT : �� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ���Ű�ڴٴ� �ǹ�
    -ROLLBACK : �� Ʈ����ǿ� ����մ� ������׵��� ����(���)�� �� ������ COMMIT�������� ���ư�
    -SAVEPOINT ����Ʈ�� : ���� ������ �ش�����Ʈ������ �ӽ��������ְٴ�.
    
    
*/
DROP TABLE emp_01;

CREATE TABLE emp_01
    AS
        ( SELECT
            emp_id,
            emp_name,
            dept_title
        FROM
                 employee
            JOIN department ON ( dept_code = dept_id )
        );

SELECT
    *
FROM
    emp_01;
    --����� 200, 201���� ��� ����
DELETE FROM emp_01
WHERE
    emp_id = 200
    OR emp_od = 201;

COMMIT;

ROLLBACK;--�̹� Ŀ���� �Ǿ��⿡ �ѹ��� �ǹ̰� ����.
SELECT
    *
FROM
    emp_01;
    
--------------------------------------------
DELETE FROM emp_01
WHERE
    emp_id IN ( 217, 216, 214 );

SELECT
    *
FROM
    emp_01;

SAVEPOINT sp;-- ��ҹ��� ���� ����

INSERT INTO emp_01 VALUES (
    801,
    '�踻��',
    '���������'
);

DELETE FROM emp_01
WHERE
    emp_id = 210;

SELECT
    *
FROM
    emp_01;

ROLLBACK TO sp;

COMMIT;

SELECT
    *
FROM
    emp_01;
-----------------------------------------------------------------
DELETE FROM EMP_01
WHERE EMP_ID = 210;

--DDL�� ����
CREATE TABLE TEST(
TID NUMBER
);

ROLLBACK;
SELECT * FROM EMP_01;
--DDL��(CREATE, ALTER, DROP)�� �����ϴ� ���� ���� Ʈ����ǿ� �ִ� ������׵��� ������ COMMIT�� �ȴ�.
--(���� DB �ݿ��ȴ�)
--��, DDL�� ���� �� ������׵��� �մٸ� ��Ȯ�ϰ� �Ƚ��ϰ� �����ض�.


    
    