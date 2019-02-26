-- avg number of films for actors in each genre 
SELECT genre, 
       Avg(acting_roles) AS actor_avg_roles,
       Stddev(acting_roles) AS stddev
FROM   genres 
       JOIN film_genres 
         ON genres.id = film_genres.genre_id 
       JOIN film_persons 
         ON film_genres.film_id = film_persons.film_id 
       JOIN persons_n_roles 
         ON persons_n_roles.id = film_persons.person_id 
WHERE  film_persons.role = 'Actor' 
GROUP  BY genre;