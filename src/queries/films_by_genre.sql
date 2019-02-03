SELECT * 
FROM   film_view1 
       JOIN film_genres 
         ON film_view1.id = film_genres.film_id 
       JOIN genres 
         ON film_genres.genre_id = genres.id 
