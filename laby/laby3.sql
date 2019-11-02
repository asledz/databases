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

SELECT emp.deptno FROM emp LEFT JOIN emp mgr ON emp.mgr = mgr.empno WHERE mgr.empno IS NULL;


-- znajdź numer pracownika który ma podwładnych w różnych działach

-- wypisz imiona oraz pensje wszystkich pracowników którzy nie mają zmiennika 
-- (osoby na tym samym stanowisku w tym samym departamencie) i posortuj ich według pensji malejąco