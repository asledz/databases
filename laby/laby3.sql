-- Anita Śledź
-- Rozwiązanie zadań https://www.mimuw.edu.pl/~oski/bd/lab03.php

@demobld.sql
set linesize 100

-- Zadanie 1.

-- dla każdego stanowiska wyznacz liczbę pracowników i średnią płacę
SELECT job, COUNT(empno) as numEmpl, AVG(sal) as averageSalary FROM emp GROUP BY job; 

-- dla każdego departamentu z pracownikami wypisz ilu spośród nich ma prowizję (comm)
SELECT deptno, sum(CASE WHEN comm > 0 THEN 1 ELSE 0 END) as emplWithComm/*, COUNT(empno) */ FROM emp GROUP BY deptno;

-- znajdź maksymalną pensję na wszystkich stanowiskach na których pracuje 
-- co najmniej 3 pracowników zarabiających co najmniej 1000
SELECT job, MAX(sal) FROM emp WHERE (sal > 1000) GROUP BY job HAVING count(empno) >= 3;

-- znajdź wszystkie miejsca w których rozpiętość pensji w tym samym departamencie 
-- na tym samym stanowisku przekracza 300
SELECT deptno, job, (MAX(sal) - MIN(sal)) as rozpietosc FROM emp GROUP BY deptno, job HAVING (MAX(sal) - MIN(sal) <= 300);

-- policz średnie zarobki w departamencie w którym pracuje szef
-- wszystkich szefów (czyli osoba która nie ma szefa)
SELECT 
	deptno
	, AVG(emp.sal) as averageSal
FROM 
	emp JOIN 
	(SELECT emp.deptno as okr FROM emp LEFT JOIN emp mgr ON emp.mgr = mgr.empno WHERE mgr.empno IS NULL) okregi 
ON okregi.okr = emp.deptno 
GROUP BY emp.deptno;
-- SELECT emp.deptno FROM emp LEFT JOIN emp mgr ON emp.mgr = mgr.empno WHERE mgr.empno IS NULL;

-- znajdź numer pracownika który ma podwładnych w różnych działach
SELECT
	mgrno
	, mgrname
	, COUNT(subdep)
FROM (
	SELECT DISTINCT
		mgr.empno as mgrno
		, mgr.ename as mgrname
		, sub.deptno as subdep
	FROM emp mgr JOIN emp sub ON mgr.empno = sub.mgr
) 
GROUP BY mgrno, mgrname
HAVING COUNT(subdep) > 1;

-- wypisz imiona oraz pensje wszystkich pracowników którzy nie mają zmiennika 
-- (osoby na tym samym stanowisku w tym samym departamencie) i posortuj ich według pensji malejąco

SELECT 
	ename
	, sal
FROM emp JOIN (
	SELECT 
		deptno
		, job
	FROM emp
	GROUP BY deptno, job
	HAVING COUNT(empno) = 1
) a1 ON a1.deptno = emp.deptno AND a1.job = emp.job ORDER BY sal DESC;

-- Zadanie 2.

-- wypisz imiona wszystkich podwładnych KING'a (razem z nim) w taki sposób aby uzyskać strukturę drzewa:

SELECT
	CONCAT(rpad(' ', poziom, ' '), ename) as Tree
FROM
(
	SELECT ename, PRIOR ename AS mgr_ename, LEVEL AS poziom
	FROM emp
	START WITH mgr IS NULL
	CONNECT BY PRIOR empno = mgr
);
-- Inne rozwiązanie

SELECT CONCAT(LPAD(' ',LEVEL-1),ename)
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr;

-- wypisz wszystkich podwładnych KING'a bez niego
SELECT ename
FROM emp 
WHERE LEVEL>1 
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr;

-- wypisz wszystkich podwładnych KING'a bez BLAKE'a i jego podwładnych
SELECT ename
FROM emp 
WHERE LEVEL>1 
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr AND ename != 'BLAKE';

-- wypisz wszystkich pracowników którzy mają "pod sobą" SALESMANa
SELECT DISTINCT CONNECT_BY_ROOT ename
FROM emp
WHERE job = 'SALESMAN'
CONNECT BY PRIOR empno = mgr;

-- wypisz dla każdego pracownika sumę zarobków jego i jego podwładnych
SELECT max(CONNECT_BY_ROOT ename), SUM(sal)
FROM emp
CONNECT BY PRIOR empno=mgr
GROUP BY (CONNECT_BY_ROOT ename);
