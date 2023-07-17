USE emarket;

#Crear un SP que liste los apellidos y nombres de los empleados ordenados alfabéticamente.
DELIMITER $$
CREATE PROCEDURE  listar_empleados()
BEGIN
	SELECT apellido, nombre
	FROM empleados
	ORDER BY apellido, nombre;
END $$

CALL listar_empleados();

#Crear un SP que reciba el nombre de una ciudad y liste los empleados de esa ciudad.
DELIMITER $$
CREATE PROCEDURE empleados_ciudad(
IN parametro_ciudad VARCHAR(25)
)
BEGIN
	SELECT *
	FROM empleados
	WHERE ciudad = parametro_ciudad;
END $$
CALL empleados_ciudad("Seattle");



#Crear un SP que reciba el nombre de un país y devuelva la cantidad de clientes en ese país.
DELIMITER //
CREATE PROCEDURE clientesPorPais(
IN parametro_pais VARCHAR(25),
OUT cantidad INT)
BEGIN
	SELECT COUNT(*) INTO cantidad
	FROM clientes
	WHERE pais = parametro_pais;
END //

#SET @total = 0;
#CALL clientesPorPais("Germany", @total);
#select @total;

#Crear un SP que reciba un número y liste los productos cuyo stock está por
#debajo de ese número. El resultado debe mostrar el nombre del producto, el
#stock actual y el nombre de la categoría a la que pertenece el producto.
DELIMITER final
CREATE PROCEDURE productosStock(
IN n INT)
BEGIN
	SELECT PRODUCTONOMBRE, UNIDADESSTOCK, CATEGORIANOMBRE
	FROM productos
	INNER JOIN categorias ON productos.categoriaid = categorias.categoriaid
	WHERE unidadesstock <= n;
END final

#CALL productosStock(0);



#Crear un SP que reciba un porcentaje y liste los nombres de los productos que
#hayan sido vendidos con un descuento igual o superior al valor indicado,
#indicando además el nombre del cliente al que se lo vendió.
DELIMITER $$
CREATE PROCEDURE descuentoEnFacturas(
IN parametro_descuento DOUBLE
)
BEGIN
	SELECT PRODUCTONOMBRE, COMPANIA
	FROM productos
	INNER JOIN facturadetalle ON productos.productoid = facturadetalle.productoid
	INNER JOIN facturas ON facturadetalle.facturaid = facturas.facturaid
	INNER JOIN clientes ON facturas.clienteid = clientes.clienteid
	WHERE descuento >= parametro_descuento;
END $$

CALL descuentoEnFacturas(0.1)		
