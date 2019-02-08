-- create persons_per_role view, which
-- displays the number of people in each role for every films

CREATE OR replace VIEW "persons_per_role" 
AS 
  (SELECT film_view1.id, 
          title,
          COUNT(film_persons.role) as total_persons,
          SUM(CASE 
                WHEN film_persons.ROLE = 'Actor' THEN 1 
                ELSE 0 
              END) AS num_actors, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Director' THEN 1 
                ELSE 0 
              END) AS num_directors, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Producer' THEN 1 
                ELSE 0 
              END) AS num_producers, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Writer' THEN 1 
                ELSE 0 
              END) AS num_writers, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Editor' THEN 1 
                ELSE 0 
              END) AS num_editors, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Screenwriter' THEN 1 
                ELSE 0 
              END) AS num_screenwriters, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Story' THEN 1 
                ELSE 0 
              END) AS num_story, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Composer' THEN 1 
                ELSE 0 
              END) AS num_composers, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Narrator' THEN 1 
                ELSE 0 
              END) AS num_narrators 
   FROM   film_view1 
          join film_persons 
            ON film_persons.film_id = film_view1.id 
          join persons 
            ON persons.id = film_persons.person_id 
   GROUP  BY film_view1.id, 
             title);

SELECT * FROM persons_per_role;