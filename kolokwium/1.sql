-- Zadanie 1.
SELECT z.nazwa,
       Count(zal.od) zaleznosc
FROM   zadanie z
       LEFT JOIN zalezy zal
              ON z.nazwa = zal.co
GROUP  BY z.nazwa
ORDER  BY zaleznosc DESC,
          z.nazwa;  