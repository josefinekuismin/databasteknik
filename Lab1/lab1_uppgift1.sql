-- Skapar tabell för filmer
CREATE TABLE movies(
    movie_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL, 
    releaseyear INTEGER NOT NULL
);

-- Skapar tabell för skådespelare
CREATE TABLE actors (
    actor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Skapar tabell som kopplar ihop filmer och skådespelare
CREATE TABLE movie_actor (
    movie_id INTEGER REFERENCES movies(movie_id),
    actor_id INTEGER REFERENCES actors(actor_id),
    PRIMARY KEY (movie_id, actor_id)
);

-- Filmer som läggs till i movies-tabellen
INSERT INTO movies (title, releaseyear)
VALUES
    ('The Hunger Games', 2012),
    ('Titanic', 1997),
    ('Inception', 2010),
    ('Don`t Look Up', 2021),
    ('American Hustle', 2013),
    ('A Star is Born', 2018),
    ('Divergent', 2014),
    ('The Fault in our Stars', 2014);

-- Lägger till skådespelare i actors-tabellen
INSERT INTO actors (name)
VALUES
    ('Leonardo DiCaprio'),
    ('Jennifer Lawrence'),
    ('Bradley Cooper'),
    ('Kate Winslet'),
    ('Shailene Woodley');

-- Select för att hämta data från de 2 tabellerna och se att allt stämmer
SELECT * FROM movies;

SELECT * FROM actors;

-- Koppla rätt skådespelare till filmen The Hunger Games
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'The Hunger Games'
    AND actors.name = 'Jennifer Lawrence'
);

-- Koppla rätt skådespelare till filmen Titanic
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Titanic'
    AND actors.name = 'Kate Winslet'
);
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Titanic'
    AND actors.name = 'Leonardo DiCaprio'
);

-- Koppla rätt skådespelare till filmen Divergent
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Divergent'
    AND actors.name = 'Kate Winslet'
);
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Divergent'
    AND actors.name = 'Shailene Woodley'
);

-- Koppla rätt skådespelare till filmen Inception
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Inception'
    AND actors.name = 'Leonardo DiCaprio'
);

-- Koppla rätt skådespelare till filmen Don't Look Up
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Don`t Look Up'
    AND actors.name = 'Leonardo DiCaprio'
);
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'Don`t Look Up'
    AND actors.name = 'Kate Winslet'
);

-- Koppla rätt skådespelare till filmen American Hustle
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'American Hustle'
    AND actors.name = 'Jennifer Lawrence'
);
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'American Hustle'
    AND actors.name = 'Bradley Cooper'
);

-- Koppla rätt skådespelare till filmen A Star is Born
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'A Star is Born'
    AND actors.name = 'Bradley Cooper'
);

-- Koppla rätt skådespelare till filmen Fault in our Stars
INSERT INTO movie_actor (
    SELECT movies.movie_id, actors.actor_id
    FROM movies, actors
    WHERE movies.title = 'The Fault in our Stars'
    AND actors.name = 'Shailene Woodley'
);

SELECT * FROM movie_actor;

-- Kunna se titeln på filmen och skådespelarens namn istället för id-nummer
SELECT movies.title, actors.name
FROM movie_actor
JOIN movies
    ON movie_actor.movie_id = movies.movie_id
JOIN actors
    ON movie_actor.actor_id = actors.actor_id;

-- Test av ON DELETE CASCADE för reflektionsuppgiften

-- Tar bort den gamla främmande nyckeln mellan movie_actor och movies
ALTER TABLE movie_actor
DROP CONSTRAINT movie_actor_movie_id_fkey;

-- Skapar en ny främmande nyckel med ON DELETE CASCADE
-- Detta gör att kopplingarna i movie_actor tas bort automatiskt om en film raderas
ALTER TABLE movie_actor
ADD CONSTRAINT movie_actor_movie_id_fkey
FOREIGN KEY (movie_id)
REFERENCES movies(movie_id)
ON DELETE CASCADE;

-- Kontrollerar vilka skådespelare som är kopplade till filmen med movie_id 2
SELECT * FROM movie_actor
WHERE movie_id = 2;

-- Tar bort filmen med movie_id 2 från movies
-- ON DELETE CASCADE gör att filmens kopplingar i movie_actor också tas bort
DELETE FROM movies
WHERE movie_id = 2;

-- Kontrollerar att kopplingarna till den borttagna filmen har försvunnit
SELECT * FROM movie_actor;

-- Kontrollerar att skådespelarna fortfarande finns kvar i actors
SELECT * FROM actors;