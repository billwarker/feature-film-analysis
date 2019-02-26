-- select all relevant data for analyzing companies

SELECT company,
       fc.company_id,
       fc.role,
       fv1.id,
       fv1.title,
       released,
       runtime,
       rated,
       award_noms,
       award_wins,
       oscar_noms,
       oscar_wins,
       ratings_imdb,
       ratings_meta,
       ratings_tomatoes,
       fs.budget,
       fs.domestic_gross,
       fs.foreign_gross,
       fs.domestic_pct,
       fs.foreign_pct,
       fs.total_gross,
       fs.roi
FROM companies c
JOIN film_companies fc on c.id=fc.company_id
JOIN film_view1 fv1 on fc.film_id = fv1.id
JOIN financial_summary fs on fc.film_id=fs.film_id;