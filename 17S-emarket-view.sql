USE emarket;

#Crear una vista con los siguientes datos de los clientes: ID, contacto, y el
#Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por ejemplo: “TEL: (01) 123-4567”.
CREATE VIEW view_clientes AS 
SELECT CLIENTEID, CONTACTO, 
CASE
	WHEN FAX = "" THEN CONCAT("TEL: ", telefono)
    ELSE FAX
END AS FAX_TELEFONO
FROM CLIENTES;

SELECT * 
FROM VIEW_CLIENTES;

#Se necesita listar los números de teléfono de los clientes que no tengan fax. Hacerlo de dos formas distintas:
#a. Consultando la tabla de clientes.
SELECT TELEFONO
FROM CLIENTES
WHERE FAX = "";
#(MEJORAR CONSULTA)
#b. Consultando la vista de clientes.
SELECT 
	CASE
	WHEN LOCATE("TEL: ", FAX_TELEFONO) = 1 THEN FAX_TELEFONO
    ELSE ""
    END AS Telefonos
FROM view_clientes;

#Crear una vista con los siguientes datos de los proveedores: ID,
#contacto, compañía y dirección. Para la dirección tomar la dirección, ciudad, código postal y país.
CREATE VIEW PROVEEDORES_VIEW AS
SELECT PROVEEDORID, CONTACTO, COMPANIA, CONCAT(DIRECCION, ", ", CIUDAD, ", ",PAIS, " (", CODIGOPOSTAL, ") ") AS DIRECCION
FROM PROVEEDORES;

SELECT *
FROM PROVEEDORES_VIEW;

#Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo de dos formas distintas:
#a. Consultando la tabla de proveedores.
SELECT *
FROM PROVEEDORES
WHERE DIRECCION LIKE '%Americanas%'
AND 
PAIS = 'Brazil';
#b. Consultando la vista de proveedores.
SELECT LOCATE("Americanas", DIRECCION), DIRECCION
FROM PROVEEDORES_VIEW
WHERE LOCATE("Americanas", DIRECCION) > 0;

#Crear una vista de productos que se usará para control de stock. 
#Incluir el ID y nombre del producto, el precio unitario redondeado sin decimales, las
#unidades en stock y las unidades pedidas. Incluir además una nueva columna PRIORIDAD con los siguientes valores:
# ■ BAJA: si las unidades pedidas son cero.
# ■ MEDIA: si las unidades pedidas son menores que las unidades en stock.
# ■ URGENTE: si las unidades pedidas no duplican el número de unidades.
# ■ SUPER URGENTE: si las unidades pedidas duplican el número de unidades en caso contrario.
CREATE VIEW PRODUCTOS_VIEW AS
SELECT PRODUCTOID, PRODUCTONOMBRE, FORMAT(PRECIOUNITARIO, 0) AS PRECIO_UNITARIO, UNIDADESSTOCK, UNIDADESPEDIDAS,
CASE 
	WHEN UNIDADESPEDIDAS = 0 THEN "BAJA"
    WHEN UNIDADESPEDIDAS < UNIDADESSTOCK THEN "MEDIA"
    WHEN UNIDADESPEDIDAS < (UNIDADESSTOCK * 2) THEN "URGENTE"
    WHEN UNIDADESPEDIDAS > (UNIDADESSTOCK * 2) THEN "SUPER URGENTE"
END AS PRIORIDAD
FROM PRODUCTOS;

SELECT SUM(PRECIO_UNITARIO)
FROM PRODUCTOS_VIEW;

#Se necesita un reporte de productos para identificar problemas de stock.
#Para cada prioridad indicar cuántos productos hay y su precio promedio.
#No incluir las prioridades para las que haya menos de 5 productos.
SELECT PRIORIDAD, COUNT(*) AS CANTIDAD_PRODUCTOS, AVG(PRECIO_UNITARIO) AS PRECIO_PROMEDIO
FROM PRODUCTOS_VIEW
GROUP BY PRIORIDAD;