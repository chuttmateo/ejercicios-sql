USE musimundos;
#Realizar una consulta sobre la tabla canciones
#Solo los 10 primeros caracteres del nombre de la canción en mayúscula.
SELECT LEFT(UPPER(nombre), 10)
FROM canciones;

#El peso en Kbytes en número entero (sin decimales, 1000Bytes = 1KB)
SELECT FORMAT((bytes/1000),0) AS "Peso en KB"
FROM canciones;

#El precio formateado con 3 decimales, EJ:$ 100.123
SELECT FORMAT(precio_unitario, 3)
FROM canciones;

#El primer compositor de cada canción (notar que si hay más de uno, estos se separan por coma)
SELECT LEFT(compositor, LOCATE(",",compositor)-1) AS "Primer compositor"
FROM canciones;

CREATE VIEW view_canciones AS
SELECT LEFT(UPPER(nombre), 10) AS nombre, FORMAT((bytes/1000),0) AS "Peso en KB", FORMAT(precio_unitario, 3) AS "Precio unitario", LEFT(compositor, LOCATE(",",compositor)-1) AS "Primer compositor"
FROM canciones;

SELECT * 
FROM view_canciones;

