-- Anita Śledź
-- Rozwiązanie zadań https://www.mimuw.edu.pl/~oski/bd/lab02.php

@demobld.sql
set linesize 100

-- w jakim mieście pracują sprzedawcy (salesman)?
SELECT DISTINCT dept.loc FROM emp JOIN dept ON dept.deptno = emp.deptno WHERE emp.job = 'SALESMAN';

-- dla każdego pracownika podaj nazwisko jego przełożonego (lub NULL jeżeli nie ma szefa)
SELECT sub.ename as pracownik, mgr.ename as manager FROM emp sub LEFT JOIN emp mgr ON sub.mgr = mgr.empno ;

-- dla każdego pracownika podaj miasto w jakim pracuje jego przełożony (lub NULL jeżeli nie ma szefa)
SELECT sub.ename as pracownik, mg.ename as manager, dept.loc as [miasto managera] FROM emp sub LEFT JOIN emp mgr ON sub.mgr =
mgr.empno LEFT JOIN dept ON mgr.deptno = dept.deptno;

-- w którym departamencie nikt nie pracuje?
SELECT dept.* FROM dept LEFT JOIN emp ON emp.deptno = dept.deptno WHERE emp.empno IS NULL;

-- dla każdego pracownika wypisz imię jego szefa jeżeli (ten szef) zarabia więcej niż 3000 (lub NULL jeżeli nie ma takiego szefa)
SELECT
sub.ename as pracownik
, (CASE WHEN mgr.sal > 3000 THEN mgr.ename END) as Manager
FROM emp sub
LEFT JOIN emp mgr ON sub.mgr = mgr.empno ;

-- który pracownik pracuje w firmie najdłużej?
SELECT * FROM emp WHERE rownum = 1 ORDER BY hiredate;
SELECT * FROM emp WHERE hiredate = (SELECT MIN(hiredate) FROM emp);
SELECT * FROM emp JOIN (SELECT MIN(hiredate) as firstdate FROM emp) st ON st.firstdate = emp.hiredate;
