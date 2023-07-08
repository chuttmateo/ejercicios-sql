USE extra_joins;
#Obtener los artistas que han actuado en una o más películas.
SELECT DISTINCT apellido, nombre
FROM artista
INNER JOIN artista_x_pelicula ON artista.id = artista_x_pelicula.artista_id;

#Obtener las películas donde han participado más de un artista según nuestra base de datos.
SELECT titulo, COUNT(artista_id) AS artistas
FROM pelicula
INNER JOIN artista_x_pelicula ON pelicula.id = artista_x_pelicula.pelicula_id
GROUP BY titulo
HAVING artistas > 1;

#Obtener aquellos artistas que han actuado en alguna película, incluso
#aquellos que aún no lo han hecho, según nuestra base de datos.
SELECT *
FROM artista
LEFT JOIN artista_x_pelicula ON artista.id = artista_x_pelicula.artista_id;

#Obtener las películas que no se le han asignado artistas en nuestra base de datos.
SELECT *
FROM pelicula
LEFT JOIN artista_x_pelicula ON pelicula.id = artista_x_pelicula.pelicula_id
where artista_id IS NULL;

#Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.
SELECT *
FROM artista
LEFT JOIN artista_x_pelicula ON artista.id = artista_x_pelicula.artista_id
WHERE artista_id IS NULL;

#Obtener aquellas películas que tengan asignado uno o más artistas, incluso
#aquellas que aún no le han asignado un artista en nuestra base de datos.
SELECT *
FROM pelicula
LEFT JOIN artista_x_pelicula ON pelicula.id = artista_x_pelicula.pelicula_id;
