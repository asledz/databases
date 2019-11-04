
@seriale.sql
set linesize 100

-- 1.
select postac.postac, kanal.nazwa from postac JOIN serial on postac.idserialu = serial.idserialu JOIN kanal ON serial.idkanalu = kanal.idkanalu;

/*

POSTAC					 NAZWA
---------------------------------------- ----------------------------------------
Ross					 NBC
Rachel					 NBC
Chandler				 NBC
Monica					 NBC
Phoebe					 NBC
Joey					 NBC
Frank Underwood 			 Netflix
Claire Underwood			 Netflix
Tony Soprano				 HBO
Ned Stark				 HBO
Cersei Lanister 			 HBO

POSTAC					 NAZWA
---------------------------------------- ----------------------------------------
Daenerys Targaryen			 HBO
Walter White				 AMC
Jesse Pinkman				 AMC
Skyler					 AMC
Jim Halpert				 NBC
Michael Scott				 NBC


*/

-- 2.
SELECT serial.nazwa, count(postac.postac) from postac 
JOIN serial on postac.idserialu = serial.idserialu WHERE postac.ginie = 'tak' GROUP BY serial.nazwa;

/*

NAZWA					 COUNT(POSTAC.POSTAC)
---------------------------------------- --------------------
Friends 						    2
Game of Thrones 					    3
House of Cards						    1
The Office						    1
Breaking Bad						    1

*/


-- 3.

SELECT 
kanal.nazwa
, serial.nazwa
, count(postac.postac) "ilepostaci"
FROM 
kanal 
LEFT JOIN serial on kanal.idkanalu = serial.idkanalu 
LEFT JOIN postac on serial.idserialu = postac.idserialu
GROUP BY kanal.nazwa, serial.nazwa HAVING count(postac.postac) = 0;

/*
NAZWA					 NAZWA					  ilepostaci
---------------------------------------- ---------------------------------------- ----------
Fox											   0
HBO					 The Wire					   0

*/

-- 4.

SELECT kanal.nazwa
, nvl(avg(serial.ocena),0) "srednia ocen"
FROM 
kanal 
LEFT JOIN serial on kanal.idkanalu = serial.idkanalu
GROUP BY kanal.nazwa;

/* 

NAZWA					 srednia ocen
---------------------------------------- ------------
Netflix 					   10
AMC						    9
NBC						    9
HBO					   6.33333333
Fox						    0


*/


--5.
SELECT kanal.nazwa
, serial.nazwa
FROM 
kanal 
JOIN (
SELECT kanal.nazwa
, kanal.idkanalu
, count (serial.idserialu)
FROM 
kanal
LEFT JOIN serial on kanal.idkanalu = serial.idkanalu
WHERE serial.rokkoniec IS NULL
GROUP BY kanal.nazwa, kanal.idkanalu HAVING count(serial.idserialu) = 1
) a1 ON a1.idkanalu = kanal.idkanalu
LEFT JOIN serial on kanal.idkanalu = serial.idkanalu
WHERE serial.rokkoniec IS NULL
;

/*
NAZWA					 NAZWA
---------------------------------------- ----------------------------------------
Netflix 				 House of Cards
HBO					 Game of Thrones
*/

--6

SELECT postac.postac, a1.nazwa FROM
postac
JOIN (SELECT * FROM serial WHERE ocena = (SELECT MAX(ocena) FROM serial)) a1
ON a1.idserialu = postac.idserialu;

/*

POSTAC					 NAZWA
---------------------------------------- ----------------------------------------
Ross					 Friends
Rachel					 Friends
Chandler				 Friends
Monica					 Friends
Phoebe					 Friends
Joey					 Friends
Frank Underwood 			 House of Cards
Claire Underwood			 House of Cards
*/

--7

SELECT serial.nazwa as seriall
, a3.nazwa as najlepszyserial
FROM 
serial
JOIN
( 
SELECT a1.idkanalu
, a1.nazwa
FROM
serial a1
JOIN
(
SELECT idkanalu
, MAX(ocena) as maxocena
FROM 
serial
GROUP BY idkanalu
) a2
ON a1.idkanalu = a2.idkanalu AND a1.ocena = a2.maxocena
) a3 
on serial.idkanalu = a3.idkanalu;


/*
SERIALL 				 NAJLEPSZYSERIAL
---------------------------------------- ----------------------------------------
Friends 				 Friends
House of Cards				 House of Cards
The Sopranos				 The Wire
Game of Thrones 			 The Wire
Breaking Bad				 Breaking Bad
The Office				 Friends
The Wire				 The Wire


*/
--8
