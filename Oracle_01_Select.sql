-- 1. 기본 Select 구문
-- 1-1. 과목테이블에서 과목번호, 과목이름, 학점, 담당교수번호 조회
SELECT CNO
	, CNAME
	, ST_NUM
	, PNO
	FROM COURSE;
	
-- 1-2. 학생테이블에서 학생번호와 학생이름 조회
SELECT SNO
	, SNAME
	FROM STUDENT;
	
-- 1-3. 조회할 테이블의 모든 컬럼의 데이터를 조회할 때는 컬럼명 대신 *을 사용해도 된다.
SELECT *
	FROM DEPT;
	
-- 2. 컬럼이나 테이블에 별칭 붙이기
-- 2-1. 컬럼에 별칭붙이기
-- 조회해올 데이터의 컬럼에 별칭을 붙일 수 있다. 조회된 데이터는 새로운 가상테이블을 생성하는데
-- 가상테이블의 컬럼명은 붙인 별칭으로 할당된다. 별칭은 한글로 붙여도 무방하나, 대부분 영어로 붙인다.
-- AS 키워드를 이용해서 별칭을 붙일 수 있는데, AS 키워드는 생략 가능하다.
SELECT PNO AS PROFESSOR_NO
	, PNAME AS 교수이름
	, ORDERS 직위
	FROM PROFESSOR;

-- 2-2. 테이블에 별칭붙이기
-- 테이블에 붙인 별칭은 Select 구문안에서 사용하기 위한 별칭이다.
-- 여러개의 테이블을 동시에 조회할 때 주로 사용된다.
-- 여러개의 테이블을 동시에 조회하면 어떤 테이블의 컬럼인지 모호해지는 경우가 있는데,
-- 그 경우를 대비하기 위해 어떤 테이블의 컬럼인지 명확하게 해주기 위해 주로 사용한다.
SELECT STUDENT.SNO 
	, STUDENT.SNAME 
	FROM STUDENT;

-- 테이블에 별칭을 줄 때는 AS 키워드를 사용할 수 없다. 테이블명 뒤에 바로 붙일 별칭을 달아준다.
SELECT ST.SNO
	, ST.NAME
	FROM STUDENT ST;

-- 여러개의 테이블 동시 조회시 모호한 컬럼의 경우
SELECT SNO
	, SNAME
	, RESULT
	FROM STUDENT
	JOIN SCORE
	ON STUDENT.SNO = SCORE.SNO;

SELECT ST.SNO
	, ST.SNAME
	, SC.RESULT
	FROM STUDENT ST
	JOIN SCORE SC
	ON ST.SNO = SC.SNO;

-- 3. NULL 인 데이터의 처리방식을 지정하는 NVL
SELECT DNO
	, DNAME
	, LOC
	, DIRECTOR
	FROM DEPT;

SELECT DNO
	, DNAME
	, LOC
	, NVL(DIRECTOR,'팀장없음') AS DIRECTOR 
	FROM DEPT;
 
-- 3-1. 사원테이블에서 사원번호, 사원이름, 급여, 보너스(COMM) 조회하는데

-- 보너스가 NULL 인 사원은 0으로 조회

SELECT ENO
	, ENAME
	, SAL
	, NVL(COMM, 0) AS COMM
	FROM EMP;
	
-- 보너스가 NULL 인 사원은 SAL/12로 조회
SELECT ENO
	, ENAME
	, SAL
	, NVL(COMM, SAL/12) AS COMM
	FROM EMP;	

-- 4. 연결연산자(||)
-- 한번에 연결해서 조회하고 싶은 컬럼들을 ||를 이용해서 연결 조회할 수 있다.
-- 4-1. 사원의 급여와 이름을 -로 연결해서 조회
SELECT ENO
	, ENAME || '-' || SAL
	FROM EMP;

-- 4-2. 학생번호와 기말고사점수를 -로 연결해서 조회(SCORE)
SELECT SNO || '-' || RESULT
	FROM SCORE;

-- 5. 중복제거자 DISTINCT
-- 5-1. 중복을 제거하지 않았을 때
SELECT JOB
	FROM EMP;

-- 5-2. DISTINCT 사용해서 중복제거 했을 때
SELECT DISTINCT JOB
	FROM EMP;

-- 5-3. 여러개의 컬럼에 대한 DISTINCT
-- 여러개의 컬럼을 조회할 때 DISTINCT 가 걸리면
-- 조회된 여러개의 컬럼을 데이터 셋(SET) 하나로 인식해서
-- 조회된 모든 컬럼의 데이터가 중복돼야 중복으로 인식한다.
SELECT DISTINCT JOB
	, MGR
	FROM EMP;

-- 6. 데이터 정렬 기준을 정하는 ORDER BY
-- 6-1. 컬럼 하나만 정렬
-- 오름차순(ASC) 로 정렬할때는 ASC 를 생략해도 된다.
SELECT SNO
	, SNAME
	, MAJOR
	, SYEAR
	, AVR
	FROM STUDENT
	ORDER BY SYEAR;

-- 내림차순(DESC)로 정렬할 때는 항상 DESC 를 명시해야 한다.
SELECT SNO
	, SNAME
	, MAJOR
	, SYEAR
	, AVR
	FROM STUDENT
	ORDER BY SYEAR DESC;

-- DATABASE 에서 정렬은 문자로도 가능하다.
SELECT SNO
	, SNAME
	, MAJOR
	, SYEAR
	, AVR
	FROM STUDENT
	ORDER BY SNAME DESC;

-- 6-2. 컬럼 여러개로 정렬
-- 처음 지정된 컬럼으로 정렬이 된 상태에서 다음 지정된 컬럼으로 정렬한다.
SELECT SNO
	, SNAME
	, MAJOR
	, SYEAR
	, AVR
	FROM STUDENT
	ORDER BY SYEAR,SNAME;

-- ORDER BY 여러개의 컬럼을 지정할 때는 각 컬럼에 정렬방식(ASC, DESC)을 각각 지정할 수 있다.
SELECT SNO
	, SNAME
	, MAJOR
	, SYEAR
	, AVR
	FROM STUDENT
	ORDER BY SYEAR DESC, AVR DESC;


SELECT SNO
	, SNAME
	, MAJOR
	, SYEAR
	, AVR
	FROM STUDENT
	ORDER BY SYEAR DESC, MAJOR, AVR DESC;

-- 6-3. 사원 테이블에서 사원번호, 사원이름, 부서번호, 급여 조회하는데
-- 부서번호가 빠르고 급여가 높은 사원부터 조회
SELECT ENO
	 , ENAME
	 , DNO
	 , SAL
	FROM EMP
	ORDER BY DNO, SAL DESC;

-- 6-4. 컬럼에 별칭을 붙인 경우에는 별칭으로도 정렬가능
SELECT ENO
	 , ENAME
	 , DNO AS 부서번호
	 , SAL AS 급여
	FROM EMP
	ORDER BY 부서번호, 급여 DESC;

-- 7. 조건을 걸어서 원하는 데이터만 조회하는 	WHERE 절
-- WHERE 절은 FROM 이나 JOIN ~ ON 절 다음에 작성한다.
-- 7-1. WHERE 절에서 값의 크기를 비교할때는 자바와 마찬가지로 부등호를 사용한다.(>,<,>=,<=)
-- 사원중에 급여가 3000이상인 사원번호, 사원이름, 급여 조회
SELECT ENO
	 , ENAME
	 , SAL
	FROM EMP
	WHERE SAL >= 3000
	ORDER BY SAL DESC;

SELECT *
	FROM EMP;

-- 학생중에 평점이 3.0 이하인 학생번호, 학생이름, 전공, 학년, 평점조회
SELECT SNO
	 , SNAME
	 , MAJOR
	 , SYEAR
	 , AVR
	FROM STUDENT
	WHERE AVR <= 3.0
	ORDER BY SYEAR, AVR DESC;

-- 7-2. WHERE 절에서 값의 동일여부를 비교할 때는 =, != 를 사용한다.
-- 전공이 화학과인 학생의 학생번호, 학생이름, 전공, 학년 조회
SELECT SNO
	 , SNAME
	 , MAJOR
	 , SYEAR
	FROM STUDENT
	WHERE MAJOR = '화학'
	ORDER BY SYEAR;

-- 전공이 화학과가 아닌 학생의 학생번호, 학생이름, 전공, 학년 조회
SELECT SNO
	 , SNAME
	 , MAJOR
	 , SYEAR
	FROM STUDENT
	WHERE MAJOR != '화학'
	ORDER BY SYEAR;

-- 7-3. WHERE 절에서 조건을 비교할때는 항상 컬럼의 타입과 동일한 타입의 값으로 비교한다.
-- 사원테이블의 급여 컬럼은 NUMBER 타입인데, 문자열과 비교를 하게 되면 
-- 급여컬럼에 있는 모든 데이터가 문자열로 변환되는 과정이 필요하다.
-- 데이터가 많아지면 많아질수록 변환되는 시간이 오래 걸리기 때문에
-- 항상 테이블에 컬럼 데이터가 타입변환이 일어나지 않도록 쿼리를 작성해야한다.

-- 밑은 부적절한 쿼리의 예시이다.
SELECT ENO
	 , ENAME
	 , HDATE
	FROM EMP
	WHERE TO_CHAR(HDATE) < '2000-10-10:23:59:59';

-- 바른 예시.
SELECT ENO
	 , ENAME
	 , HDATE
	FROM EMP
	WHERE HDATE < TO_DATE('2000-10-10:23:59:59');







