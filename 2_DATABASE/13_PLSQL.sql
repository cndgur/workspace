/*
    <PL/SQL>
    PROCEDURE LANGAUGE EXTENSION TO SQL
    
    오라클 자체에 내장되어 있는 절차적 언어
    SQL문장 내에서 변수의 정의, 조건(IF), 반복(FOR, WHILE)등을 지원하여 SQL단점을 보완
    다수의 SQL문을 한번에 실행가능
    
    *PL/SQL 구조
    -[선언부] : DECLARE로 시작, 변수나 상수를 선언 및 초기화하는 부분
    - 실행부 : BEGIN으로 시작, SQL문 또는 제어문 등의 로직을 기술하는 부분
    - [예외처리부] : EXCEPTION으로 시작, 예외 발생 시 해결하기 위한 구문
    
*/

SET SERVEROUTPUT ON;
--HELLO ORACLE 출력
BEGIN
--SYSTEM.OUT.PRINT("HELLO ORACLE") 자바
    dbms_output.put_line('HELLO ORALCE');
END;
/


/*
    1. DECLARE 선언부
    변수 및 상수 선언하는 공간
    일반타입변수, 래퍼런스타입변수, ROW타입변수
    
    1_1) 일반타입 변수 선언및 초기화
        [표현식] 변수명 [CONSTANT] 자료형 [:= 값]
        
*/

DECLARE
    eid   NUMBER;
    ename VARCHAR2(20);
    pi    CONSTANT NUMBER := 3.14;
BEGIN
    eid := 800;
    ename := '최지원';
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
    eid := &번호;
    ename := '&이름';
    dbms_output.put_line('EID :' || eid);
    dbms_output.put_line('EID :' || ename);
    dbms_output.put_line('EID :' || pi);
END;
/


--1_2) 래퍼런스 타입 변수 선언 및 초기화(어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정)
DECLARE
    eid   employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    sal   employee.salary%TYPE;
BEGIN
--EID:=800
--ENAME:='최지원';
--SAL :=1000000;
/
--사번이 200번인 사원의 사번, 사원명, 급여조회

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
        WHERE EMP_ID=&사번;
        
    dbms_output.put_line(EID||', 'ename||', 'jcode||', 'sal||', 'dtitle||', ');

END;
/
------------------------------------------------------------------------------
--1_3) ROW타입 변수 선언
--테이블의 한 행에 대한 모든 컬럼값을 한번에 담을 수 잇는 변수
--[표현식] 변수명 테이블명 %ROWTYPE

DECLARE
E EMPLOYEE%ROWTYPE;
BEGIN
SELECT
    *
INTO e
FROM
    employee
WHERE
    emp_id = &사번;

dbms_output.put_line('사원명 : ' || e.emp_name);

dbms_output.put_line('급여 : ' || e.salary);

dbms_output.put_line('보너스 : ' || e.bonus);

end;
/

--------------------------------------------------------------------

--2. BEGIN 실행부
--<조건문>
--1) IF 조건식 THEN 실행내용 END IF;(IF문을 단독으로 사용할 때)
--입력받은 사번의 해당하는 사원의 사번, 이름, 급여, 보너스 출력
--단, 보너스를 받지 않은 사원은 보너스율 출력 전 '보너스를  지급받지 않는 사원입니다.'출력

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
        emp_id = &사번;

    dbms_output.put_line('사번 : ' || eid);
    dbms_output.put_line('이름 : ' || ename);
    dbms_output.put_line('급여 : ' || sal);
    IF bonus = 0 THEN
        dbms_output.put_line('보너스를  지급받지 않는 사원입니다.');
    END IF;
    dbms_output.put_line('보너스 : ' || bonus);
END;
/



--2) IF 조건식 THEN 실행내용 ELSE 


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
    emp_id = &사번;

dbms_output.put_line('사번 : ' || eid);

dbms_output.put_line('이름 : ' || ename);

dbms_output.put_line('급여 : ' || sal);

IF bonus = 0 THEN
    dbms_output.put_line('보너스를  지급받지 않는 사원입니다.');
ELSE
    dbms_output.put_line('보너스 : ' || bonus);
END IF;

end;
/

--------------------------------실습----------------------------------------
--DECLARE
--래퍼런스변수(EID, ENAME, DTITLE, NCODE)
--  참조변수(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
-- 일반타입변수(TEAM 문자열) - 국내팀, 해외팀 분리해서 저장
--BEGIN
-- 사용자가 입력한 사번의 사원정보를 가져와 사번, 이름, 부서명, 근무국가코드 조회 후 각 변수에 대입
-- NCODE값이 KO일 경우 -> TEAM ---> 국내팀
--           KO가 아닐 경우 -> TEAM ---> 해외팀
-- 사번, 이름, 부서, 소속을 출력
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
        emp_id = &사번;

    dbms_output.put_line('사번 : ' || eid);
    dbms_output.put_line('이름 : ' || ename);
    dbms_output.put_line('부서명 : ' || dtitle);
    dbms_output.put_line('국가 : ' || ncode);
    IF ncode = 'KO' THEN
        dbms_output.put_line(TEAM);
    ELSE
        dbms_output.put_line(TEAM);
    END IF;

END;
/
--3) IF 조건식1 THEN 실행내용1 ELSIF  조건식 2 THEN 실행내용2.....[ELSE 실행내용] END IF;
DECLARE
    score NUMBER;
    grade VARCHAR2(1);
BEGIN
    score := &점수;
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

    dbms_output.put_line('당신의 점수는 ' || score||'점이며 학점은 '||GRADE||'학점입니다.');
END;
/

--<반복문>
/*
    1) BASIC LOOP문
    [표현식]
    LOOP
        반복적으로 실행할 구문
        * 반복문을 빠져나갈 수 있는 구문
    END LOOP;
    
    * 반복문을 빠져나갈 수 있는 구문
    1) IF 조건식 THEN EXIT; END IF;
    2) EXIT WHEN  조건식;
    
    

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
2) FOR LOOP문
    [표현식]
    FOR 변수 IN [REVERSE]  초기값....최종값
    LOOP
    반복적으로 실행할 문자이
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
WHILE LOOP문

[표현식]
WHILE 반복문이 수행될 조건
LOOP
반복수행할 작업
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
    3. 예외처리부
    예외(EXCEPTION) : 실행 중 발생하는 오류
    
    EXCEPTION
    WHEN 예외명1 THEN 처리구문1;
    WHEN 예외명2 THEN 처리구문2;
    ...
    
    * 시스템 예외(오라클에서 미리 정의해둔 예외)
    -NO_DATE_FOUND : SELECT한 결과가 한행도 없을 때
    -TOO_MANY_ROWS : SELECT한 결과가 여러행일 경우
    - ZERO_DIVICE : 0으로 나눌 때
    -DUP_VAL_ON_INDEX: UNIQUE 제약조건 위배
    ...
*/

--사용자가 입력한 수로 나눗셈한 결과를 출ㄹ겨
DECLARE 
RESULT NUMBER; BEGIN
    result := 10 / &숫자;
    dbms_output.put_line('결과 : ' || result);
EXCEPTION
  --  WHEN zero_divide THEN
       -- dbms_output.put_line('나누기 연산 시 0으로 나눌 수 없습니다.');

    WHEN OTHERS THEN
        dbms_output.put_line('나누기 연산 시 0으로 나눌 수 없습니다.');
END;
/

ALTER TABLE EMPLOYEE ADD PRIMARY KEY(EMP_ID);

BEGIN UPDATE EMPLOYEE
SET EMP_ID = '&변경할사번'--띄어쓰기 하면 인식못함
WHERE EMP_NAME ='노옹철';
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN DBMS_OUPPUT.PUT_LINE('이미 존재하는 사원입니다.');
EMD;
/
