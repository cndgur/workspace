/*
    <������ SEQUENCE>
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    �������� ���������� �����ϰ� ������Ű�鼭 �������ش�.
    
    EX)ȸ����ȣ, �����ȣ, �Խñ۹�ȣ....
*/

/*
    1. ������ ��ü ����
    
    [ǥ����]
    CREATE SEQUENCE ��������
    [START WITH  ���ۼ���]-> ó�� �߻���ų ���۰� ����(�⺻�� 1)
    [INCREMENT BY ����]-> � ������ų ����(�⺻��1)
    [MAXVALUE ����]-> �ִ밪����(�⺻�� �ſ� ũ��)
    [MINVALUE ����]-> �ּҰ� ����(�⺻���� 1)
    [CYCLE | NOCYCLE] -> �� ��ȯ����(�⺻���� NOCYCLE)
    [CACHE|NOCACHE] -> ĳ�ø޸� �Ҵ�(�⺻�� CACHE 20)
    * ĳ�� �޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                    �Ź� ȣ��� ������ ���ο� ��ȣ�� �����ϴ°� �ƴ϶�
                    ĳ�ø޸� ������ �̸� ������ ������ ������ �� �� �ִ�.(�ӵ��� ��������)
                    
    ���̺�� : TB_
    ��� : VW_
    ������ : SEQ_
    Ʈ���� : TRG_
                    
*/

CREATE SEQUENCE seq_test;

--[����] ���� ������ ������ ���������� ������ ���� ���� ��
SELECT
    *
FROM
    user_sequences;

DROP SEQUENCE seq_empno;

CREATE SEQUENCE seq_empno START WITH 300 INCREMENT BY 5 MAXVALUE 310 NOCYCLE NOCACHE;



/*
    2. ������ ���
    ��������.CURRVAL : ���� ������ ��(���������� ������ NEXTVAL�� ���ప)
    ��������.NEXTVAL : ���������� ������ ���� �������� �߻��� ��
                        ���� ������ ���� INCREMENT BY �� ��ŭ ������ ��


*/
SELECT
    *
FROM
    user_sequences;

SELECT
    seq_empno.CURRVAL
FROM
    dual;--���� : CURRVAL�� �׳� ���簪�� �ƴ϶� ����������NEXTVAL�� ���� �������� ���̴�.

SELECT
    seq_empno.NEXTVAL
FROM
    dual;

SELECT
    seq_empno.NEXTVAL
FROM
    dual;

SELECT
    seq_empno.NEXTVAL
FROM
    dual;--�ִ� 310�� �Ѿ ���� �߻�

/*
    3. �������� ���� ����
    ALTER SEQUENCE ������
    [INCREMENT BY ����]
    [MAXVALUES ����]
    [MINVALUE ����]
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈũ�� | NOCACHE]
    
    * START WITH�� ����Ұ�
    
*/

ALTER SEQUENCE seq_empno INCREMENT BY 10 MAXVALUE 400;

SELECT
    seq_empno.NEXTVAL
FROM
    dual;
--������ ����
DROP SEQUENCE seq_empno;
-------------------------------------------------------------------------------
--�����ȣ�� ����� ������

CREATE SEQUENCE SEQ_EID
START WITH 400

nocache;

INSERT INTO employee (
    emp_id,
    emp_name,
    emp_no,
    job_code,
    hire_date
) VALUES (
    seq_eid.NEXTVAL,
    '�踻��',
    '111111-2111111',
    'J6',
    sysdate
);
