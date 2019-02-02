SELECT Extract(year FROM released) AS "year", 
       Count(id)                   AS "num_films" 
FROM   film_view1  
GROUP  BY 1 
ORDER  BY "year"