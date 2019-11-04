-- Anita Śledźs

set linesize 100


-- Zadanie 1.
SELECT z.nazwa,
       Count(zal.od) zaleznosc
FROM   zadanie z
       LEFT JOIN zalezy zal
              ON z.nazwa = zal.co
GROUP  BY z.nazwa
ORDER  BY zaleznosc DESC,
          z.nazwa;  

-- Zadanie 2.
SELECT a1.projekt
FROM   (SELECT z.projekt,
               Max(z.koniec) - Min(z.poczatek) iletrwa
        FROM   zadanie z
        GROUP  BY z.projekt) a1
       JOIN (SELECT z.projekt,
                    Sum(( z.koniec - z.poczatek ) * z.osoby) lrg
             FROM   zadanie z
             GROUP  BY z.projekt) a2
         ON a1.projekt = a2.projekt
WHERE  iletrwa > lrg;  

-- Zadanie 3.
-- Chyba źle!!!
SELECT z.nazwa,
       Max(Nvl(( CASE
                   WHEN z.osoby > zadanka.osoby THEN z.osoby
                   ELSE zadanka.osoby
                 END ), z.osoby)) maksymalna
FROM   zadanie z
       LEFT JOIN zalezy zal
              ON z.nazwa = zal.co
       LEFT JOIN zadanie zadanka
              ON zal.od = zadanka.nazwa
GROUP  BY z.nazwa;  


-- Zadanie 4

SELECT projekt,
       Count(nazwa)
FROM   (SELECT z.projekt,
               z.nazwa,
               z.procent,
               Nvl(Min(zadanka.procent), 100) zalezne
        FROM   zadanie z
               left join zalezy zal
                      ON z.nazwa = zal.co
               left join zadanie zadanka
                      ON zal.od = zadanka.nazwa
        GROUP  BY z.projekt,
                  z.nazwa,
                  z.procent
        HAVING Nvl(Min(zadanka.procent), 100) = 100)
WHERE  procent < 100
GROUP  BY projekt;  


-- Zadanie 5

SELECT nazwa
FROM   (SELECT nazwa,
               LEVEL poziom
        FROM   (SELECT z.nazwa,
                       zal.co
                FROM   zadanie z
                       left join zalezy zal
                              ON z.nazwa = zal.od)
        CONNECT BY PRIOR nazwa = co)
GROUP  BY nazwa
ORDER  BY Max(poziom) ASC,
          nazwa;  