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
