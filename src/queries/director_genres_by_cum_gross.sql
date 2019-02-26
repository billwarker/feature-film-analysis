-- directors ordered by cumulative total gross with most frequent genre shown 
SELECT persons.id, 
       persons.full_name,
       persons_n_roles.directing_roles         AS num_times_directing, 
       Sum(financial_summary.total_gross)      AS cumulative_total_gross, 
       MODE() 
         within GROUP (ORDER BY genres.genre)  AS most_common_genre 
FROM   financial_summary
       join film_persons 
         ON film_persons.film_id = financial_summary.film_id 
       join persons 
         ON film_persons.person_id = persons.id 
       join film_genres 
         ON film_genres.film_id = financial_summary.film_id
       join genres 
         ON film_genres.genre_id = genres.id
       join persons_n_roles
         ON persons_n_roles.id = film_persons.person_id
GROUP  BY persons.id, 
          persons.full_name,
          persons_n_roles.directing_roles,
          film_persons.role
HAVING Sum(financial_summary.total_gross) IS NOT NULL 
       AND film_persons.ROLE = 'Director' 
ORDER  BY Sum(financial_summary.total_gross) DESC;