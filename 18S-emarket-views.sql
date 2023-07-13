USE emarket;

#Crear una vista para poder organizar los envíos de las facturas. Indicar número
#de factura, fecha de la factura y fecha de envío, ambas en formato dd/mm/yyyy,
#valor del transporte formateado con dos decimales, y la información del
#domicilio del destino incluyendo dirección, ciudad, código postal y país, en una columna llamada Destino.
CREATE VIEW facturas_view AS 
select 
	FacturaID, 
	date_format(FechaFactura, "%d/%m/%Y") AS FECHA_FACTURA, 
	date_format(FechaEnvio, "%d/%m/%Y") AS FECHA_ENVIO, 
	format(Transporte,2) AS VALOR_TRANSPORTE, 
    CONCAT(DireccionEnvio, ", ", CiudadEnvio, ", ", CodigoPostalEnvio, ", ", PaisEnvio) AS DESTINO
FROM FACTURAS;

#DROP VIEW facturas_view;

SELECT *
FROM facturas_view;

#Realizar una consulta con todos los correos y el detalle de las facturas que
#usaron ese correo.
SELECT CORREOS.*, FACTURADETALLE.*
FROM CORREOS
INNER JOIN FACTURAS ON CORREOS.CORREOID = FACTURAS.ENVIOVIA
INNER JOIN FACTURADETALLE ON FACTURAS.FACTURAID = FACTURADETALLE.FACTURAID;

#Crear una vista con un detalle de los productos en stock. Indicar id, nombre del
#producto, nombre de la categoría y precio unitario.
CREATE VIEW productos_stock_view AS
SELECT PRODUCTOID, PRODUCTONOMBRE, CATEGORIAS.CATEGORIANOMBRE, PRECIOUNITARIO
FROM PRODUCTOS
INNER JOIN CATEGORIAS ON PRODUCTOS.CATEGORIAID = CATEGORIAS.CATEGORIAID
WHERE PRODUCTOS.UNIDADESSTOCK > 0;

SELECT *
FROM productos_stock_view;

#Escribir una consulta que liste el nombre y la categoría de todos los productos
#vendidos. Utilizar la vista creada.
SELECT PRODUCTONOMBRE AS NOMBRE, CATEGORIANOMBRE AS CATEGORIA
FROM PRODUCTOS_STOCK_VIEW;




