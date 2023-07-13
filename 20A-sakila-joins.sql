USE sakila;

#¡Estos reportes ya los conoces! Pero te pedimos que en este caso no utilices los
#identificadores, sino que los reemplaces por su correspondiente descripción. Para
#esto, vas a tener que realizar JOINS.
#Por ejemplo, si quiero mostrar un reporte de películas más alquiladas, en lugar de
#mostrar el ID de película, debemos mostrar el título.

#Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes
#que más dinero gastan y en cuantos alquileres lo hacen?
SELECT first_name, SUM(amount) AS GASTOS, count(*) AS CANTIDAD_ALQUILERES
FROM CUSTOMER
INNER JOIN PAYMENT ON CUSTOMER.CUSTOMER_ID = PAYMENT.CUSTOMER_ID
INNER JOIN RENTAL ON PAYMENT.RENTAL_ID = RENTAL.RENTAL_ID
GROUP BY first_name
ORDER BY GASTOS DESC
LIMIT 10;

#Generar un reporte que indique: el id del cliente, la cantidad de alquileres y
#el monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres.
SELECT customer.customer_id, COUNT(*) AS CANTIDAD_ALQUILERES, SUM(amount) AS GASTOS
FROM customer
INNER JOIN PAYMENT ON CUSTOMER.CUSTOMER_ID = PAYMENT.CUSTOMER_ID
INNER JOIN RENTAL ON PAYMENT.RENTAL_ID = RENTAL.RENTAL_ID
GROUP BY customer.customer_id
HAVING GASTOS > 150.00;

#Generar un reporte que responda a la pregunta: ¿cómo se distribuyen la
#cantidad y el monto total de alquileres en los meses pertenecientes al año
#2005? (tabla payment).
SELECT DATE_FORMAT(RENTAL_DATE, "%M/%Y") AS ANIO, COUNT(*) AS ALQUILERES_MES, SUM(AMOUNT) AS MONTO_TOTAL
FROM RENTAL
INNER JOIN PAYMENT ON RENTAL.RENTAL_ID = PAYMENT.RENTAL_ID
GROUP BY ANIO
HAVING ANIO LIKE '%/2005';

#Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios
#más alquilados? (columna inventory_id en la tabla rental) Para cada una de
#ellas, indicar la cantidad de alquileres.
SELECT inventory_id, COUNT(*) AS CANTIDAD_ALQUILERES
FROM RENTAL
GROUP BY inventory_id
ORDER BY CANTIDAD_ALQUILERES DESC
LIMIT 5;


#Generar un reporte que responda a la pregunta: Para cada tienda
#(store), ¿cuál es la cantidad de alquileres y el monto total del dinero recaudado por mes?
SELECT STORE.STORE_ID, DATE_FORMAT(PAYMENT_DATE, "%M/%Y") AS MES_AÑO,  SUM(AMOUNT) AS DINERO, COUNT(*) AS CANTIDAD_ALQUILERES
FROM STORE
INNER JOIN STAFF ON STORE.MANAGER_STAFF_ID = STAFF.STAFF_ID
INNER JOIN RENTAL ON STAFF.STAFF_ID = RENTAL.STAFF_ID
INNER JOIN PAYMENT ON RENTAL.RENTAL_ID = PAYMENT.RENTAL_ID
GROUP BY STORE.STORE_ID, DATE_FORMAT(PAYMENT_DATE, "%M/%Y");


#Generar un reporte que responda a la pregunta: ¿cuáles son las 10 películas
#que generan más ingresos? ¿ Y cuáles son las que generan menos ingresos?
#Para cada una de ellas indicar la cantidad de alquileres.
SELECT TITLE, count(*) AS CANTIDAD_ALQUILERES, SUM(AMOUNT) AS INGRESOS_GENERADOS
FROM FILM
INNER JOIN INVENTORY ON FILM.FILM_ID = INVENTORY.FILM_ID
INNER JOIN RENTAL ON INVENTORY.INVENTORY_ID = RENTAL.INVENTORY_ID
INNER JOIN PAYMENT ON RENTAL.RENTAL_ID = PAYMENT.RENTAL_ID
GROUP BY TITLE
ORDER BY INGRESOS_GENERADOS DESC
LIMIT 10;

#¿Existen clientes que no hayan alquilado películas?
SELECT *
FROM CUSTOMER
LEFT JOIN RENTAL ON CUSTOMER.CUSTOMER_ID = RENTAL.CUSTOMER_ID
WHERE RENTAL_ID IS NULL;

#Nivel avanzado: El jefe de stock quiere discontinuar las películas (film) con
#menos alquileres (rental). ¿Qué películas serían candidatas a discontinuar?
SELECT *
FROM FILM
INNER JOIN INVENTORY ON FILM.FILM_ID = INVENTORY.FILM_ID
LEFT JOIN RENTAL ON INVENTORY.INVENTORY_ID = RENTAL.INVENTORY_ID
WHERE RENTAL_ID IS NULL;