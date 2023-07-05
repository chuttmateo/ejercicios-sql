USE movies_db;
#¿Cuántas películas hay?
SELECT count(*)
FROM movies;

#¿Cuántas películas tienen entre 3 y 7 premios?
SELECT count(*)
FROM movies
WHERE awards BETWEEN 3 AND 7;

#¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
SELECT count(*)
FROM movies
WHERE awards BETWEEN 3 AND 7
AND rating > 7;

#Crear un listado a partir de la tabla de películas, mostrar un reporte de la
#cantidad de películas por id. de género.
SELECT genre_id, count(*) AS "total de peliculas"
FROM movies
GROUP BY genre_id;

#De la consulta anterior, listar sólo aquellos géneros que tengan como suma
#de premios un número mayor a 5.
SELECT genre_id, count(*) AS "total de peliculas", sum(awards) as premios
FROM movies
GROUP BY genre_id
HAVING premios > 5
ORDER BY premios desc;

select * from movies;


