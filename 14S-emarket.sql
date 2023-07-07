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

#Generar un listado de todas las facturas del empleado 'Buchanan'.
SELECT CONCAT(empleados.nombre, " ", empleados.apellido) AS "Nombre completo", facturas.*
FROM facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
WHERE empleados.apellido = 'Buchanan';

#Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
SELECT correos.compania, facturas.*
FROM facturas
INNER JOIN correos ON facturas.enviovia = correos.correoid
WHERE correos.compania = 'Speedy Express';

#Generar un listado de todas las facturas con el nombre y apellido de los empleados.
SELECT CONCAT(empleados.nombre, empleados.apellido) AS "Nombre y apellido del empleado", COUNT(*) AS Facturas
FROM facturas
INNER JOIN empleados ON facturas.empleadoid = empleados.empleadoid
GROUP BY facturas.EmpleadoID
ORDER BY Facturas DESC;

#Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
SELECT clientes.titulo, clientes.contacto, facturas.*
FROM facturas
INNER JOIN clientes ON facturas.ClienteID = clientes.clienteid
WHERE clientes.titulo = 'Owner'
AND 
facturas.paisEnvio = "USA";

#Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
SELECT empleados.apellido, facturas.*
FROM facturas
INNER JOIN empleados ON facturas.empleadoid = empleados.empleadoid
WHERE empleados.apellido = 'Leverling';

#Mostrar todos los campos de las facturas del empleado cuyo apellido sea 
#“Leverling” y que incluya los producto id = “80” o ”42”.
SELECT productos.productoid, empleados.apellido, facturas.*
FROM facturas
INNER JOIN facturadetalle ON facturas.facturaid = facturadetalle.facturaid
INNER JOIN productos ON facturadetalle.productoid = productos.productoid
INNER JOIN empleados ON facturas.empleadoid = empleados.empleadoid
WHERE empleados.apellido = 'Leverling' AND (productos.productoid = 80 OR productos.productoid = 42);

#Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
SELECT clientes.titulo, SUM(facturadetalle.preciounitario * facturadetalle.cantidad) AS compras_totales
FROM clientes
INNER JOIN facturas ON clientes.clienteid = facturas.clienteid
INNER JOIN facturadetalle ON facturas.facturaid = facturadetalle.facturaid
GROUP BY clientes.titulo
ORDER BY compras_totales desc
LIMIT 5;

#Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
#fecha de factura, país de envío, Total, ordenado de manera descendente por
#fecha de factura y limitado a 10 filas.
SELECT clientes.clienteid, clientes.contacto, date_format(facturas.fechafactura, "%d %M %Y") AS fecha
FROM facturas
INNER JOIN clientes ON facturas.clienteid = clientes.clienteid
ORDER BY facturas.fechafactura
LIMIT 10;