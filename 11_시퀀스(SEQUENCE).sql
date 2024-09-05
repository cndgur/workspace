/*
    <시퀀스 SEQUENCE>
    자동으로 번호를 발생시켜주는 역할을 하는 객체
    점수값을 순차적으로 일정하게 증가시키면서 생성해준다.
    
    EX)회원번호, 사원번호, 게시글번호....
*/

/*
    1. 시퀀스 객체 생성
    
    [표현식]
    CREATE SEQUENCE 시퀀스명
    [START WITH  시작숫자]-> 처음 발생시킬 시작값 지정(기본값 1)
    [INCREMENT BY 숫자]-> 몇씩 증가시킬 건지(기본값1)
    [MAXVALUE 숫자]-> 최대값지정(기본값 매우 크다)
    [MINVALUE 숫자]-> 최소값 지정(기본값은 1)
    [CYCLE | NOCYCLE] -> 값 순환여부(기본값은 NOCYCLE)
    [CACHE|NOCACHE] -> 캐시메모리 할당(기본값 CACHE 20)
    * 캐시 메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
                    매번 호출될 때마다 새로운 번호를 생성하는게 아니라
                    캐시메모리 공간에 미리 생성된 값들을 가져다 쓸 수 있다.(속도가 빨라진다)
                    
    테이블명 : TB_
    뷰명 : VW_
    시퀀스 : SEQ_
    트리거 : TRG_
                    
*/

CREATE SEQUENCE seq_test;

--[참고] 현재 계정이 소유한 시퀀스들의 구조를 보고 싶을 때
SELECT
    *
FROM
    user_sequences;

DROP SEQUENCE seq_empno;

CREATE SEQUENCE seq_empno START WITH 300 INCREMENT BY 5 MAXVALUE 310 NOCYCLE NOCACHE;



/*
    2. 시퀀스 사용
    시퀀스명.CURRVAL : 현재 시퀀스 값(마지막으로 성공한 NEXTVAL의 수행값)
    시퀀스명.NEXTVAL : 시퀀스값에 일정한 값을 증가시켜 발생한 값
                        현재 시퀀스 값에 INCREMENT BY 값 만큼 증가한 값


*/
SELECT
    *
FROM
    user_sequences;

SELECT
    seq_empno.CURRVAL
FROM
    dual;--오류 : CURRVAL은 그냥 현재값이 아니라 마지막으로NEXTVAL한 값을 가져오는 것이다.

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
    dual;--최댓값 310을 넘어서 에러 발생

/*
    3. 시퀀스의 구조 변경
    ALTER SEQUENCE 시퀀스
    [INCREMENT BY 숫자]
    [MAXVALUES 숫자]
    [MINVALUE 숫자]
    [CYCLE | NOCYCLE]
    [CACHE 바이트크기 | NOCACHE]
    
    * START WITH는 변경불가
    
*/

ALTER SEQUENCE seq_empno INCREMENT BY 10 MAXVALUE 400;

SELECT
    seq_empno.NEXTVAL
FROM
    dual;
--시퀀스 삭제
DROP SEQUENCE seq_empno;
-------------------------------------------------------------------------------
--사원번호로 사용할 시퀀스

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
    '김말똥',
    '111111-2111111',
    'J6',
    sysdate
);
