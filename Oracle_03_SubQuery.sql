-- 1. SUB QUERY
-- 1-1. 단일 행 SUB QUERY
-- SELECT, FROM, JOIN, WHERE 절에서 사용가능한 서브쿼리
-- 송강 교수보다 부임일자가 빠른 교수들의 교수번호, 교수이름 조회
SELECT PNO
	 , PNAME
	FROM PROFESSOR P
	WHERE HIREDATE <(
					 SELECT HIREDATE 
						 FROM PROFESSOR P
						 WHERE PNAME = '송강'
					);
					
-- 손하늘 사원보다 급여(연봉)가 높은 사원의 사원번호, 사원이름, 급여 조회
SELECT ENO 
	 , ENAME 
	 , SAL
	FROM EMP e
	WHERE SAL > (
				SELECT SAL 
					FROM EMP e2 
					WHERE ENAME = '손하늘'
				);

-- 위 쿼리를 JOIN 절로 변경
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 , A.SAL AS "손하늘급여"
	FROM EMP e 
	JOIN(
		SELECT SAL 
			FROM EMP 
			WHERE ENAME = '손하늘'
		) A
	ON E.SAL > A.SAL;

-- 공융의 일반화학 기말고사 성적보다 높은 학생의 학생번호, 학생이름, 과목번호, 과목이름, 기말고사 성적 조회
SELECT S.SNO
	 , S.SNAME
	 , C.CNO
	 , C.CNAME
	 , SC.RESULT
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN COURSE C
	  ON SC.CNO = C.CNO 
	 AND C.CNAME = '일반화학'
	JOIN (
		SELECT SC2.RESULT
			FROM SCORE SC2
			JOIN STUDENT s2 
			  ON S2.SNO = SC2.SNO
			JOIN COURSE C2
			  ON SC2.CNO = C2.CNO 
			WHERE S2.SNAME = '공융'
			  AND C2.CNAME = '일반화학'
		) A
	  ON SC."RESULT" > A.RESULT
 	ORDER BY RESULT;
 
 -- 1-2. 다중행 서브쿼리 
 -- 서브쿼리의 결과가 여러행인 서브쿼리
 -- FROM, JOIN, WHERE 절에서 사용가능
 -- 급여가 3000 이상인 사원의 사원번호, 사원이름, 급여 조회
SELECT SAL
 	 FROM EMP 
 	 WHERE SAL >= 3000;

-- FROM, JOIN 절
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	FROM EMP e 
	JOIN (
		SELECT ENO
			 FROM EMP e2 
			 WHERE SAL >= 3000
	) A
	ON E.ENO = A.ENO;
	
-- WHERE 절			
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	FROM EMP e 		
	WHERE E.ENO IN (
				SELECT ENO
				   FROM EMP e2 
				   WHERE SAL >= 3000
				);
				
-- 1-3. 다중열 서브쿼리
-- 서브쿼리의 결과가 다중행이면서 다중열인 서브쿼리
-- FROM, JOIN 절에서만 사용 가능하다.
-- 과목번호, 과목이름, 교수번호, 교수이름을 조회하는 서브쿼리를 작성하여
-- 기말고사 성적 테이블과 조인하여 과목번호, 과목이름, 교수번호, 기말고사 성적을 조회
-- 서브쿼리 없이 조회
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	 , SC.RESULT
	FROM COURSE c 
	JOIN SCORE SC
	  ON C.CNO = SC.CNO 
	JOIN PROFESSOR p 
	  ON C.PNO = P.PNO;
	 
-- 서브쿼리 사용			
SELECT A.CNO
	 , A.CNAME
	 , A.PNO
	 , A.PNAME
	 , SC.RESULT
	FROM (
		SELECT C.CNO
			 , C.CNAME
			 , P.PNO
			 , P.PNAME
			FROM COURSE c 
			JOIN PROFESSOR p 
			  ON C.PNO = P.PNO
	) A
	JOIN SCORE SC
	  ON A.CNO = SC.CNO;
			
-- 서브쿼리는 그룹함수와 주로 사용된다.

	 
-- 학생번호, 학생이름, 과목번호, 과목이름, 기말고사 성적, 기말고사 등급, 교수 번호, 교수 이름을 조회하는데
-- STUDENT, SCORE, SCGRDE 테이블의 내용을 서브쿼리 1
-- COURSE, PROFESSOR 테이블의 내용을 서브쿼리2
SELECT A.SNO
	 , A.SNAME
	 , B.CNO
	 , B.CNAME
	 , A.RESULT
	 , A.GRADE
	 , B.PNO
	 , B.PNAME
	FROM (
			SELECT S.SNO
	 			 , S.SNAME
	 			 , SC.RESULT
	 			 , SC.CNO
	 			 , SCG.GRADE
	 			FROM STUDENT s 
	 			JOIN SCORE SC
	 			  ON S.SNO = SC.SNO
	 			JOIN SCGRADE SCG
	 			  ON SC.RESULT BETWEEN SCG.LOSCORE AND SCG.HISCORE
		 ) A
	JOIN (
			SELECT C.CNO
	 		     , C.CNAME
	 		     , P.PNO
	 			 , P.PNAME
	 			FROM COURSE c 
	 			JOIN PROFESSOR p 
	 			  ON C.PNO = P.PNO
		 ) B
	 ON A.CNO = B.CNO
	 ORDER BY SNO;
	 
	 
	 
	 