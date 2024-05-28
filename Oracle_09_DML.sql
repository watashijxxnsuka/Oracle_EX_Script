-- 1. DML(DATA MANIPULATION LANGUAGE): 데이터 조작 언어
-- 데이터를 저장, 수정, 삭제하는 언어로 INSERT INTO, UPDATE SET, DELETE FROM 이 존재한다.
-- DML 은 트렌젝션을 완료하기 위해서 항상 COMMIT 이나 ROLLBACK 을 동반한다.
-- 1-1. INSERT INTO: 테이블에 데이터를 저장하는 명령어
-- 일부 컬럼에 대한 데이터를 저장
INSERT INTO EMP (ENO, ENAME, JOB, HDATE) VALUES ('9997', '장길산', '설계', SYSDATE);
COMMIT;

SELECT *
	FROM EMP
	ORDER BY ENO DESC;

INSERT INTO EMP (ENO, ENAME, JOB, HDATE) VALUES ('9996', '임꺽정', '개발', SYSDATE);
INSERT INTO EMP (ENO, ENAME, JOB, HDATE) VALUES ('9995', '홍길동', '회계', SYSDATE);
INSERT INTO EMP (ENO, ENAME, JOB, HDATE) VALUES ('9994', '조병조', '지원', SYSDATE);
INSERT INTO EMP (ENO, ENAME, JOB, HDATE) VALUES ('9993', '정도전', '경영', SYSDATE);
-- COMMIT 이 발생한 작업에 대해서는 ROLLBACK으로 취소할 수 없다.
ROLLBACK;

-- INSERT INTO 시 지정한 컬럼의 개수와 컬럼의 타입에 맞는 데이터를 입력해야 한다.
-- 값의 수가 충분하지 않은 예시
-- INSERT INTO EMP (ENO, ENAME, JOB, HDATE) VALUES ('9993', '정도전', '경영');

-- 수치가 부적합한 예시
-- INSERT INTO EMP (ENO, ENAME, JOB, SAL) VALUES ('9992', '이순신', '회계', 'ㅁㅁㅁㅁㅁㅁㅁ');

-- VARCHAR 타입의 숫자 값이 NUMBER 타입으로 형변환이 일어나면서 저장된다.
INSERT INTO EMP (SAL) VALUES ('12838');

-- 모든 컬럼에 데이터를 저장할 때는 컬럼 지정을 생략해도 된다.
INSERT INTO EMP (ENO, ENAME, JOB, MGR, HDATE, SAL, COMM, DNO)
	 		VALUES ('9996', '임꺽정', '회계', '0001', SYSDATE, 4000, 300, '10');

INSERT INTO EMP VALUES ('9995', '조병조', '경영', '0201', SYSDATE, 3700, 280, '20');
COMMIT;

-- 다량의 데이터를 SELECT 구문을 이용해서 저장
CREATE TABLE EMP_DNO30(
	ENO VARCHAR2(4),
	ENAME VARCHAR2(20),
	JOB VARCHAR2(10),
	MGR VARCHAR2(4),
	HDATE DATE,
	SAL NUMBER(5, 0),
	COMM NUMBER(5, 0),
	DNO VARCHAR2(2)
);

-- DNO 가 30인 사원 목록을 조회해서 EMP_DNO30에 저장
INSERT INTO EMP_DNO30 
SELECT *
	FROM EMP
	WHERE DNO = '30';
COMMIT;

SELECT *
	FROM EMP_DNO30;

-- SELECT 구문을 이용해서 다량의 데이터를 저장하는데 특정 컬럼의 데이터만 저장
-- DNO 가 10인 사원의 사원번호, 사원이름만 EMP 테이블에서 조회해서 EMP_DNO30 테이블에 저장
INSERT INTO EMP_DNO30(ENO,ENAME)
SELECT ENO 
	 , ENAME 
	FROM EMP
	WHERE DNO = '10';
COMMIT;

INSERT INTO EMP_DNO30(ENO,ENAME)
SELECT DNO	
	 , DNAME
	FROM DEPT
	WHERE LOC = '서울';
COMMIT;

CREATE TABLE COURSE_PROFESSOR(
	CNUM VARCHAR2(8),
	COURSE_CNAME VARCHAR2(20),
	ST_NUM NUMBER(1, 0),
	PNUM VARCHAR2(8),
	PROFESSOR_NAME VARCHAR2(20)
);

-- 모든 과목의 과목번호, 과목이름, 학점, 담당교수의 교수번호, 교수이름을 COURSE_PROFESSOR 에 저장
-- 담당교수가 없는 과목은 담당교수 번호와 이름을 NULL 로 저장
INSERT INTO COURSE_PROFESSOR 
SELECT C.CNO 
	 , C.CNAME 
	 , C.ST_NUM
	 , NVL(P.PNO, 'NULL') 
	 , NVL(P.PNAME, 'NULL') 
	FROM COURSE C
	LEFT JOIN PROFESSOR P
	  ON C.PNO = P.PNO;
COMMIT;

-- 테이블 삭제
-- DROP TABLE COURSE_PROFESSOR;

SELECT *
	FROM COURSE_PROFESSOR
	ORDER BY CNUM;

-- 1-2. UPDATE SET: 데이터를 수정하는 명령어
-- WHERE 절을 사용하지 않으면 모든 데이터가 수정된다. 
UPDATE EMP_DNO30 
	SET MGR = '0002';
COMMIT;

SELECT *
	FROM EMP_DNO30;

-- WHERE 절로 특정 데이터만 수정
-- EMP_DNO30 테이블에서 ENO 가 2007인 사원의 급여를 3100으로 수정
UPDATE EMP_DNO30
	SET SAL = 3100
	WHERE ENO = '2007';
COMMIT;

-- 여러개의 컬럼 데이터를 한번에 수정할 때는 수정할 컬럼을 ,로 묶어서 지정
-- EMP_DNO30 테이블에서 ENO 가 3004인 사원의 업무를 경영으로, MGR 은 2003 으로, HDATE 은 오늘 날짜로, 급여는 5000으로
-- COMM 은 500으로 수정
UPDATE EMP_DNO30 
	SET JOB = '경영',
		MGR = '2003',
		HDATE = SYSDATE,
		SAL = 5000,
		COMM = 500
	WHERE ENO = '3004';
COMMIT;

DELETE FROM EMP_DNO30;
COMMIT;

INSERT INTO EMP_DNO30
SELECT *
	FROM EMP;
COMMIT;

-- EMP_DNO30 테이블에서 DNO 가 20, 30인 부서를 60 부서로 통합하고
-- 해당 부서의 사원들의 보너스를 50% 인상
UPDATE EMP_DNO30 
	SET DNO = '60',
		COMM = COMM * 1.5
	WHERE DNO IN ('20','30');
COMMIT;

SELECT *
	FROM EMP_DNO30;

-- 서브쿼리를 이용한 데이터 수정
-- SET 절에 서브쿼리의 결과로 나오는 컬럼의 개수만큼 ()로 묶은 컬럼을 지정하고 =다음에 서브쿼리를 작성한다.
-- ()로 묶인 컬럼의 개수와 타입이 서브쿼리 결과의 데이터의 컬럼개수와 타입이 일치해야한다.
-- 서브쿼리의 결과는 한 행만 조회되어야 한다.
CREATE TABLE DEPT_COPY1 AS 
	SELECT *
		FROM DEPT;

-- DEPT_COPY1 테이블에서 DNO 이 20, 30인 부서를 50부서와 통합
UPDATE DEPT_COPY1
	SET (DNO, DNAME, LOC, DIRECTOR) 
	= (
			SELECT DNO 
			     , DNAME 
				 , LOC 
				 , DIRECTOR 
				FROM DEPT 
				WHERE DNO = '50'
	  )
	  WHERE DNO IN ('20', '30');
COMMIT;

SELECT *
	FROM DEPT_COPY1;
										
-- DEPT_COPY1 테이블에서 DNO 가 40인 부서의 DIRECTOR 를
-- EMP 테이블에서 최고급여를 받는 사원으로 수정
UPDATE DEPT_COPY1 
	SET DIRECTOR = (
		SELECT ENO
			FROM EMP
			WHERE SAL = (
						SELECT MAX(SAL)
							FROM EMP
						)		
		)
	WHERE DNO = '40';
COMMIT;

-- 1-3. DELETE FROM: 데이터를 삭제하는 명령어
-- 행 단위로 데이터를 삭제하기 때문에 컬럼을 지정할 필요가 없다.
-- WHERE 절을 사용하지 않으면 테이블의 모든 데이터를 삭제한다.
DELETE FROM DEPT_COPY1;
COMMIT;

-- WHERE 절로 특정 데이터만 삭제
DELETE FROM EMP_DNO30
	WHERE DNO IN ('01', '10');
COMMIT;

SELECT *
	FROM EMP_DNO30;

-- WHERE 절에 서브쿼리로 특정 데이터를 지정할 수도있다.
DELETE FROM EMP_DNO30
	WHERE ENO IN (
	SELECT ENO
		FROM EMP_DNO30 
		WHERE SAL >= 4000
		);
COMMIT;

CREATE TABLE STUDENT_COPY1
	AS SELECT * FROM STUDENT;

-- STUDENT_COPY1 테이블에서 기말고사 성적의 평균이 60점 이하인 학생을 모두 삭제
DELETE FROM STUDENT_COPY1
	WHERE SNO IN (
	SELECT SNO
		FROM SCORE SC
		GROUP BY SNO
		HAVING AVG(SC.RESULT) <= 60
	);
COMMIT;




















