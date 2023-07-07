USE musimundos;

#Listar las canciones cuya duración sea mayor a 2 minutos.
SELECT *
FROM canciones
where milisegundos > 120000
ORDER BY milisegundos DESC;

#Listar las canciones cuyo nombre comience con una vocal.
SELECT *
FROM canciones
WHERE nombre LIKE 'A%' OR nombre LIKE 'E%' OR nombre LIKE 'I%' OR nombre LIKE 'O%' OR nombre LIKE 'U%'
ORDER BY nombre;
#ENCONTRÉ DISCREPANCIA ENTRE ESTAS DOS CONSULTAS Y LA SOLUCIÓN FUE AGREGAR |À AL REGEX PARA TENER EN CUENTA A ESE CARACTER.

SELECT nombre
FROM canciones
WHERE LOWER(nombre) REGEXP '^(a|e|i|o|u|á|À|é|í|ó|ú)';

#Listar las canciones ordenadas por compositor en forma descendente.
#Luego, por nombre en forma ascendente. Incluir únicamente aquellas
#canciones que tengan compositor.
SELECT *
FROM canciones
ORDER BY compositor desc;

SELECT *
FROM canciones
WHERE compositor != ""
ORDER BY nombre;

#a) Listar la cantidad de canciones de cada compositor.
SELECT compositor, count(*)
FROM canciones
GROUP BY compositor;

#b) Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones.
SELECT compositor, count(*) AS canciones
FROM canciones
GROUP BY compositor
HAVING canciones > 10
AND compositor != '';

#a) Listar el total facturado agrupado por ciudad.
SELECT ciudad_de_facturacion, SUM(total) AS total_por_ciudad
FROM facturas
GROUP BY ciudad_de_facturacion;

#b) Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
SELECT ciudad_de_facturacion, SUM(total) AS total_por_ciudad
FROM facturas
WHERE pais_de_facturacion = 'Canada'
GROUP BY ciudad_de_facturacion;

#Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
SELECT ciudad_de_facturacion, SUM(total) AS total_por_ciudad
FROM facturas
WHERE pais_de_facturacion = 'Canada'
GROUP BY ciudad_de_facturacion
HAVING total_por_ciudad > 38;

#d) Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
SELECT pais_de_facturacion, ciudad_de_facturacion, SUM(total) AS total
FROM facturas
GROUP BY pais_de_facturacion, ciudad_de_facturacion;

#a) Listar la duración mínima, máxima y promedio de las canciones.
SELECT MIN(milisegundos) AS min, MAX(milisegundos) AS max, AVG(milisegundos) AS promedio
FROM canciones;

#b) Modificar el punto (a) mostrando la información agrupada por género.
SELECT generos.nombre, MIN(milisegundos) AS min, MAX(milisegundos) AS max, AVG(milisegundos) AS promedio
FROM canciones
INNER JOIN generos ON canciones.id_genero = generos.id
GROUP BY generos.nombre;