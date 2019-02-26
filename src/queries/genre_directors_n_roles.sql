-- avg number of films for directors in each genre 
SELECT genre, 
       Avg(directing_roles) AS director_avg_roles,
       Stddev(directing_roles) AS stddev
FROM   genres 
       JOIN film_genres 
         ON genres.id = film_genres.genre_id 
       JOIN film_persons 
         ON film_genres.film_id = film_persons.film_id 
       JOIN persons_n_roles 
         ON persons_n_roles.id = film_persons.person_id 
WHERE  film_persons.role = 'Director' 
GROUP  BY genre;