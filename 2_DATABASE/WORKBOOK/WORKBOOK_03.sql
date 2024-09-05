--1. 학생이름과 주소지를 표시하시오.
--단, 출력 헤더는 "학생이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT
    student_name    AS "학생이름",
    student_address AS "주소지"
FROM
    tb_student
ORDER BY
    student_name ASC;
    
--2. 휴학 중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT
    student_name,
    student_ssn
FROM
    tb_student
WHERE
    absence_yn = 'Y'
ORDER BY
    student_ssn;
    
--3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
--단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT
    student_name    AS "학생이름",
    student_no      AS "학번",
    student_address AS "거주지 주소"
FROM
    tb_student
WHERE
    student_no NOT LIKE 'A%'
    AND ( student_address LIKE '강원%'
          OR student_address LIKE '경기%' )
ORDER BY
    student_name ASC;
    
--4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL문장을 작성하시오
--(법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
SELECT
    professor_name,
    professor_ssn
FROM
    tb_professor
WHERE
    department_no = 005
ORDER BY
    substr(professor_ssn, 1, 2) ASC;
    
--5. 학생번호, 학생이름, 학과이름을 학생이름으로 오름차순으로 정렬하여 출력하는 SQL문을 작성하시오
SELECT
    student_no,
    student_name,
    department_name
FROM
         tb_student
    JOIN tb_department USING ( department_no )
ORDER BY
    student_name ASC;