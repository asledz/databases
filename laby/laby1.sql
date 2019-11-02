-- Anita Śledź
-- Rozwiązanie zadań https://www.mimuw.edu.pl/~oski/bd/lab01.php

@demobld.sql
set linesize 100


-- ZADANIE 1.3
-- Wybierz wszystkich urzędników (clerk)
SELECT * FROM emp WHERE job LIKE 'CLERK';

-- Wybierz miasta w których firma ma swoje departamenty.
SELECT DISTINCT dept.loc from dept join emp on dept.deptno = emp.deptno;

-- wybierz imiona, pensje i stanowisko wszystkich pracowników którzy: 
-- albo mają imię zaczynające się na literę T i zarabiają więcej niż 1500 i mniej niż 2000,
-- albo są analistami
SELECT ename, sal, job FROM emp WHERE (ename LIKE 'T%' AND sal > 1500 AND sal < 2000) OR (job LIKE 'ANALYST');

-- wybierz imiona pracowników którzy nie mają szefów (mgr = manager)
SELECT ename FROM emp WHERE mgr IS NULL;

-- wybierz numery wszystkich pracowników którzy mają podwładnych sortując je malejąco
SELECT DISTINCT mgr.empno, mgr.name FROM emp mgr JOIN emp subordinate ON subordinate.mgr = mgr.empno ORDER BY mgr.empno desc;

-- wybierz wszystkich pracowników i dla każdego wypisz w dodatkowej kolumnie o nazwie 'starszy' 1 jeżeli ma wcześniejsze id niż jego
-- szef, 0 jeżeli ma późniejsze, oraz '-1' jeżeli nie ma szefa
SELECT sub.ename, (case WHEN mgr.empno IS NULL THEN -1 WHEN mgr.empno < sub.empno THEN 1 ELSE 0 end) as starszy FROM emp sub LEFT JOIN
emp mgr ON sub.mgr = mgr.empno ;

-- wylicz sinus liczby 3.14
SELECT SIN(3.14) FROM DUAL;



-- ZADANIE 1.4

-- do tabeli z departamentami wstaw departament IT z Warszawy
INSERT INTO dept VALUES (50, 'IT', 'WARSAW');

-- dodaj siebie jako informatyka w tym departamencie bez przełożonego z pensją 2000
INSERT INTO emp VALUES ( (select max(empno) from emp) + 1, 'KOWALSKI', 'IT GUY', NULL, sysdate, 2000, NULL, 50);

-- daj sobie podwyżkę o kwotę podatku 23%
UPDATE emp SET sal = sal*1.23 WHERE ename = 'KOWALSKI';

-- skasuj wszystkich którzy zarabiają więcej niż Ty (więcej niż 2460)
DELETE FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'KOWALSKI');

-- okazało się, że Miller ma brata bliźniaka i przychodzą do pracy na zmianę; wstaw jego brata jako nowego pracownika z tymi samymi
-- danymi i numerem 8015 (nie przepisuj ich jednak do zapytania) po czym osobnym zapytaniem podziel ich pensje na pół
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) (SELECT 8015, ename, job, mgr, sysdate, sal, comm, deptno FROM
emp WHERE ename = 'MILLER');
UPDATE emp SET sal = sal/2 WHERE ename = 'MILLER';

-- ZADANIE 1.5

-- Stwórz tabele Student(imie, nazwisko, nr_indeksu, plec, aktywny, data_przyjecia) nie zapominając o odpowiednich warunkach na kolumny.

CREATE TABLE Student (
        imie VARCHAR2(10) NOT NULL,
        nazwisko VARCHAR2(10) NOT NULL,
        nr_indeksu NUMBER(6) PRIMARY KEY CHECK (nr_indeksu >= 100000),
        plec CHAR(1) NOT NULL CHECK (plec = 'F' OR plec = 'M'),
        aktywny NUMBER(1) NOT NULL CHECK (aktywny = 1 OR aktywny = 0),
        data_przyjecia DATE NOT NULL
);
