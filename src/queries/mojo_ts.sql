-- create views for each film's opening weekend and total domestic windows
-- query those joined with financial_summary and genre for full financials
-- of each film plus its genre

CREATE OR replace VIEW opening_weekend
AS
(SELECT id, 
       Sum(gross)        AS opening_weekend, 
       Avg(num_theatres) AS num_theatres 
FROM   mojo_daily 
WHERE  gross IN (SELECT gross 
                 FROM   mojo_daily 
                 WHERE  mojo_daily.day IN ( 'Fri', 'Sat', 'Sun' ) 
                        AND num_day < 7) 
       AND num_theatres IN (SELECT num_theatres 
                            FROM   mojo_daily 
                            WHERE  mojo_daily.day IN ( 'Fri', 'Sat', 'Sun' ) 
                                   AND num_day < 7) 
GROUP  BY id 
ORDER  BY id);

CREATE OR replace VIEW release_window
AS
(SELECT id, 
       Max(num_day) AS window 
FROM   mojo_daily 
GROUP  BY id);

SELECT financial_summary.film_id,
       title,
       budget,
       domestic_gross,
       foreign_gross,
       domestic_pct,
       foreign_pct,
       total_gross,
       roi,
       opening_weekend,
       num_theatres,
       release_window.window,
       genre
FROM financial_summary
JOIN opening_weekend
  ON financial_summary.film_id=opening_weekend.id
JOIN release_window
  ON release_window.id=financial_summary.film_id
JOIN film_genres
  ON film_genres.film_id=financial_summary.film_id
JOIN genres
  ON genres.id=film_genres.genre_id;