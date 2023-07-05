USE musimundos;

SELECT pais, count(*)
FROM clientes
GROUP BY pais
having pais = 'Brazil';

SELECT id_genero, count(*) 
FROM canciones
GROUP BY id_genero
having id_genero = 6;

SELECT sum(total)
FROM facturas;


SELECT AVG(PRIMEROS)
FROM (
	SELECT id_album, AVG(milisegundos) AS PRIMEROS
	FROM canciones
	GROUP BY id_album
) AS SSS;

SELECT id_album, AVG(milisegundos) AS promedio
FROM canciones
GROUP BY id_album;

SELECT *
FROM canciones
ORDER BY bytes;

SELECT id_cliente, sum(total)
FROM facturas
GROUP BY id_cliente;

