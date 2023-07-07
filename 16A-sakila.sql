USE sakila;
#Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar 
#alias para mostrar los nombres de las columnas en español. 
SELECT CONCAT(first_name, " ", last_name) AS nombre_completo
FROM actor
LIMIT 5;

#Obtener un listado que incluya nombre, apellido y correo electrónico de los clientes (customers) inactivos. 
#Utilizar alias para mostrar los nombres de las columnas en español. 
SELECT first_name AS nombre, last_name AS apellido, email AS correo
FROM customer
WHERE active = 0;

#Obtener un listado de films incluyendo título, año y descripción de los films que tienen un rental_duration mayor a cinco. 
#Ordenar por rental_duration de mayor a menor. Utilizar alias para mostrar los nombres de las columnas en español. 
SELECT title AS título, release_year AS "Año de estreno", description AS descripción, rental_duration AS "Duración del alquiler"
FROM film
WHERE rental_duration > 5
ORDER BY rental_duration DESC;

#Obtener un listado de alquileres (rentals) que se hicieron durante el mes de 
#mayo de 2005, incluir en el resultado todas las columnas disponibles. 
SELECT *
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-05-31';


#Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo en una columna llamada “cantidad”.
SELECT COUNT(*) AS cantidad
FROM rental;

#Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para mostrarlo en una columna llamada “total”, 
#junto a una columna con la cantidad de alquileres con el alias “Cantidad” y una columna que indique el “Importe promedio” por alquiler. 
SELECT SUM(amount) AS total, count(rental_id) as cantidad, AVG(amount) AS "Importe promedio"
FROM payment;

#Generar un reporte que responda la pregunta: 
#¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen? 
SELECT customer.first_name AS nombre, SUM(payment.amount) AS total_gastado, count(rental.rental_id) AS cantidad_rentas
FROM rental
INNER JOIN payment ON rental.rental_id = payment.rental_id
INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY total_gastado DESC
LIMIT 10;

#Generar un reporte que indique: 
#ID de cliente, cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres. 
SELECT payment.customer_id, COUNT(payment.rental_id) AS cantidad_alquileres, SUM(payment.amount) AS total_gastado
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
HAVING total_gastado > 150;

#Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental), la cantidad de alquileres 
#y la suma total pagada (amount de tabla payment) para el año de alquiler 2005 (rental_date de tabla rental).
SELECT DATE_FORMAT(rental_date, "%M") AS mes, COUNT(*) AS total_alquileres, SUM(payment.amount) AS total_gastado
FROM rental
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY DATE_FORMAT(rental_date, "%M");

#Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental). 
#Para cada una de ellas indicar la cantidad de alquileres. 
SELECT inventory_id, COUNT(*) AS alquileres_por_inventario
FROM rental
GROUP BY inventory_id
ORDER BY alquileres_por_inventario DESC
LIMIT 5;


