--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학년도를 
--입학년도가 빠른 순으로 표시하는 SQL문장을 작성하시오
--(단, 헤더는 "학번", "이름", "입학년도"가 표시되돌고 한다.)
SELECT
    student_no    AS "학번",
    student_name  AS "이름",
    entrance_date AS "입학년도"
FROM
    tb_student
WHERE
    department_no = '002'
ORDER BY
    entrance_date ASC;
    
--2. 춘 기술대학교의 교수 중 이름이 세글자가 아닌 교수가 한명 있다고 한다.
--그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해보자.
--(* 이때 올바르게 작성한 SQL문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼것)
SELECT
    professor_name,
    professor_ssn
FROM
    tb_professor
WHERE
    NOT length(professor_name) = 3;

--3. 춘 기술대학교의 남자교수들의 이름과 나이를 출력하는 SQL문장을 작성하시오.
--단, 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
--(단, 교수 중 2000년 이후 출생자는 없으며 출력헤더는 "교수이름", "나이"로 한다.
--나이는 '만'으로 계산한다)
SELECT
    professor_name                                                      AS "교수이름",
    EXTRACT(YEAR FROM sysdate) - ( substr(professor_ssn, 1, 2) + 1900 ) AS "나이"
FROM
    tb_professor
WHERE
    substr(professor_ssn, 8, 1) IN ( '1', '3' )
ORDER BY
    나이 ASC;
    
    
--4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL문장을 작성하시오.
--출력 헤더는 "이름"이 찍히도록 한다.
--(성이 2자인 경우는 교수는 없다고 가정하시오)
SELECT
    substr(professor_name, 2) AS "이름"
FROM
    tb_professor;

--5. 춘 기술대학교의 재수생 입학자를 구하려고 한다.
--어떻게 찾아낼 것인가? 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
SELECT
    student_no,
    student_name
FROM
    tb_student
WHERE
    ( substr(entrance_date, 1, 2) + 2000 ) - ( substr(student_ssn, 1, 2) + 1900 ) = 20;
    
--2020년 크리스마스는 무슨요일인가?
SELECT
    to_char(to_date(20201225), 'DAY')
FROM
    dual;
    
--7. TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은 
--각각 몇년 몇월 몇일을 의미할까? 
--또 TO_DATE'99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')은 
--각각  몇년 몇월 몇일을 의미할까?

SELECT
    to_char(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYY"년"MM"월"DD"일"'),
    to_char(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYY"년"MM"월"DD"일"'),
    to_char(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY"년"MM"월"DD"일"'),
    to_char(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY"년"MM"월"DD"일"')
FROM
    dual;
    
--8. 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
--2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오
SELECT
    student_no,
    student_name
FROM
    tb_student
WHERE
    student_no NOT LIKE 'A%';
    
--9. 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성하시오.
--단, 이때 출력 화면의 헤더는 "평점"이라고 찍히게 하고,
--점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT
    round(AVG(point), 1) AS "평점"
FROM
    tb_grade
WHERE
    student_no = 'A517178';
    
--10. 학과별 학생수를 구하여 "학과번호", "학생수(명)"의 형태로 
--헤더를 만들어 결과값이 출력되도록 하시오.
SELECT
    department_no        AS "학과번호",
    COUNT(department_no) AS "학생수(명)"
FROM
    tb_student
GROUP BY
    department_no;
    
    
--11. 지도교수를 배정받지 못한 학생의 수는 몇명 정도되는지 알아내는 SQL문을 작성하시오.
SELECT
    COUNT(*)
FROM
    tb_student
WHERE
    coach_professor_no IS NULL;
    
--12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성하시오.
--단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT
    substr(term_no, 1, 4) AS "년도",
    round(AVG(point), 1)  AS "년도별 평점"
FROM
    tb_grade
WHERE
    student_no = 'A112113'
GROUP BY
    substr(term_no, 1, 4)
ORDER BY
    substr(term_no, 1, 4) ASC;
    
--13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL문장을 작성하시오
SELECT
    department_no,
    COUNT(decode(absence_yn, 'Y', 1, NULL))
FROM
    tb_student
GROUP BY
    department_no
ORDER BY
    department_no;

--14. 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다.
--어떤 SQL문장을 사용하면 가능하겟는가?
SELECT
    student_name,
    COUNT(student_name)
FROM
    tb_student
GROUP BY
    student_name
HAVING
    COUNT(student_name) >= 2;
    
--15. 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL문을 작성하시오
--(단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT
    substr(term_no, 1, 4) AS "년도",
    substr(term_no, 5, 2) AS "학기",
    round(AVG(point), 1)  AS "평점"
FROM
    tb_grade
WHERE
    STUDENT_NO = 'A112113'
GROUP BY
    substr(term_no, 1, 4),
    substr(term_no, 5, 2)
ORDER BY
    substr(term_no, 1, 4);