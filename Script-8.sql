-- 1. INNER JOIN
-- JOIN 은 여러 테이블에 분산되어 있는 데이터를 한번에 조회하기 위해 사용하는 기능
-- JOIN 은 INNER JOIN 과 OUTER JOIN 이 존재한다.
-- JOIN 절에는 항상 공통 컬럼에 해당하는 조건을 ON 절로 만들어줘야한다.
-- INNER JOIN 은 두 테이블에 공통된 데이터를 조회하는 기능
-- 두 테이블에 존재하는 공통된 컬럼을 조인 조건으로 명시한다.
-- 학생의 학생번호, 학생이름, 과목번호, 기말고사 성적 조회
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO 
	 , SC.RESULT
	FROM STUDENT ST
	INNER JOIN SCORE SC
	   ON ST.SNO = SC.SNO
	ORDER BY ST.SNO;
	
-- 과목번호, 과목이름, 담당교수 번호, 담당교수 이름 조회(COURSE, PROFESSOR 테이블)
SELECT CO.CNO
	 , CO.CNAME
	 , PR.PNO
	 , PR.PNAME
	FROM COURSE CO
	INNER JOIN PROFESSOR PR
		ON CO.PNO = PR.PNO 
	ORDER BY CO.PNO;

-- INNER JOIN 에서 INNER 는 생략 가능하다.
SELECT CO.CNO
	 , CO.CNAME
	 , PR.PNO
	 , PR.PNAME
	FROM COURSE CO
	JOIN PROFESSOR PR
		ON CO.PNO = PR.PNO 
	ORDER BY CO.PNO;

-- 1-1. 등가 조인
-- 등가조인은 공통된 컬럼의 데이터가 같은 데이터만을 조회하는 조인
-- 사원의 사원번호, 사원이름, 업무, 급여, 보너스, 부서번호, 부서이름, 부서지역 조회
-- ANSI 표준 방식
SELECT EM.ENO
	 , EM.ENAME
	 , EM.JOB
	 , EM.SAL
	 , EM.COMM
	 , EM.DNO
	 , DE.DNAME
	 , DE.LOC
	FROM EMP EM
	JOIN DEPT DE
	  ON EM.DNO = DE.DNO
	ORDER BY EM.DNO;

-- ORACLE 에서만 사용하는 방식의 JOIN
SELECT EM.ENO
	 , EM.ENAME
	 , EM.JOB
	 , EM.SAL
	 , EM.COMM
	 , EM.DNO
	 , DE.DNAME
	 , DE.LOC
	FROM EMP EM
	   , DEPT DE
	  WHERE EM.DNO = DE.DNO;
	
-- 세개 테이블 이상의 테이블 조인
-- 학생의 학생번호, 학생이름, 과목번호, 과목이름, 기말고사성적 조회
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO
	 , C.CNAME
	 , SC.RESULT
	FROM STUDENT ST
	JOIN SCORE SC 
	  ON ST.SNO = SC.SNO
	JOIN COURSE C 
	  ON SC.CNO = C.CNO
	ORDER BY SNO;
	 

-- 학생의 학생번호, 학생이름, 과목번호, 과목이름, 기말고사성적, 담당교수 번호, 담당교수 이름 조회
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO
	 , C.CNAME
	 , SC.RESULT
	 , P.PNO
	 , P.PNAME
	FROM STUDENT ST
	JOIN SCORE SC 
	  ON ST.SNO = SC.SNO
	JOIN COURSE C 
	  ON SC.CNO = C.CNO
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO 
	ORDER BY SNO;

-- 1-2. 비등가 조인
-- 비등가 조인은 해당 컬럼의 데이터 값이 큰지 작은지, 사이값인지 부등호나 BETWEEN AND 절을 이용해서 비교하는 조인 구문
-- 학생의 학생번호, 학생이름, 과목번호, 과목이름, 기말고사 성적, 기말고사 성적의 등급 조회
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO
	 , C.CNAME
	 , SC.RESULT
	 , GR.GRADE
	FROM STUDENT ST
	JOIN SCORE SC
	  ON ST.SNO = SC.SNO 
	JOIN COURSE C
	  ON SC.CNO = C.CNO 
	JOIN SCGRADE GR
     -- 비등가 조인 사용
	  ON SC.RESULT <= GR.HISCORE 
	  AND SC.RESULT >= GR.LOSCORE
	  ORDER BY SNO, SC.CNO ;

-- BETWEEN AND 사용
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO
	 , C.CNAME
	 , SC.RESULT
	 , GR.GRADE
	FROM STUDENT ST
	JOIN SCORE SC
	  ON ST.SNO = SC.SNO 
	JOIN COURSE C
	  ON SC.CNO = C.CNO 
	JOIN SCGRADE GR
     -- 비등가 조인 사용(BETWEEN AND)
	  ON SC.RESULT BETWEEN GR.LOSCORE AND GR.HISCORE 
	  ORDER BY SNO, SC.CNO ;
	 
-- 사원의 사원번호, 사원이름, 급여, 급여 등급 조회(EMP, SALGRADE)
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 , SA.GRADE
	FROM EMP E
	JOIN SALGRADE SA
	  ON E.SAL BETWEEN SA.LOSAL AND SA.HISAL 
 	ORDER BY ENO;


-- 1-3. 셀프 조인
-- 조인되는 두 테이블이 동일할 때 셀프 조인이라고 부른다
-- 사원의 사원번호, 사원이름, 사수번호, 사수이름 조회
SELECT E.ENO
	 , E.ENAME
	 , E.MGR
	 , EM.ENAME 
	FROM EMP E
	JOIN EMP EM
	  ON E.MGR = EM.ENO
	ORDER BY ENO;
	  
-- 1-4. CROSS JOIN
-- 여러 테이블을 조인할 때 조인 조건을 지정하지 않으면 CROSS JOIN 이 일어난다.
-- CROSS JOIN 은 조인되는 모든 테이블의 데이터들이 1대1로 매핑되어 조회되는 현상이다.
-- 테이블들을 조인할 때는 항상 조인 조건을 명시하여 CROSS JOIN 이 일어나지 않도록 한다.
SELECT ST.SNO
	 , ST.SNAME
	 , SC.CNO
	 , C.CNAME
	 , SC.RESULT
	FROM STUDENT ST
		, SCORE SC
	    , COURSE C;
	    
-- 2. OUTER JOIN 
-- OUTER JOIN 은 INNER JOIN 결과에 추가로 기준이 되는 테이블에 남아있는 데이터를 조회하는 기능
-- 기준이 되는 테이블은 OUTER JOIN 앞에 LEFT, RIGHT 또는 FULL 로 지정한다.
-- LEFT 로 기준 테이블을 지정하면 FROM 절에 사용한 테이블이 기준이 되고
-- RIGHT 로 기준 테이블을 지정하면 조인되는 테이블이 기준이 된다.
-- FULL 로 기준 테이블을 지정하면 FROM 절 테이블과 조인되는 테이블 모두가 기준이 되어 INNER JOIN 결과에
-- FROM 절 테이블에만 존재하는 데이터와 조인되는 테이블에만 존재하는 데이터도 모두 추가로 조회한다.
	   
-- 2-1. LEFT OUTER JOIN	   
-- FROM 절의 테이블에만 존재하는 데이터를 추가로 조회하는 JOIN 
-- 학생의 학생번호, 학생이름, 기말고사 성적을 조회하는 데 기말고사 성적이 존재하지 않는 학생의 정보도 조회
INSERT INTO STUDENT VALUES('999999', '고기천', '남', 1, '컴공', 3.0);	
COMMIT;
	  
-- ANSI 표준 방식
SELECT ST.SNO
	 , ST.SNAME
	 , SC.RESULT
	FROM STUDENT ST
	LEFT OUTER JOIN SCORE SC
	  ON ST.SNO = SC.SNO
	 ORDER BY ST.SNO DESC;

	
-- ORACLE 에서만 사용하는 LEFT OUTER JOIN 방식 ((+)기호를 이용한다.)
-- (+) 기호는 LEFT, RIGHT OUTER JOIN 만 사용가능	
SELECT ST.SNO
	 , ST.SNAME
	 , SC.RESULT
	FROM STUDENT ST
	   , SCORE SC
	WHERE ST.SNO = SC.SNO(+)
	ORDER BY ST.SNO DESC;
	
-- 과목번호, 과목이름, 교수번호, 교수이름을 조회하는데 담당교수가 배정되지 않은 과목정보도 조회
SELECT C.CNO
	 , C.CNAME
	 , NVL(C.PNO, '담당교수 배정되지 않음') AS PNO
	 , NVL(P.PNAME,'담당교수 배정되지 않음') AS PNAME
	FROM COURSE C
	LEFT OUTER JOIN PROFESSOR P
	  ON C.PNO = P.PNO;
	 
-- 사원의 사원번호, 사원이름, 사수번호, 사수이름을 조회하는데 사수가 배정되지 않은 사원의 정보도 조회
SELECT E.ENO 
	 , E.ENAME
	 , NVL(E.MGR, '사수가 배정되지 않음') 
	 , NVL(EM.ENAME,'사수가 배정되지 않음')
	FROM EMP E
	LEFT OUTER JOIN EMP EM
	  ON E.MGR = EM.ENO
	 ORDER BY ENO;
	
-- LEFT, RIGHT, FULL OUTER JOIN 에서 OUTER 는 생략 가능하다.
SELECT E.ENO 
	 , E.ENAME
	 , NVL(E.MGR, '사수가 배정되지 않음') 
	 , NVL(EM.ENAME,'사수가 배정되지 않음')
	FROM EMP E
	LEFT JOIN EMP EM
	  ON E.MGR = EM.ENO
	 ORDER BY ENO;
	 
-- 2-2. RIGHT OUTER JOIN
-- INNER JOIN 조회 결과와 추가로 조인되는 테이블에만 존재하는 데이터를 조회하는 JOIN
-- 과목번호, 과목이름, 교수번호, 교수이름 조회하는데 아직 담당과목을 배정받지 못한 교수 정보도 조회
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	FROM COURSE C
	RIGHT JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	  ORDER BY CNO DESC;
	  
-- LEFT OUTER JOIN 으로 변경	 
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	FROM PROFESSOR P
	LEFT JOIN COURSE C
	  ON P.PNO = C.PNO
	  ORDER BY CNO DESC;
	  
-- 3. FULL OUTER JOIN
-- FULL OUTER JOIN 은 INNER JOIN 된 조회 결과에 FROM 절 테이블에만 존재하는 데이터, 조인되는 테이블에만 존재하는 데이터
-- 조인되는 테이블에만 존재하는 데이터 모두를 조회하는 JOIN
-- 과목번호, 과목이름, 교수번호, 교수이름을 조회하는데 교수가 배정되지 않은 과목과 담당과목이 배정되지 않은 교수의 정보도 모두 조회
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	FROM COURSE C
	FULL JOIN PROFESSOR P
	  ON C.PNO = P.PNO;

INSERT INTO EMP VALUES ('9999', '고기천', '개발', NULL, SYSDATE, 3000, 300, NULL);
INSERT INTO DEPT VALUES ('70', '분석', '서울', NULL);
COMMIT;
	 
-- 사원의 사원번호, 사원이름, 부서번호, 부서이름을 조회하는데 부서를 배정받지 못한 사원의 정보와 사원이 한명도 존재하지 않는
-- 부서의 정보도 모두 조회

SELECT E.ENO
	 , E.ENAME
	 , D.DNO
	 , D.DNAME
	FROM EMP E
	FULL JOIN DEPT D
	  ON E.DNO = D.DNO
	 ORDER BY ENO;

	
-- 4. 다중 테이블 조인
-- 사원의 사원번호, 사원이름, 급여, 급여등급, 부서번호, 부서이름을 조회하는데 부서를 배정받지 않은 사원의 정보도 조회
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 , GR.GRADE
	 , E.DNO
	 , D.DNAME
	FROM EMP E
	JOIN SALGRADE GR
  	  ON E.SAL BETWEEN GR.LOSAL AND GR.HISAL 
	LEFT JOIN DEPT D 
	  ON E.DNO = D.DNO;
	  
-- ON 절에도 조건을 여러개 추가할 때는 WHERE 절과 마찬가지로
-- AND, OR 을 사용해서 여러개의 조건을 명시할 수 있다.
-- 급여가 3000이상이고 부서번호가 01,10,20,60인 
-- 사원의 사원번호, 사원이름, 급여, 급여등급, 부서번호, 부서이름을 조회하는데 부서를 배정받지 않은 사원의 정보도 조회
-- OUTER JOIN 이라서 조인조건이 달라져서 다른 데이터가 나오게 된다.
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 , GR.GRADE
	 , E.DNO
	 , D.DNAME
	FROM EMP E
	JOIN SALGRADE GR
  	  ON E.SAL BETWEEN GR.LOSAL AND GR.HISAL 
  	 AND E.SAL >= 3000
	LEFT JOIN DEPT D 
	  ON E.DNO = D.DNO
	 AND E.DNO IN ('01','10','20','60');
	  
-- 다른 데이터가 조회되는 조건 (이게 맞는듯 ..?)
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 , GR.GRADE
	 , E.DNO
	 , D.DNAME
	FROM EMP E
	JOIN SALGRADE GR
  	  ON E.SAL BETWEEN GR.LOSAL AND GR.HISAL 
	LEFT JOIN DEPT D 
	  ON E.DNO = D.DNO
	WHERE E.SAL >= 3000
	  AND E.DNO IN ('01','10','20','60');	
	 
-- 학생의 학생번호, 학생이름, 과목번호, 과목이름, 기말고사 성적, 담당교수 번호, 담당교수 이름 조회
SELECT S.SNO
	 , S.SNAME
	 , C.CNO
	 , C.CNAME
	 , SC.RESULT
	 , P.PNO
	 , P.PNAME
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN COURSE C
	  ON SC.CNO = C.CNO 
	JOIN PROFESSOR P
	  ON C.PNO  = P.PNO;
	 
-- 성적등급 추가
SELECT S.SNO
	 , S.SNAME
	 , C.CNO
	 , C.CNAME
	 , SC.RESULT
	 , SCG.GRADE
	 , P.PNO
	 , P.PNAME
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN SCGRADE SCG
	  ON SC."RESULT" BETWEEN SCG.LOSCORE AND SCG.HISCORE 
	JOIN COURSE C
	  ON SC.CNO = C.CNO 
	JOIN PROFESSOR P
	  ON C.PNO  = P.PNO;
	 
	 
	 