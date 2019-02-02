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
         films_omdb.award_noms, 
         films_omdb.award_wins, 
         films_omdb.oscar_noms, 
         films_omdb.oscar_wins 
  FROM   films_wiki 
         join films_omdb 
           ON films_wiki.id = films_omdb.id 
         join financial_summary 
           ON financial_summary.film_id = films_wiki.id;

SELECT * FROM film_view1;