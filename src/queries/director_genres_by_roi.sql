-- directors ordered by roi with most frequent genre shown 
SELECT persons.id, 
       persons.full_name, 
       Avg(roi)                                AS avg_roi, 
       Count(DISTINCT( film_persons.film_id )) AS film_count, 
       MODE() 
         within GROUP (ORDER BY genres.genre)  AS most_common_genre 
FROM   film_view1 
       join financial_summary 
         ON financial_summary.film_id = film_view1.id 
       join film_persons 
         ON film_persons.film_id = film_view1.id 
       join persons 
         ON film_persons.person_id = persons.id 
       join film_genres 
         ON film_genres.film_id = film_view1.id 
       join genres 
         ON film_genres.genre_id = genres.id 
GROUP  BY persons.id, 
          persons.full_name, 
          film_persons.ROLE 
HAVING Avg(roi) IS NOT NULL 
       AND film_persons.ROLE = 'Director' 
ORDER  BY Avg(roi) DESC;