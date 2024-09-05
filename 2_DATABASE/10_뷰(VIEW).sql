GRANT
    CREATE VIEW
TO kh;
/*
    <VIEW> 뷰
    SELECT문(쿼리문)을 저장해둘 수 있는 객체
    (자주 사용하는 SELECT문을 저장해두면 긴 SELECT문을 매번 다시 기술할 필요없이 사용할 수 있다.)
    임시테이블 같은 존재(실제데이터가 담겨있는 건 아니다.-> 논리테이블)
*/

--한국에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
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
    national_name = '한국';
    
    
    /*
        1. VIEW 생성방법
        [표현식]
        CREATE VIEW 뷰명
        AS 서브쿼리
        
    */
    
    --TB
    --VW
    --이렇게 테이블과 뷰가 같은 이름이라면 표시를 붙여준다.
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
--실제 실행되는 것은 아래와 같은 서브쿼리로 실행된다고 볼 수 있다.
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
    );-- 결과 동일
--한국에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT
    *
FROM
    vw_employee
WHERE
    national_name = '한국';

--러시아에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT
    *
FROM
    vw_employee
WHERE
    national_name = '러시아';

--일본에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT
    *
FROM
    vw_employee
WHERE
    national_name = '일본';


--* 테이블은 생성 후 수정이 안되지만 뷰는 수정가능하다.
--CREATE OR REPLACE를 사용하면 VIEW가 없을 때는 생성, 이미 존재한다면 수정할 수 있다.

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
    * 뷰 컬럼에 별칭 부여
    서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어 있다면 반드시 별칭을 부여해야한다.
    


*/
CREATE OR REPLACE VIEW vw_emp_job AS
    ( SELECT
        emp_id,
        emp_name,
        decode(job_name, substr(emp_no, 8, 1), '1', '남', '2', '여') AS "성별",
        EXTRACT(YEAR FROM sysdate) - EXTRACT(YEAR FROM hire_date)  AS "근무년수"
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
    근무년수 >= 20;
    
--뷰를 삭제하고 싶을 때
DROP VIEW vw_emp_job;
------------------------------------------------------------------------------

--생성된 뷰를 통해서 DML(INSERT, UPDATE, DELETE)사용가능 BUT 안되는 경우가 너무 많다.
--뷰를 통해서 조작하게되면 실제 데이터가 담겨있는 테이블에 반영이 된다.
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
    vw_job;--논리테이블(실제데이터가 담겨있지 않다. 뷰일뿐!1)
SELECT
    *
FROM
    job;--테이블!!

--뷰를 통해서 INSERT-->뷰뿐만 아니라 실제 테이블에도 반영되어 값이 추가된다.
INSERT INTO vw_job VALUES (
    'J8',
    '인턴'
);

UPDATE vw_job
SET
    job_name = '알바'
WHERE
    job_code = 'J8';

/*
    * DML명령어로 조작이 불가능한 경우가 많다.
    1) 뷰에 정의되어 있지 않은 컬럼을 조작하려고 하는 경우
    2) 뷰에 정의되어 있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL제약조건이 지정되어 있는 경우
    3) 산술연산식이나 함수식을 사용한 경우
    4) 그룹함수나 GROUP BY절을 포함한 경우
    5) DISTINCT구문이 포함된 경우
    6) JOIN을 이용해서 여러테이블을 연결시켜놓은 경우
    
    대부분 뷰는 조회를 목적으로 생성한다. 그냥 뷰를 통한 DML은 안쓰는게 좋다.
    
*/

DROP TABLE test;


/*
    VIEW 옵션
    [상세표현식]
    CREATE [OR REPLACE][FORCE|NO FORCE] VIEW 뷰명
    AS 서브쿼리
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE : 기존에 동일한 뷰가 있을 경우 갱신하고, 없을 경우 새로 생성해라
    2) FORCE | NOFORCE
        > FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되도록 해라
        > NOFORCE : 서브퀴리에 기술된 테이블이 존재하는 테이블이여야만 한다.(기본값)
    3) WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML이 가능하도록
    4) WITH READ ONLY : 뷰에 대해서 조회만 가능하도록
    
*/

--2) FORCE | NOFORCE
CREATE OR REPLACE NOFORCE VIEW vw_emp AS
    SELECT
        tcode,
        tname,
        tcontent
    FROM
        tt;
--서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 우선은 생기게 된다.
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

--3) WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정시 오류발생
--WITH CHECK OPTION안쓰고 
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
    
--200번 사원 급여를 200만원으로 변경( salary >= 3000000조건에 부합하지 않는 변경)
UPDATE vw_emp
SET
    salary = 2000000
WHERE
    emp_id = 200;

SELECT
    *
FROM
    vw_emp;
    
    
--4) WITH READ ONLY : 뷰에 대해 조회만 가능하도록
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