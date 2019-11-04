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

SELECT z.nazwa--,
--       zal.od,
--       Sum(a1.iletrwa)           osobodni,
--       ( z.koniec - z.poczatek ) trwa
FROM   zadanie z
       LEFT JOIN zalezy zal
              ON z.nazwa = zal.co
       LEFT JOIN (SELECT z.nazwa,
                         ( z.koniec - z.poczatek ) * z.osoby iletrwa
                  FROM   zadanie z) a1
              ON a1.nazwa = zal.od
GROUP  BY z.nazwa,
          zal.od,
          ( z.koniec - z.poczatek )
HAVING Sum(a1.iletrwa) < ( z.koniec - z.poczatek );  