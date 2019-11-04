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