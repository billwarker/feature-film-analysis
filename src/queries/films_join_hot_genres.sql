-- join film_view1 and financial_summary on genres_one_hot to get films with with all genres one-hot encoded.

SELECT fv.id,
       fv.title,
       released,
       rated,
       award_noms,
       award_wins,
       oscar_noms,
       oscar_wins,
       ratings_imdb,
       ratings_tomatoes,
       ratings_meta,
       fs.budget,
       domestic_gross,
       foreign_gross,
       domestic_pct,
       foreign_pct,
       fs.total_gross,
       fs.roi,
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
FROM   film_view1 fv
       JOIN financial_summary fs 
         ON fv.id=fs.film_id
       JOIN genres_one_hot g
         ON fv.id = g.id