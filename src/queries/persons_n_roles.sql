-- see the number of roles that person has occupied between 2010-2018 
CREATE OR replace VIEW "persons_n_roles" 
AS 
  (SELECT persons.id, 
          persons.full_name, 
          Count(film_persons.ROLE)                AS total_roles, 
          Count(DISTINCT( film_persons.film_id )) AS distinct_films, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Actor' THEN 1 
                ELSE 0 
              END)                                AS acting_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Director' THEN 1 
                ELSE 0 
              END)                                AS directing_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Producer' THEN 1 
                ELSE 0 
              END)                                AS producing_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Writer' THEN 1 
                ELSE 0 
              END)                                AS writing_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Editor' THEN 1 
                ELSE 0 
              END)                                AS editing_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Screenwriter' THEN 1 
                ELSE 0 
              END)                                AS screenwriting_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Story' THEN 1 
                ELSE 0 
              END)                                AS story_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Composer' THEN 1 
                ELSE 0 
              END)                                AS composing_roles, 
          SUM(CASE 
                WHEN film_persons.ROLE = 'Narrator' THEN 1 
                ELSE 0 
              END)                                AS narrating_roles 
   FROM   persons 
          join film_persons 
            ON film_persons.person_id = persons.id 
   GROUP  BY persons.id, 
             persons.full_name); 

SELECT * 
FROM   persons_n_roles;