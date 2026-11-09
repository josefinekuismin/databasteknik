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