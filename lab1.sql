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