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