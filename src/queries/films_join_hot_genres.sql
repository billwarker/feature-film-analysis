-- join film_view1 on genres_one_hot to get films with with all genres one-hot encoded.

SELECT * 
FROM   film_view1 
       JOIN genres_one_hot 
         ON film_view1.id = genres_one_hot.id 