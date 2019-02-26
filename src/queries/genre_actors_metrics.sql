-- avg metrics for actors in each genre

with person_metrics
AS
(SELECT persons.id, persons.full_name, 
       MODE() 
         within GROUP (ORDER BY film_persons.role) AS most_common_role,
       MODE() 
         within GROUP (ORDER BY companies.company) AS most_common_company,
       Count(DISTINCT( film_persons.film_id ))     AS film_count, 
       Avg(financial_summary.total_gross)          AS avg_gross, 
       Avg(financial_summary.budget)               AS avg_budget, 
       Avg(financial_summary.roi)                                    AS avg_roi, 
       Avg(ratings_meta)                           AS avg_meta_rating, 
       Avg(ratings_imdb)                           AS avg_imdb_rating, 
       Avg(ratings_tomatoes)                       AS avg_tomatoes_rating
FROM   film_view1 
       join financial_summary 
              ON financial_summary.film_id = film_view1.id 
       join film_persons 
               ON film_persons.film_id = film_view1.id 
       join persons 
              ON film_persons.person_id = persons.id
       join film_companies
              ON film_companies.film_id = film_view1.id
       join companies
              ON film_companies.company_id = companies.id
GROUP  BY persons.id, full_name)
select genre,
       Avg(film_count) as avg_film_count,
       Avg(avg_budget) as avg_budget,
       Avg(avg_roi) as avg_roi,
       Avg(avg_meta_rating) as avg_meta,
       Avg(avg_imdb_rating) as avg_imdb,
       Avg(avg_tomatoes_rating) as avg_tomatoes
FROM person_metrics
       JOIN film_persons
         ON person_metrics.id=film_persons.person_id
       JOIN film_genres 
         ON film_genres.film_id = film_persons.film_id 
       JOIN genres
         ON genres.id = film_genres.genre_id 
WHERE  film_persons.role = 'Actor'
GROUP BY genre;

    --    JOIN persons_n_roles 
    --      ON persons_n_roles.id = film_persons.person_id



-- -- avg number of films for actors in each genre 
-- SELECT genre, 
--        Avg(acting_roles) AS actor_avg_roles,
--        Stddev(acting_roles) AS stddev
-- FROM   genres 
--        JOIN film_genres 
--          ON genres.id = film_genres.genre_id 
--        JOIN film_persons 
--          ON film_genres.film_id = film_persons.film_id 
--        JOIN persons_n_roles 
--          ON persons_n_roles.id = film_persons.person_id 
-- WHERE  film_persons.role = 'Actor' 
-- GROUP  BY genre;