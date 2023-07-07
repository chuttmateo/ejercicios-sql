USE movies_db;
#Utilizando la base de datos de movies, queremos conocer, por un lado, los
#títulos y el nombre del género de todas las series de la base de datos.
SELECT title, name
FROM series 
INNER JOIN genres ON series.genre_id = genres.id;

#Por otro, necesitamos listar los títulos de los episodios junto con el nombre y
#apellido de los actores que trabajan en cada uno de ellos.
SELECT episodes.title, CONCAT(actors.first_name, " ", actors.last_name) AS "Nombre y apellido"
FROM episodes
INNER JOIN actor_episode ON episodes.id = actor_episode.episode_id
INNER JOIN actors ON actor_episode.actor_id = actors.id;

#Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices (mostrar nombre y apellido) 
#que han trabajado en cualquier película de la saga de La Guerra de las galaxias.
SELECT  CONCAT(actors.first_name, " ", actors.last_name) AS "Nombre y apellido", title
FROM movies
INNER JOIN actor_movie ON movies.id = actor_movie.movie_id
INNER JOIN actors ON actor_movie.actor_id = actors.id
WHERE movies.title LIKE '%Guerra de las galaxias%';

#Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.
SELECT genres.name, COUNT(*) AS Peliculas
FROM movies
INNER JOIN genres ON genres.id = movies.genre_id
GROUP BY genre_id;



