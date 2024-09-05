/*
    * 데이터 정의 언어
    오라클에서 제공하는 객체를 새로 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DELETE)하는 언어
    즉, 실제 데이터값이 아닌 규칙 자체를 정의하는 언어
    
    오라클에서 객체(구조) : 테이블, 뷰, 시퀀스
                        인덱스, 패키지, 트리거
                        프로시져, 함수, 동의어, 사용자
                        
                        
    <CREATE>
    객체를 새로 생성하는 구문
    
*/

/*
    1. 테이블 생성
    - 테이블이란 : 행과 열로 구성되는 가장 기본적인 데이터베이스 객체
                모든 데이터들은 테이블을 통해서 저장됨
                (DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것)
                
    [표현식]
    CREATE TABLE 테이블명(
        컬럼명 자료형 (크기), 
        컬럼명 자료형 (크기), 
        컬럼명 자료형,--크기는 생략 가능 
              ...
    )

    * 자료형
    -문자 : (CHAR(바이트 크기)|VARCHAR2(바이트 크기))--> 반드시 크기 지정을 해줘야함
            - CHAR : 최대 2000바이트까지 지정 가능 / 고정 길이(고정된 글자수의 데이터가 담길 경우)
            - VARCHAR2 : 최대 4000바이트까지 지정 가능 / 가변길이(몇 글자의 데이터가 들어올지 모르는 경우)
    - 숫자(NUMBER)
    - 날짜(DATE)
*/

--회원에 대한 데이터를 담기위한 테이블 MEMBER생성
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
     2. 컬럼에 주석달기(컬럼에 대한 간단한 설명)
     
     [표현법]
     COMMENT ON COLUMN 테이블명. 컬럼명 IS '주석내용';
     -> 잘못 작성시 새로 수정하면 된다.
*/

COMMENT ON COLUMN member.mem_no IS
    '회원번호';

COMMENT ON COLUMN member.mem_id IS
    '회원아이디';

COMMENT ON COLUMN member.mem_pwd IS
    '회원비밀번호';

COMMENT ON COLUMN member.mem_name IS
    '회원명';

COMMENT ON COLUMN member.gender IS
    '성병(남/여)';

COMMENT ON COLUMN member.phone IS
    '전화번호';

COMMENT ON COLUMN member.email IS
    '이메일';

COMMENT ON COLUMN member.mem_date IS
    '회원가입일';


-- 테이블을 삭제하고자 할 때 : DROP TABLE 테이블명;
DROP TABLE member;

-- INSERT INTO 테이블명 VALUES ();
- INSERT INTO 테이블명 VALUES ();


INSERT INTO member VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길동',
    '남',
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
    <제약조건>
    - 원하는 데이터값(유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다.
    
    
    종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
*/
/*
    * NOT NULLL
    해당 컬럼에 반드시 값이 존재해야만 할 경우(즉, 절대 NULL이 들어오면 안되는 경우)
    삽입/수정 시 NULL 값을 허용하지 않도록 제한
    
    제약조건을 부여하는 방식은 크게 2가지가 잇다.(컬럼레벨방식, 테이블레벨방식)
    NOT NULL 제약 조건은 무조건 컬럼레벨 방식(컬럼명 뒤에 바로 제약조건을 적어주는것)으로만 가능하다.
    
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
    '홍길동',
    '남',
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
    '홍길순',
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
    <제약조건>
    - 원하는 데이터값(유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다.
    
    
    종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
*/
/*
    * NOT NULLL
    해당 컬럼에 반드시 값이 존재해야만 할 경우(즉, 절대 NULL이 들어오면 안되는 경우)
    삽입/수정 시 NULL 값을 허용하지 않도록 제한
    
    제약조건을 부여하는 방식은 크게 2가지가 잇다.(컬럼레벨방식, 테이블레벨방식)
    NOT NULL 제약 조건은 무조건 컬럼레벨 방식(컬럼명 뒤에 바로 제약조건을 적어주는것)으로만 가능하다.
    
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
    '홍길동',
    '남',
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
    '홍길순',
    NULL,
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_notnull VALUES (
    3,
    'USER3',
    'PASS3',
    '홍길삼',
    NULL,
    NULL,
    NULL,
    NULL
);

/*
해당 컬럼에 중복된 값이 들어가서는 안될 경우 사용한다ㅣ.
컬럼 값에 중복값을 제한하는 제약조건이다
삽입/수정 시 기존에 잇는 데이터값 중 중복값이 있을 경우 오류를 발생시킨다.
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
-- 테이블 레벨 방식도 가능하다 : mem_date DATE UNIQUE(mem_id)
 );
 DROP TABLE mem_unique;
INSERT INTO mem_unique VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길동',
    '남',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
   
);

SELECT * FROM mem_unique;
/*
    * 제약 조건 부여시 제약 조건명까지 부여하는 방법
    > 컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 (CONSTRAINT 제약조건명) 제약조건
    )
    >테이블레벨방식
    CREATE TABLE 테이블명
    
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
    '홍길동',
    '남',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
   
);

INSERT INTO mem_unique VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길순',
    '여',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);

/*
    * CHECK(조건식)
    해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있다.
    해당 조건에 만족하는 데이터값만 담길 수 있음
    
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
   -- CHECK(GENDER IN('남', '여')
);
INSERT INTO mem_check VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길순',
    '여',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);
INSERT INTO mem_check VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길순',
    '여',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);
/*
    PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행(ROW)을 식별하기 위해 사용될 컬럼에 부여하는 제약조건(식별자 역할)
    
    EX)회원번호, 학번, 군번, 부서코드, 직급코드, 주빈번호, 주문번호, 택배운송장번호, 예약번호....
    PRIMARY KEY  -> NOT NULL +  UNIQUE
    
    한테이블당 오직 한개만 설정 가능
    
*/

CREATE TABLE mem_RPI (
    mem_no   NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    mem_id VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender CHAR(3) CHECK ( gender IN ( '남', '여' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE
   -- CHECK(GENDER IN('남', '여')
);
INSERT INTO mem_rpi VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길동',
    '남',
    '010-1111-2222',
    'ONE@NAVER.COM',
    '24/08/12'
);

INSERT INTO mem_rpi VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길순',
    '여',
    NULL,
    NULL,
    NULL
);
--> 기본키에 중복값을 담으려고 할 때(UNIQUE 제약조건 위반)

INSERT INTO mem_rpi VALUES (
    NULL,
    'USER1',
    'PASS1',
    '홍길순',
    '여',
    NULL,
    NULL,
    NULL
);
--> 기본키에 NULL을 담으려고 할 때(NOT NULL 제약조건 위배)
INSERT INTO mem_rpi VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '여',
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
    gender   CHAR(3) CHECK ( gender IN ( '남', '여' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    mem_date DATE,
    PRIMARY KEY ( mem_no,
                  mem_id )--복합키
   -- CHECK(GENDER IN('남', '여')
);
-- 복합키 : 두개의 컬럼을 동시에 하나의 PRIMARY KEY로 지정하는 것
INSERT INTO mem_pri2 VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길동',
    '남',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_pri2 VALUES (
    1,
    'USER2',
    'PASS3',
    '홍길순',
    '남',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_pri2 VALUES (
    2,
    'USER3',
    'PASS3',
    '홍길삼',
    '여',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem_pri2 VALUES (
    2,
    'USER3',
    'PASS4',
    '홍길사',
    '나',
    NULL,
    NULL,
    NULL
);

--복합키 사용 예시(어떤 회원이 어떤 상품을 찜했는지에 대한 데이터를 보관하는 테이블)
CREATE TABLE tb_like (
    mem_no       NUMBER,
    product_name VARCHAR2(10),
    like_date    DATE,
    PRIMARY KEY ( mem_no,
                  product_name )
);
--회원은 2명 존재(1번, 2번)
--상품은 2개(A24, I14PRO)(한 아이디당 물건 하나에 찜하기는 한번만 가능- 그래얃 다시 누르면 삭제원리가 적용됨)
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
    
--회원 등급에 대한 데이터를 보관하는 테이블
CREATE TABLE mem_grade (
    grade_code NUMBER PRIMARY KEY,
    grade_name VARCHAR2(30) NOT NULL
);

INSERT INTO mem_grade VALUES (
    10,
    '일반회원'
);

INSERT INTO mem_grade VALUES (
    20,
    '우수회원'
);

INSERT INTO mem_grade VALUES (
    30,
    '특별회원'
);
DROP TABLE mem;
CREATE TABLE mem (
    mem_no   NUMBER PRIMARY KEY,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '남', '여' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
GRADE_ID NUMBER
    
   
);
INSERT INTO mem VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길동',
    '여',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '남',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '남',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    3,
    'USER3',
    'PASS3',
    '최지원',
    '남',
    NULL,
    NULL,
    30
);
INSERT INTO mem VALUES (
    4,
    'USER4',
    'PASS4',
    '김수민',
    '여',
    NULL,
    NULL,
    40
);--유효하지 않은 회원등급번호가 정상적으로 INSERT되고 있다.
------------------------------------------------
/*
    FOREIGH KEY(외래키) 제약조건
    다른테이블에 존재하는 값만 들어와야되는 특정 컬럼에 부여하는 제약조건
    -> 다른 테이블을 참조한다고 표현
    -> 주로 FOREIGN KEY 제약조건으로 인해 테이블간 관계가 형성된다.
    
    >컬럼레벨방식
    컬럼명 자료형 REFERENCES 참조할 테이블명[참조할 컬럼명]
    
    >테이블레벨 방식
    FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[참조할 컬럼명]
    
    --참조할 컬럼명 생략시 참조할 테이블의 PRIMARY KEY로 지정된 컬럼이 매칭된다.
    
*/
DROP TABLE mem;

CREATE TABLE mem (
    mem_no   NUMBER PRIMARY KEY,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '남', '여' ) ),
    phone    VARCHAR2(13),
    email    VARCHAR2(50),
    grade_id NUMBER
        REFERENCES mem_grade ( grade_code )
        --FOREIGN KEY(GRADE_ID) REFERNCES MEM_GRADE(GRADE_CODE);
);INSERT INTO mem VALUES (
    1,
    'USER1',
    'PASS1',
    '홍길동',
    '여',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '남',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '남',
    NULL,
    NULL,
    10
);
INSERT INTO mem VALUES (
    3,
    'USER3',
    'PASS3',
    '최지원',
    '남',
    NULL,
    NULL,
    30
);
INSERT INTO mem VALUES (
    4,
    'USER4',
    'PASS4',
    '김수민',
    '여',
    NULL,
    NULL,
    40
);
SELECT *
FROM MEM;

--MEM_GRADE(부모테이블)- 1 >- --------- < N --MEM(자식테이블)
--1:N의 관계(1쪽이 부모테이블 N쪽이 자식테이블)

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- MEM테이블에서 10이라는 값을 사용하고 있기 때문에 삭제가 안됨.
/*
    자식 테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    * 삭제 옵션 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블의 값을 어떻게 할 것인가?
    - ON DELETE RESTRICTED(기본값) : 삭제 제한 옵션, 자식데이터로부터 쓰이는 부모데이터는 삭제가 아예 안됨
    - ON DELETE SET NULL : 부모데이터 삭제 시 해당 데이터를 사용하고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 사용하고 있는 자식데이터도 같이 전부 삭제해라.
    
*/
DROP TABLE MEM;
CREATE TABLE mem (
    mem_no   NUMBER PRIMARY KEY,
    mem_id   VARCHAR2(20) NOT NULL UNIQUE,
    mem_pwd  VARCHAR2(20) NOT NULL,
    mem_name VARCHAR2(20) NOT NULL,
    gender   CHAR(3) CHECK ( gender IN ( '남', '여' ) ),
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
    '홍길동',
    '여',
    NULL,
    NULL,
    NULL
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '남',
    NULL,
    NULL,
    10
);

INSERT INTO mem VALUES (
    2,
    'USER2',
    'PASS2',
    '홍길순',
    '남',
    NULL,
    NULL,
    10
);

INSERT INTO mem VALUES (
    3,
    'USER3',
    'PASS3',
    '최지원',
    '남',
    NULL,
    NULL,
    30
);

DELETE FROM mem_grade
WHERE
    grade_code = 30;
    
-----------------------------------------------------------------
/*
    <DEFAULT 기본값> * 제약조건은 아니다.
    컬럼을 선정하지 않고 INSERT 시 NULL이 아닌 기본값을 INSERT하고자 한다.
    이때 세팅해 둘 수 있는 값
    
    컬럼명  자료형 DEFAULT 기본값
    
*/

CREATE TABLE member (
    mem_no      NUMBER PRIMARY KEY,
    mem_name    VARCHAR2(20) NOT NULL,
    mam_age     NUMBER,
    hobby       VARCHAR2(20) DEFAULT '없음',
    enroll_date DATE DEFAULT sysdate
);
-- INSERT INTO (테이블명) VALUES (값1, 값2,....)
INSERT INTO member VALUES (
    1,
    '빵빵이',
    20,
    '운동',
    '20/01/01'
);

INSERT INTO member VALUES (
    2,
    '옥자',
    20,
    NULL,
    NULL
);

INSERT INTO member VALUES (
    3,
    '최지원',
    20, DEFAULT, DEFAULT
);

-- INSERT INTO 테이블명(컬럼1, 컬럼2...) VALUES(컬럼1값, 컬럼2값)
INSERT INTO member (
    mem_no,
    mem_name
) VALUES (
    4,
    '이강인'
);

SELECT
    *
FROM
    member;
--> 선택되지 않은 컬럼에는 기본적으로 NULL이 들어감
--> 단, 해당 컬럼에 DEFAULT값이 부여되어 있을 경우 NULL이 아닌 DEFAULT값이 들어감

--테이블을 복제할 수 있다. 여기서부터는 KH계정 이용
CREATE TABLE employee_copy
    AS
        ( SELECT
            *
        FROM
            employee
        );

----------------------------------------------------------
/*
    테이블이 다 생성된 후에 뒤늦게 제약조건을 추가하는 방법
    ALTER TABLE 테이블명 변경할 내용
    
    
    - PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FORIEGN KEY : ALTER TABLE 테이블명 ADD FORIEGN KEY(컬럼명) REFERENCES 참조할 테이블명[컬럼명];
    - UNIQUE : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식);
    - NOT NULL : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;
    
*/
ALTER TABLE employee
    ADD FOREIGN KEY ( dept_code )
        REFERENCES department ( dept_id );

ALTER TABLE employee MODIFY
    emp_no NOT NULL;


---------실습문제-------------
--도서관리 프로그램을 만들기 위한 테이블들 만들기--
--이때, 제약조건에 이름을 부여할 것
--   각 컬럼에 주석달기
DROP TABLE TB_RENT;

DROP TABLE tb_member;

DROP TABLE tb_book;

DROP TABLE tb_publisher;

/*
    1. 출판사들에 대한 데이터를 담기위한 출판사 테이블(TB_PUBLISHER)
    컬럼 : PUB_NO(출판사 번호) - 기본키(PUBLISHER_PK)
          PUB_NAME(출판사명) -- NOT NULL(PUBLISHER_NN)
          PHONE(출판사전화번호) -- 제약조건없음
*/

CREATE TABLE tb_publisher (
    pub_no   NUMBER
        CONSTRAINT publisher_pk PRIMARY KEY,
    pub_name VARCHAR2(50)
        CONSTRAINT publisher_nn NOT NULL,
    phone    VARCHAR2(13)
);

COMMENT ON COLUMN tb_publisher.pub_no IS
    '출판사 번호';

COMMENT ON COLUMN tb_publisher.pub_name IS
    '출판사명';

COMMENT ON COLUMN tb_publisher.phone IS
    '출판사 전화번호';

--샘플 3개정도 생성
INSERT INTO tb_publisher VALUES (
    1,
    'KH',
    '010-1234-5678'
);

INSERT INTO tb_publisher VALUES (
    2,
    '길벗',
    '010-3333-5678'
);

INSERT INTO tb_publisher VALUES (
    3,
    '위키백서',
    '010-2222-5678'
);

SELECT
    *
FROM
    tb_publisher;

/*
    2. 도서들에 대한 데이터를 담기위한 도서 테이블(TB_BOOK)
    컬럼 : BK_NO(도서번호)--기본키(BOOK_PK)
          BK_TITLE(도서명)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(저자명)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(가격)-- 제약조건없음
          BK_PUB_NO(출판사 번호)--외래키(BOOK_FK)(TB_PUBLISHER테이블을 참조)
                                이때 참조하고 있는 부모데이터 삭제시 자식데이터도 삭제 되도록 옵션지정
                                
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


--5개 정도의 샘플 데이터 추가하기
INSERT INTO tb_book VALUES (
    100,
    '자바정복기',
    '최지원',
    1000000,
    1
);

INSERT INTO tb_book VALUES (
    101,
    '자바정복기2',
    '최지원',
    1000000,
    1
);

INSERT INTO tb_book VALUES (
    102,
    '자바정복기3',
    '최지원',
    2000000,
    2
);

INSERT INTO tb_book VALUES (
    103,
    '자바정복기4',
    '최지원',
    3000000,
    3
);

INSERT INTO tb_book VALUES (
    104,
    '자바정복기5',
    '최지원',
    4000000,
    3
);

SELECT
    *
FROM
    tb_book;

/*
    3. 회원에 대한 데이터를 담기위한 회원 테이블(TB_MEMBER)
    컬럼명 : MEMBER_NO(회원번호) -- 기본키(MEMBER_PK)
            MEMBER_ID(아이디) -- 중복금지(MEMBER_UQ_ID)
            MEMBER_PWD(비밀번호) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(회원명) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(성별) -- M또는 F로 입력되도록 제한(MEMBER_CK_GEN)
            ADDRESS(주소) -- 제약조건없음
            PHONE(연락처)-- 제약조건없음
            STATUS(탈퇴여부) -- 기본값을 N으로 지정, 그리고 N또는 Y만 입력되도록 제약조건 설정(MEMBER_CK_STA)
            ENROLL_DATE(가입일) -- 기본값으로 SYSDATE, NOT NULL 제약조건(MEMBER_NN_EN)
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

--5개 정도의 샘플 데이터 추가하기
INSERT INTO tb_member VALUES (
    200,
    'USER01',
    'PASS01',
    '최지원',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    201,
    'USER02',
    'PASS02',
    '최지원',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    202,
    'USER03',
    'PASS03',
    '최지원',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    203,
    'USER04',
    'PASS04',
    '최지원',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

INSERT INTO tb_member VALUES (
    204,
    'USER05',
    'PASS05',
    '최지원',
    'M',
    NULL,
    NULL, DEFAULT, DEFAULT
);

/*
    4.어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블(TB_RENT)
    컬럼명 : RENT_NO(대여번호)-- 기본키(RENT_PK)
            RENT_MEM_NO(대여회원번호)-- 외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
                                        이때 부모 데이터 삭제시 자식데이터 값이 NULL이 되도록 지정
            RENT_BOOK_NO(대여도서번호)-- 외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
                                        이때 부모 데이터 삭제시 자식데이터 값이 NULL이 되도록 지정
            RENT_DATE(대여일) -- 기본값 SYSDATE
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

--3개 정도의 샘플 데이터 추가하기
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
    

    
    