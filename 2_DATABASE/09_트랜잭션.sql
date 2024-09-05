/*
    <DCL : 데이터 제어문>
    계정에 시스템 권한 또는 객체접근권한을 부여하거나 회수하는 구문
    
    > 시스템권한 : DB에 접근하는 권한, 객체를 생성할 수 있는 권한
    > 객체 접근 권한 : 특정 객체들을 조작할 수 있는 권한
    
    CREATE USER 계정명--시험볼때 무조건 나옴. 관리자 계정으로 만들어야함!
    CREATE USER 계정명 IDENTIFIED BY 비밀번호; --> 비밀번호는 대소문자를 구분함
    GRANT 권한(RESOURCE, CONNECT) TO 계정;
    
*/
SELECT
    *
FROM
    role_sys_privs;
     
    
/*
    <TCL : 트랜잭션 제어문>
    - 데이터 베이스의 논리적 연산단위
    - 데이터의 변경사항(DML)등을 하나의 트랜잭션에 묶어서 처리
     DML문 한개를 수행할 때 트랜잭션이 존재하지 않는다면 트랜잭션을 만들어서 묶어준다.
                                    존재한다면 해당 트랜잭션에 묶어서 처리
    COMMIT하기 전까지의 변경사항들을 하나의 트랜잭션에 담는다.
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE  EX)환불명단, 환불내역, 환불상품?
    
    COMMIT(트랜잭션 종료 처리 후 확정)
    ROLLBACK(트랜잭션에 잇는 작업을 취소)
    SAVEPOINT(임시저장)
    
    -COMMIT : 한 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영시키겠다는 의미
    -ROLLBACK : 한 트랜잭션에 담겨잇는 변경사항들을 삭제(취소)한 후 마지막 COMMIT시점으로 돌아감
    -SAVEPOINT 포인트명 : 현재 시점에 해당포인트명으로 임시저장해주겟다.
    
    
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
    --사번이 200, 201번인 사람 삭제
DELETE FROM emp_01
WHERE
    emp_id = 200
    OR emp_od = 201;

COMMIT;

ROLLBACK;--이미 커밋이 되었기에 롤백이 의미가 없다.
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

SAVEPOINT sp;-- 대소문자 구분 없음

INSERT INTO emp_01 VALUES (
    801,
    '김말똥',
    '기술지원부'
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

--DDL문 실행
CREATE TABLE TEST(
TID NUMBER
);

ROLLBACK;
SELECT * FROM EMP_01;
--DDL문(CREATE, ALTER, DROP)을 수행하는 순간 기존 트랜잭션에 있던 변경사항들은 무조건 COMMIT이 된다.
--(실제 DB 반영된다)
--즉, DDL문 수행 전 변경사항들이 잇다면 정확하게 픽스하고 진행해라.


    
    