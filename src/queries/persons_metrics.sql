-- show aggregate statistics for each person

SELECT persons.id, persons.full_name, 
       MODE() 
         within GROUP (ORDER BY film_persons.role) AS most_common_role,
       MODE() 
         within GROUP (ORDER BY companies.company) AS most_common_company,
       Count(DISTINCT( film_persons.film_id ))     AS film_count, 
       Avg(financial_summary.total_gross)          AS avg_gross, 
       Avg(financial_summary.budget)               AS avg_budget, 
       Avg(roi)                                    AS avg_roi, 
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
GROUP  BY persons.id, full_name