USE emarket;
#Clientes
#¿Cuántos clientes existen?
SELECT count(*) AS 'Total de clientes'
FROM clientes;

#¿Cuántos clientes hay por ciudad?
SELECT Ciudad, count(*)
FROM CLIENTES
GROUP BY Ciudad;

#Facturas
#¿Cuál es el total de transporte?
SELECT sum(transporte)
FROM facturas;

#¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
SELECT enviovia, sum(transporte) AS 'Gastos en trasporte para cada empresa de envios'
FROM facturas
GROUP BY enviovia;

#Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.
SELECT ClienteID, count(*) AS facturas
FROM facturas
GROUP BY ClienteID
ORDER BY facturas DESC;

#Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
SELECT ClienteID, count(*) AS facturas
FROM facturas
GROUP BY ClienteID
ORDER BY facturas DESC
LIMIT 5;

#¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
SELECT PaisEnvio ,COUNT(*) AS totales
FROM FACTURAS
GROUP BY PaisEnvio
ORDER BY totales asc
LIMIT 1;

#Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?
SELECT EmpleadoID, count(*) as ventas_totales
FROM facturas
GROUP BY EmpleadoID
ORDER BY ventas_totales desc
LIMIT 1;

#Factura Detalle
#¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
SELECT ProductoID, COUNT(*)
FROM facturadetalle
GROUP BY ProductoID
ORDER BY COUNT(*) DESC;

#¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.
SELECT SUM(cantidad * precioUnitario) AS total_facturado
FROM facturadetalle;

#¿Cuál es el total facturado para los productos ID entre 30 y 50?
SELECT SUM(total)
FROM (
SELECT ProductoID, sum(cantidad * precioUnitario) as total
FROM facturadetalle
GROUP BY ProductoID
HAVING ProductoID BETWEEN 30 AND 50
ORDER BY ProductoID
) AS suma;

SELECT ProductoID, sum(cantidad * precioUnitario)
FROM facturadetalle
GROUP BY ProductoID
HAVING ProductoID BETWEEN 30 AND 50
ORDER BY ProductoID;

#¿Cuál es el precio unitario promedio de cada producto?
SELECT ProductoID, AVG(precioUnitario)
FROM facturadetalle
GROUP BY ProductoID;

#¿Cuál es el precio unitario máximo?
SELECT MAX(precioUnitario)
FROM facturaDetalle;

