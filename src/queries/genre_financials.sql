SELECT film_view1.id,
       film_view1.title,
       genres.genre,
       financial_summary.budget,
       financial_summary.domestic_gross,
       financial_summary.foreign_gross,
       financial_summary.total_gross,
       financial_summary.roi 
FROM   film_view1 
       JOIN film_genres 
         ON film_view1.id = film_genres.film_id 
       JOIN genres 
         ON film_genres.genre_id = genres.id
       JOIN financial_summary
         ON film_view1.id = financial_summary.film_id
