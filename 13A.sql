use movies_db;

SELECT count(*)
FROM movies;

SELECT sum(length)
FROM movies
WHERE rating > 9;

SELECT avg(length)
FROM movies;

SELECT min(rating)
FROM movies;

SELECT max(length)
FROM movies;

SELECT genre_id, count(*), avg(length) 
FROM movies
GROUP BY genre_id;

SELECT rating, count(*) as total
FROM movies
GROUP BY rating
ORDER BY total desc, rating desc;

SELECT *
FROM movies;

SELECT rating, count(*) as total
FROM movies
GROUP BY rating
HAVING total > 1
ORDER BY total desc, rating desc;