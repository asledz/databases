
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