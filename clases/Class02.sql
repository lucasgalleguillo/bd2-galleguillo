DROP DATABASE IF EXISTS imdb;
CREATE DATABASE IF NOT EXISTS imdb;
USE imdb;

CREATE TABLE IF NOT EXISTS film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    release_year INT
);

CREATE TABLE IF NOT EXISTS actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS film_actor (
    actor_id INT,
    film_id INT,
    PRIMARY KEY (actor_id, film_id)
);

ALTER TABLE film
ADD COLUMN last_update_film DATETIME DEFAULT NOW();

ALTER TABLE actor
ADD COLUMN last_update_actor DATETIME DEFAULT NOW();

ALTER TABLE film_actor
ADD FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
ADD FOREIGN KEY (film_id) REFERENCES film(film_id);

INSERT INTO actor (first_name, last_name) VALUES
('Ricardo', 'Darín'),
('Julieta', 'Díaz'),
('Guillermo', 'Francella');

INSERT INTO film (title, description, release_year) VALUES
('El secreto de sus ojos', 'Un thriller de drama policial', 2009),
('El hijo de la novia', 'Una comedia dramática sobre la vida familiar', 2001),
('Nueve Reinas', 'Un thriller de estafadores', 2000);

INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1), -- Ricardo Darín
(2, 1), -- Julieta Díaz
(1, 2), -- Ricardo Darín
(3, 3); -- Guillermo Francella

