/*
        DQL(QUERY 데이터 정의어) : SELECT
        DML(MANIPULATION 데이터 조작어) : INSERT, UPDATE, DELETE
        DDL(DEFINITION 데이터 정의어) : CREATE, ALTER,DROP
        DCL(CONTROL 데이터 제어어) : GRANT, REVOKE
        TCL(TRANSCATION 트랜잭션 제어어) : COMMIT, ROLLBACK
        
        
        <DML>
        데이터 조작언어
        테이블 값을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 구문
    */
    
    /*
    1. INSERT
    테이블에 새로운 행을 추가하는 구문
    
    [표현식]
    1) INSERT INO 테이블명 VALUES(값, 값, 값....)
    테이블의 모든 컬럼에 대한 값을 직접 제시해서 한 행을 INSERT하고자 할 때
    컬럼의 순번을 지켜서 VALUES에 값을 나열해야함
    
    부족하게 값을 제시할 경우, 값을 더 많이 제시한 경우 => 에러
    
    */
SELECT
    *
FROM
    employee;

INSERT INTO employee VALUES (
    900,
    '이소근',
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
    2) INSERT INTO 테이블명(컬럼, 컬럼, 컬럼....)VLAUES (값, 값, 값....)
    테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
    그래도 한 행 단위로 추가되기 때문에 선택안된 컬럼은 기본적으로 NULL이 들어감
    => NOT NULL 제약조건이 걸려잇는 컬럼은 반드시 직접 값을 넣어줘야 한다.
    단, 기본값이 지정되어 있으면 NULL이 아닌 기본값이 들어감
    */

INSERT INTO employee (
    emp_id,
    emp_name,
    emp_no,
    job_code,
    hire_date
) VALUES (
    901,
    '최지원',
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
    3) INSERT INTO 테이블명(서브쿼리);
    VALUES에 직접 값을 명시하는 것 대신 서브쿼리로 조회된 값을 통채로 INSERT 가능
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
    emp_01;--위의 서브쿼리의 결과값이 전부 INSERT되었다.
    
    
-------------------------------------------------------------------------

/*
    2. INSERT ALL
    두 개 이상의 테이블에 각각 INSERT할 때
    이 때 사용되는 서브쿼리가 동일한 경우
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
            1 = 0-- 구조만 복사!! 값은 복사되지 않는다.
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
        
        
-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번을 조회
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
    [표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼, 컬럼, 컬럼....)
    INTO 테이블명2 VALUES(컬럼, 컬럼, 컬럼....)
    서브쿼리;
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
    테이블에 기록되어 있는 기존의 데이터를 수정하는 구문
    
    [표현식]
    UPDATE 테이블명
    SET 컬럼 = '값'
        컬럼 = '값'
        ...
    [WHERE 조건] -> 생략시 전체 모든 행의 데이터가 변경된다.
    
    
    * 업데이트 시에도 제약 조건 잘 확인해야한다.
    
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

--D9부서의 부서명을 '전략지획팀으로 변경'
UPDATE dept_table
SET
    dept_title = '전략기획팀'
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
-- EMP_SALARY 테이블에서 노옹철 사원의 급여를 100만원으로 변경
UPDATE emp_salary
SET
    salary = '1000000'
WHERE
    emp_name = '노옹철';

SELECT
    *
FROM
    emp_salary;
-- 선동일 사원의 급여를 700만원, 보너스를 0.2로 변경
UPDATE emp_salary
SET
    salary = '7000000',
    bonus = '0.2'
WHERE
    emp_name = '선동일';

SELECT
    *
FROM
    emp_salary;
    
-- 전체사원의 급여를 기존 급여에 10프로 인상된 금액으로 변경해라
UPDATE emp_salary
SET
    salary = salary * 1.1;

SELECT
    *
FROM
    emp_salary;
/*
   UPDATE에서 서브쿼리 사용
   
   UPDATE 테이블명
   SET 컬럼명 = (서브쿼리)
   WHERE 조건


*/
     --방명수 사원의 급여와 보너스값을 유재식 사원의 급여와 보너스 값으로 변경
UPDATE emp_salary
SET
    salary = (
        SELECT
            salary
        FROM
            emp_salary
        WHERE
            emp_name = '유재식'
    ),
    bonus = (
        SELECT
            bonus
        FROM
            emp_salary
        WHERE
            emp_name = '유재식'
    )
WHERE
    emp_name = '방명수';

SELECT
    *
FROM
    emp_salary
WHERE
    emp_name = '방명수'
    OR emp_name = '유재식';
    
    --ASIA지역에서 근무하는 사원들의 보너스값을 0.3으로 변경
   
    
    --ASIA지역에서 근무하는 사원들
SELECT
    emp_id,
    emp_name
FROM
         emp_salary
    JOIN department ON ( dept_code = dept_id )
    JOIN location ON ( location_id = local_code )
WHERE
    location_id IN ( 'L1', 'L2', 'L3' );
    --위에서 구한 사원들의 보너스값을 0.3으로 변경
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
    테이블에 기록된 데이터를 삭제하는 구문(한 행 단위로 삭제가 된다.)
    
    [표현식]
    DELETE FROM 테이블명
    [WHERE 조건]-> WHRER절 제시 안하면 전체 행 다 삭제됨.
    */

DELETE FROM employee;

SELECT
    *
FROM
    employee;

ROLLBACK;

DELETE FROM employee
WHERE
    emp_name = '이소근';

DELETE FROM employee
WHERE
    emp_id = '901';

COMMIT;

DELETE FROM department
WHERE
    dept_id = 'D1';--외래키 제약조건에서 벗어나서 오류남.제약조건에서 삭제조건을 정해줘야함.
    
