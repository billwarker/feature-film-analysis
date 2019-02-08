SELECT * 
FROM   persons_per_role 
       JOIN film_genres 
         ON persons_per_role.id = film_genres.film_id 
       JOIN genres 
         ON film_genres.genre_id = genres.id;
