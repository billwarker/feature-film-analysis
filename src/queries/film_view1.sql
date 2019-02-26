--main view for seeing films

CREATE OR replace VIEW film_view1 
AS 
  SELECT films_wiki.id, 
         films_wiki.title, 
         ( CASE 
             WHEN films_wiki.released IS NULL THEN films_omdb.released 
             ELSE films_wiki.released 
           END ) AS released, 
         ( CASE 
             WHEN films_omdb.runtime IS NULL THEN films_wiki.running_time 
             ELSE films_omdb.runtime 
           END ) AS runtime, 
         films_omdb.rated, 
         financial_summary.budget, 
         financial_summary.total_gross,
         financial_summary.roi
         films_omdb.award_noms, 
         films_omdb.award_wins, 
         films_omdb.oscar_noms, 
         films_omdb.oscar_wins,
         films_omdb.ratings_imdb,
         films_omdb.ratings_meta,
         films_omdb.ratings_tomatoes,
         horror,
         mystery,
         thriller,
         action,
         crime,
         drama,
         comedy,
         history,
         war,
         music,
         romance,
         "sci-fi",
         biography,
         fantasy,
         animation,
         adventure,
         family,
         sport,
         western,
         documentary,
         musical
  FROM   films_wiki 
         join films_omdb 
           ON films_wiki.id = films_omdb.id 
         join financial_summary 
           ON financial_summary.film_id = films_wiki.id
         join genres_one_hot
           ON genres_one_hot.id = films_wiki.id;

SELECT * FROM film_view1;