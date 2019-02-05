-- show common film metrics for each film's genre.
-- allows for summary stats by grouping on genre column.

SELECT  film_view1.id,
        film_view1.title,
        rated,
        genre,
        runtime,
        financial_summary.budget,
        financial_summary.total_gross,
        award_noms,
        award_wins,
        oscar_noms,
        oscar_wins,
        ratings_imdb,
        ratings_meta,
        ratings_tomatoes,
        domestic_gross,
        foreign_gross,
        domestic_pct,
        foreign_pct,
        roi
FROM    film_view1 
        JOIN film_genres 
          ON film_view1.id = film_genres.film_id 
        JOIN genres 
          ON film_genres.genre_id = genres.id
        JOIN financial_summary
          ON film_view1.id = financial_summary.film_id;