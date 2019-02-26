-- select everything from film_view1 for each film's genre.
-- allows for summary statistics by grouping on genre.

SELECT * 
FROM   film_view1 
       JOIN film_genres 
         ON film_view1.id = film_genres.film_id 
       JOIN genres 
         ON film_genres.genre_id = genres.id