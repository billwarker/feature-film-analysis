-- one hot encoding for all of the possible genres

CREATE OR replace VIEW "genres_one_hot"
AS
    WITH titles_by_genre 
        AS (SELECT films.id, 
                    genre 
            FROM   films 
                    JOIN film_genres 
                    ON films.id = film_genres.film_id 
                    JOIN genres 
                    ON genres.id = film_genres.genre_id) 
    SELECT id, 
        Count(CASE 
                WHEN genre = 'Horror' THEN 1 
                END) AS "horror", 
        Count(CASE 
                WHEN genre = 'Mystery' THEN 1 
                END) AS "mystery", 
        Count(CASE 
                WHEN genre = 'Thriller' THEN 1 
                END) AS "thriller", 
        Count(CASE 
                WHEN genre = 'Action' THEN 1 
                END) AS "action", 
        Count(CASE 
                WHEN genre = 'Crime' THEN 1 
                END) AS "crime", 
        Count(CASE 
                WHEN genre = 'Drama' THEN 1 
                END) AS "drama", 
        Count(CASE 
                WHEN genre = 'Comedy' THEN 1 
                END) AS "comedy", 
        Count(CASE 
                WHEN genre = 'History' THEN 1 
                END) AS "history", 
        Count(CASE 
                WHEN genre = 'War' THEN 1 
                END) AS "war", 
        Count(CASE 
                WHEN genre = 'Music' THEN 1 
                END) AS "music", 
        Count(CASE 
                WHEN genre = 'Romance' THEN 1 
                END) AS "romance", 
        Count(CASE 
                WHEN genre = 'Sci-Fi' THEN 1 
                END) AS "sci-fi", 
        Count(CASE 
                WHEN genre = 'Biography' THEN 1 
                END) AS "biography", 
        Count(CASE 
                WHEN genre = 'Fantasy' THEN 1 
                END) AS "fantasy", 
        Count(CASE 
                WHEN genre = 'Animation' THEN 1 
                END) AS "animation", 
        Count(CASE 
                WHEN genre = 'Adventure' THEN 1 
                END) AS "adventure", 
        Count(CASE 
                WHEN genre = 'Family' THEN 1 
                END) AS "family", 
        Count(CASE 
                WHEN genre = 'Sport' THEN 1 
                END) AS "sport", 
        Count(CASE 
                WHEN genre = 'Western' THEN 1 
                END) AS "western", 
        Count(CASE 
                WHEN genre = 'Documentary' THEN 1 
                END) AS "documentary", 
        Count(CASE 
                WHEN genre = 'Musical' THEN 1 
                END) AS "musical" 
    FROM   titles_by_genre 
    GROUP  BY id
    ORDER  BY id;
SELECT * FROM "genres_one_hot";