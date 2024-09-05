/*
    * ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DELETE)�ϴ� ���
    ��, ���� �����Ͱ��� �ƴ� ��Ģ ��ü�� �����ϴ� ���
    
    ����Ŭ���� ��ü(����) : ���̺�, ��, ������
                        �ε���, ��Ű��, Ʈ����
                        ���ν���, �Լ�, ���Ǿ�, �����
                        
                        
    <CREATE>
    ��ü�� ���� �����ϴ� ����
    
*/

/*
    1. ���̺� ����
    - ���̺��̶� : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͵��� ���̺��� ���ؼ� �����
                (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
                
    [ǥ����]
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� (ũ��), 
        �÷��� �ڷ��� (ũ��), 
        �÷��� �ڷ���,--ũ��� ���� ���� 
              ...
    )

    * �ڷ���
    -���� : (CHAR(����Ʈ ũ��)|VARCHAR2(����Ʈ ũ��))--> �ݵ�� ũ�� ������ �������
            - CHAR : �ִ� 2000����Ʈ���� ���� ���� / ���� ����(������ ���ڼ��� �����Ͱ� ��� ���)
            - VARCHAR2 : �ִ� 4000����Ʈ���� ���� ���� / ��������(�� ������ �����Ͱ� ������ �𸣴� ���)
    - ����(NUMBER)
    - ��¥(DATE)
*/

--ȸ���� ���� �����͸� ������� ���̺� MEMBER����
CREATE TABLE member (
    mem_no   NUMBER,
    mem_id   VARCHAR2(20),
    mem_pwd  VARCHAR2(20),
    mem_name VARCHAR2(20),
    gender   CHAR(3),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE
);

SELECT
    *
FROM
    member;
--------------------------------------------------
/*
     2. �÷��� �ּ��ޱ�(�÷��� ���� ������ ����)
     
     [ǥ����]
     COMMENT ON COLUMN ���̺��. �÷��� IS '�ּ�����';
     -> �߸� �ۼ��� ���� �����ϸ� �ȴ�.
*/

COMMENT ON COLUMN member.mem_no IS
    'ȸ����ȣ';

COMMENT ON COLUMN member.mem_id IS
    'ȸ�����̵�';

COMMENT ON COLUMN member.mem_pwd IS
    'ȸ����й�ȣ';

COMMENT ON COLUMN member.mem_name IS
    'ȸ����';

COMMENT ON COLUMN member.gender IS
    '����(��/��)';

COMMENT ON COLUMN member.phone IS
    '��ȭ��ȣ';

COMMENT ON COLUMN member.email IS
    '�̸���';

COMMENT ON COLUMN member.mem_date IS
    'ȸ��������';


-- ���̺��� �����ϰ��� �� �� : DROP TABLE ���̺��;
DROP TABLE member;

-- INSERT INTO ���̺�� VALUES ();
- INSERT INTO ���̺�� VALUES ();


INSERT INTO member VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    '010-1111-2222',
    'AAAA@NAVER.COM',
    '24/08/12'
);

INSERT INTO member VALUES (
    1,
    'USER1',
    'PASS1',
    NULL,
    NULL,
    '010-1111-2222',
    'AAAA@NAVER.COM',
    '24/08/12'
);

/*
    <��������>
    - ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    
    
    ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
*/
/*
    * NOT NULLL
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, ���� NULL�� ������ �ȵǴ� ���)
    ����/���� �� NULL ���� ������� �ʵ��� ����
    
    ���������� �ο��ϴ� ����� ũ�� 2������ �մ�.(�÷��������, ���̺������)
    NOT NULL ���� ������ ������ �÷����� ���(�÷��� �ڿ� �ٷ� ���������� �����ִ°�)���θ� �����ϴ�.
    
*/

CREATE TABLE mem_notnull (
    mem_no   NUMBER NOT NULL,
    mem_id   VARCHAR2(20) NOT NULL,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE
);

INSERT INTO mem_notnull VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);

SELECT
    *
FROM
    mem_notnull;
    
    
INSERT INTO mem_notnull VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    NULL,
   NULL,
    NULL,
    NULL
);

INSERT INTO member VALUES (
    1,
    'USER1',
    'PASS1',
    NULL,
    NULL,
    '010-1111-2222',
    'AAAA@NAVER.COM',
    '24/08/12'
);

/*
    <��������>
    - ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    
    
    ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
*/
/*
    * NOT NULLL
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, ���� NULL�� ������ �ȵǴ� ���)
    ����/���� �� NULL ���� ������� �ʵ��� ����
    
    ���������� �ο��ϴ� ����� ũ�� 2������ �մ�.(�÷��������, ���̺������)
    NOT NULL ���� ������ ������ �÷����� ���(�÷��� �ڿ� �ٷ� ���������� �����ִ°�)���θ� �����ϴ�.
    
*/

CREATE TABLE mem_notnull (
    mem_no   NUMBER NOT NULL,
    mem_id   VARCHAR2(20) NOT NULL,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20)
notnull,
    gender CHAR(3),
    phone VARCHAR2(13),
    email VARCHAR2(50),
    mem_date DATE
);

INSERT INTO mem_notnull VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);


SELECT
    *
FROM
    mem_notnull;
    
    
INSERT INTO mem_notnull VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    NULL,
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_notnull VALUES (
    3,
    'USER3',
    'PASS3',
    'ȫ���',
    NULL,
    NULL,
    NULL,
    NULL
);

/*
�ش� �÷��� �ߺ��� ���� ������ �ȵ� ��� ����Ѵ٤�.
�÷� ���� �ߺ����� �����ϴ� ���������̴�
����/���� �� ������ �մ� �����Ͱ� �� �ߺ����� ���� ��� ������ �߻���Ų��.
*/

CREATE TABLE mem_UNIQUE (
    mem_no   NUMBER NOT NULL,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) not null, 
    gender CHAR(3),
    phone VARCHAR2(13), 
    email VARCHAR2(50),
     mem_date DATE
-- ���̺� ���� ��ĵ� �����ϴ� : mem_date DATE UNIQUE(mem_id)
 );
 DROP TABLE mem_unique;
INSERT INTO mem_unique VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
   
);

SELECT * FROM mem_unique;
/*
    * ���� ���� �ο��� ���� ���Ǹ���� �ο��ϴ� ���
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� (CONSTRAINT �������Ǹ�) ��������
    )
    >���̺������
    CREATE TABLE ���̺��
    
*/
DROP TABLE mem_unique;

CREATE TABLE mem_unique (
    mem_no   NUMBER
        CONSTRAINT memno_nt NOT NULL,
    mem_id   VARCHAR2(20) CONSTRAINT memID_NT NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE
);

INSERT INTO mem_unique VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
   
);

INSERT INTO mem_unique VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ���',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);

/*
    * CHECK(���ǽ�)
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� �ִ�.
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
    
*/
DROP TABLE mem_CHECK;

CREATE TABLE mem_check (
    mem_no   NUMBER NOT NULL,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE
   -- CHECK(GENDER IN('��', '��')
);
INSERT INTO mem_check VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ���',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);
INSERT INTO mem_check VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ���',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);
/*
    PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ��(ROW)�� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ��������(�ĺ��� ����)
    
    EX)ȸ����ȣ, �й�, ����, �μ��ڵ�, �����ڵ�, �ֺ��ȣ, �ֹ���ȣ, �ù������ȣ, �����ȣ....
    PRIMARY KEY  -> NOT NULL +  UNIQUE
    
    �����̺�� ���� �Ѱ��� ���� ����
    
*/

CREATE TABLE mem_RPI (
    mem_no   NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    mem_id VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender CHAR(3) CHECK ( gender IN ( '��', '��' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE
   -- CHECK(GENDER IN('��', '��')
);
INSERT INTO mem_rpi VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);

INSERT INTO mem_rpi VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ���',
    '��',
    NULL,
    NULL,
    NULL
);
--> �⺻Ű�� �ߺ����� �������� �� ��(UNIQUE �������� ����)

INSERT INTO mem_rpi VALUES (
    NULL,
    'USER1',
    'PASS1',
    'ȫ���',
    '��',
    NULL,
    NULL,
    NULL
);
--> �⺻Ű�� NULL�� �������� �� ��(NOT NULL �������� ����)
INSERT INTO mem_rpi VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    NULL
);
-----------------------------------------------------
CREATE TABLE mem_pri2 (
    mem_no   NUMBER,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '��', '��' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE,
    PRIMARY KEY ( mem_no,
                  mem_id )--����Ű
   -- CHECK(GENDER IN('��', '��')
);
-- ����Ű : �ΰ��� �÷��� ���ÿ� �ϳ��� PRIMARY KEY�� �����ϴ� ��
INSERT INTO mem_pri2 VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_pri2 VALUES (
    1,
    'USER2',
    'PASS3',
    'ȫ���',
    '��',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_pri2 VALUES (
    2,
    'USER3',
    'PASS3',
    'ȫ���',
    '��',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_pri2 VALUES (
    2,
    'USER3',
    'PASS4',
    'ȫ���',
    '��',
    NULL,
    NULL,
    NULL
);

--����Ű ��� ����(� ȸ���� � ��ǰ�� ���ߴ����� ���� �����͸� �����ϴ� ���̺�)
CREATE TABLE tb_like (
    mem_no       NUMBER,
    product_name VARCHAR2(10),
    like_date    DATE,
    PRIMARY KEY ( mem_no,
                  product_name )
);
--ȸ���� 2�� ����(1��, 2��)
--��ǰ�� 2��(A24, I14PRO)(�� ���̵�� ���� �ϳ��� ���ϱ�� �ѹ��� ����- �׷��� �ٽ� ������ ���������� �����)
INSERT INTO tb_like VALUES (
    1,
    'A24',
    sysdate
);

INSERT INTO tb_like VALUES (
    1,
    'I14PRO',
    sysdate
);

INSERT INTO tb_like VALUES (
    1,
    'A24',
    sysdate
);

SELECT
    *
FROM
    tb_like;
    
--ȸ�� ��޿� ���� �����͸� �����ϴ� ���̺�
CREATE TABLE mem_grade (
    grade_code NUMBER PRIMARY KEY,
    grade_name VARCHAR2(30) NOT NULL
);

INSERT INTO mem_grade VALUES (
    10,
    '�Ϲ�ȸ��'
);

INSERT INTO mem_grade VALUES (
    20,
    '���ȸ��'
);

INSERT INTO mem_grade VALUES (
    30,
    'Ư��ȸ��'
);
DROP TABLE mem;
CREATE TABLE mem (
    mem_no   NUMBER PRIMARY KEY,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '��', '��' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
GRADE_ID NUMBER
    
   
);
INSERT INTO mem VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    3,
    'USER3',
    'PASS3',
    '������',
    '��',
    NULL,
    NULL,
    30
);
INSERT INTO mem VALUES (
    4,
    'USER4',
    'PASS4',
    '�����',
    '��',
    NULL,
    NULL,
    40
);--��ȿ���� ���� ȸ����޹�ȣ�� ���������� INSERT�ǰ� �ִ�.
------------------------------------------------
/*
    FOREIGH KEY(�ܷ�Ű) ��������
    �ٸ����̺� �����ϴ� ���� ���;ߵǴ� Ư�� �÷��� �ο��ϴ� ��������
    -> �ٸ� ���̺��� �����Ѵٰ� ǥ��
    -> �ַ� FOREIGN KEY ������������ ���� ���̺� ���谡 �����ȴ�.
    
    >�÷��������
    �÷��� �ڷ��� REFERENCES ������ ���̺��[������ �÷���]
    
    >���̺��� ���
    FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[������ �÷���]
    
    --������ �÷��� ������ ������ ���̺��� PRIMARY KEY�� ������ �÷��� ��Ī�ȴ�.
    
*/
DROP TABLE mem;

CREATE TABLE mem (
    mem_no   NUMBER PRIMARY KEY,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '��', '��' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    grade_id NUMBER
        REFERENCES mem_grade ( grade_code )
        --FOREIGN KEY(GRADE_ID) REFERNCES MEM_GRADE(GRADE_CODE);
);INSERT INTO mem VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    3,
    'USER3',
    'PASS3',
    '������',
    '��',
    NULL,
    NULL,
    30
);
INSERT INTO mem VALUES (
    4,
    'USER4',
    'PASS4',
    '�����',
    '��',
    NULL,
    NULL,
    40
);
SELECT *
FROM MEM;

--MEM_GRADE(�θ����̺�)- 1 >- --------- < N --MEM(�ڽ����̺�)
--1:N�� ����(1���� �θ����̺� N���� �ڽ����̺�)

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- MEM���̺��� 10�̶�� ���� ����ϰ� �ֱ� ������ ������ �ȵ�.
/*
    �ڽ� ���̺� ������ �ܷ�Ű �������� �ο��� �� �����ɼ� ��������
    * ���� �ɼ� : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ��� �� ���ΰ�?
    - ON DELETE RESTRICTED(�⺻��) : ���� ���� �ɼ�, �ڽĵ����ͷκ��� ���̴� �θ����ʹ� ������ �ƿ� �ȵ�
    - ON DELETE SET NULL : �θ����� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽĵ������� ���� NULL�� ����
    - ON DELETE CASCADE : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ���� �����ض�.
    
*/
DROP TABLE MEM;
CREATE TABLE mem (
    mem_no   NUMBER PRIMARY KEY,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '��', '��' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    grade_id NUMBER,
    FOREIGN KEY ( grade_id )
        REFERENCES mem_grade ( grade_code )
            ON DELETE CASCADE
);
INSERT INTO mem VALUES (
    1,
    'USER1',
    'PASS1',
    'ȫ�浿',
    '��',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    10
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    'ȫ���',
    '��',
    NULL,
    NULL,
    10
);

INSERT INTO mem VALUES (
    3,
    'USER3',
    'PASS3',
    '������',
    '��',
    NULL,
    NULL,
    30
);

DELETE FROM mem_grade
WHERE
    grade_code = 30;
    
-----------------------------------------------------------------
/*
    <DEFAULT �⺻��> * ���������� �ƴϴ�.
    �÷��� �������� �ʰ� INSERT �� NULL�� �ƴ� �⺻���� INSERT�ϰ��� �Ѵ�.
    �̶� ������ �� �� �ִ� ��
    
    �÷���  �ڷ��� DEFAULT �⺻��
    
*/

CREATE TABLE member (
    mem_no      NUMBER PRIMARY KEY,
    mem_name    VARCHAR2(20) NOT NULL,
    mam_age     NUMBER,
    hobby       VARCHAR2(20) DEFAULT '����',
    enroll_date DATE DEFAULT sysdate
);
-- INSERT INTO (���̺��) VALUES (��1, ��2,....)
INSERT INTO member VALUES (
    1,
    '������',
    20,
    '�',
    '20/01/01'
);

INSERT INTO member VALUES (
    2,
    '����',
    20,
    NULL,
    NULL
);

INSERT INTO member VALUES (
    3,
    '������',
    20, DEFAULT, DEFAULT
);

-- INSERT INTO ���̺��(�÷�1, �÷�2...) VALUES(�÷�1��, �÷�2��)
INSERT INTO member (
    mem_no,
    mem_name
) VALUES (
    4,
    '�̰���'
);

SELECT
    *
FROM
    member;
--> ���õ��� ���� �÷����� �⺻������ NULL�� ��
--> ��, �ش� �÷��� DEFAULT���� �ο��Ǿ� ���� ��� NULL�� �ƴ� DEFAULT���� ��

--���̺��� ������ �� �ִ�. ���⼭���ʹ� KH���� �̿�
CREATE TABLE employee_copy
    AS
        ( SELECT
            *
        FROM
            employee
        );

----------------------------------------------------------
/*
    ���̺��� �� ������ �Ŀ� �ڴʰ� ���������� �߰��ϴ� ���
    ALTER TABLE ���̺�� ������ ����
    
    
    - PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FORIEGN KEY : ALTER TABLE ���̺�� ADD FORIEGN KEY(�÷���) REFERENCES ������ ���̺��[�÷���];
    - UNIQUE : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - NOT NULL : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
    
*/
ALTER TABLE employee
    ADD FOREIGN KEY ( dept_code )
        REFERENCES department ( dept_id );

ALTER TABLE employee MODIFY
    emp_no NOT NULL;


---------�ǽ�����-------------
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�
DROP TABLE TB_RENT;

DROP TABLE tb_member;

DROP TABLE tb_book;

DROP TABLE tb_publisher;

/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/

CREATE TABLE tb_publisher (
    pub_no   NUMBER
        CONSTRAINT publisher_pk PRIMARY KEY,
    pub_name VARCHAR2(50)
        CONSTRAINT publisher_nn NOT NULL,
    phone    VARCHAR2(13)
);

COMMENT ON COLUMN tb_publisher.pub_no IS
    '���ǻ� ��ȣ';

COMMENT ON COLUMN tb_publisher.pub_name IS
    '���ǻ��';

COMMENT ON COLUMN tb_publisher.phone IS
    '���ǻ� ��ȭ��ȣ';

--���� 3������ ����
INSERT INTO tb_publisher VALUES (
    1,
    'KH',
    '010-1234-5678'
);

INSERT INTO tb_publisher VALUES (
    2,
    '���',
    '010-3333-5678'
);

INSERT INTO tb_publisher VALUES (
    3,
    '��Ű�鼭',
    '010-2222-5678'
);

SELECT
    *
FROM
    tb_publisher;

/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/
CREATE TABLE tb_book (
    bk_no     NUMBER
        CONSTRAINT book_pk PRIMARY KEY,
    bk_title  VARCHAR2(50)
        CONSTRAINT book_nn NOT NULL,
    bk_author VARCHAR2(20)
        CONSTRAINT book_nn2 NOT NULL,
    bk_price  NUMBER,
    bk_pub_no NUMBER,
    CONSTRAINT book_fk FOREIGN KEY ( bk_pub_no )
        REFERENCES tb_publisher ( pub_no )
            ON DELETE CASCADE
);


--5�� ������ ���� ������ �߰��ϱ�
INSERT INTO tb_book VALUES (
    100,
    '�ڹ�������',
    '������',
    1000000,
    1
);

INSERT INTO tb_book VALUES (
    101,
    '�ڹ�������2',
    '������',
    1000000,
    1
);

INSERT INTO tb_book VALUES (
    102,
    '�ڹ�������3',
    '������',
    2000000,
    2
);

INSERT INTO tb_book VALUES (
    103,
    '�ڹ�������4',
    '������',
    3000000,
    3
);

INSERT INTO tb_book VALUES (
    104,
    '�ڹ�������5',
    '������',
    4000000,
    3
);

SELECT
    *
FROM
    tb_book;

/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/

CREATE TABLE tb_member (
    member_no   NUMBER
        CONSTRAINT member_pk PRIMARY KEY,
    member_id   VARCHAR2(20)
        CONSTRAINT member_uq_id UNIQUE
    NOT NULL,
    member_pwd  VARCHAR2(20)
        CONSTRAINT member_nn_pwd NOT NULL,
    member_name VARCHAR2(20)
        CONSTRAINT member_nn_name NOT NULL,
    gender      CHAR(1)
        CONSTRAINT member_ck_gen CHECK ( gender IN ( 'M', 'F' ) ),
    address     VARCHAR2(100),
    phone       VARCHAR2(13),
    status      CHAR(1) DEFAULT 'N'
        CONSTRAINT member_ck_sta CHECK ( status IN ( 'N', 'Y' ) ),
    enroll_date DATE DEFAULT sysdate
        CONSTRAINT member_nn_en NOT NULL
);

--5�� ������ ���� ������ �߰��ϱ�
INSERT INTO tb_member VALUES (
    200,
    'USER01',
    'PASS01',
    '������',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    201,
    'USER02',
    'PASS02',
    '������',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    202,
    'USER03',
    'PASS03',
    '������',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    203,
    'USER04',
    'PASS04',
    '������',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    204,
    'USER05',
    'PASS05',
    '������',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/
CREATE TABLE tb_rent (
    rent_no      NUMBER
        CONSTRAINT rent_pk PRIMARY KEY,
    rent_mem_no  NUMBER,
    rent_book_no NUMBER,
    rent_date    DATE DEFAULT sysdate,
    CONSTRAINT rent_fk_mem FOREIGN KEY ( rent_mem_no )
        REFERENCES tb_member
            ON DELETE SET NULL,
    CONSTRAINT rent_fk_book FOREIGN KEY ( rent_book_no )
        REFERENCES tb_book
            ON DELETE SET NULL
);

--3�� ������ ���� ������ �߰��ϱ�
INSERT INTO tb_rent VALUES (
    300,
    200,
    100, DEFAULT
);

INSERT INTO tb_rent VALUES (
    301,
    201,
    101, DEFAULT
);

INSERT INTO tb_rent VALUES (
    302,
    202,
    102, DEFAULT
);

SELECT
    *
FROM
         tb_rent
    JOIN tb_member ON ( rent_mem_no = member_no )
    JOIN tb_book ON ( rent_book_no = bk_no );
    

    
    