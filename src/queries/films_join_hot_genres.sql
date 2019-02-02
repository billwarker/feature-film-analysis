-- join film_view1 on genres_one_hot
SELECT * 
FROM   film_view1 
       JOIN genres_one_hot 
         ON film_view1.id = genres_one_hot.id 