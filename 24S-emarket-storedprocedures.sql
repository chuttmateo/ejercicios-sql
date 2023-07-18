USE emarket;
#Crear un SP que muestre apellidos, nombres y edad de cada empleado, debe calcular la edad de los empleados 
#a partir de la fecha de nacimiento y que tengan entre n y n años de edad.
DELIMITER $$
CREATE PROCEDURE empleadosPorEdad(
IN edad1 INT,
IN edad2 INT)
BEGIN
	SELECT Apellido, Nombre, timestampdiff(year, FechaNacimiento, CURRENT_DATE())AS Edad
	FROM empleados
	WHERE timestampdiff(year, FechaNacimiento, CURRENT_DATE()) between edad1 AND edad2;
END $$
DELIMITER ;

#DROP procedure empleadosPorEdad;

## NOTA: para evitar conflictos con el delimitador predeterminado tengo que usar DELIMITER ; PARA SETEAR EL DELIMITADOR PREDETERM8INADO NUEVAMENTE

#Ejecutar el SP indicando un rango de edad entre 50 y 60 años de edad.
CALL empleadosPorEdad(50, 70);

#Crear un SP que reciba un porcentaje y un nombre de categoría y actualice los productos pertenecientes a esa categoría, 
#incrementando las unidades pedidas según el porcentaje indicado. 
#Por ejemplo: si un producto de la categoría Seafood tiene 30 unidades pedidas, al invocar el SP con categoría Seafood y porcentaje 10%, 
#el SP actualizará el valor de unidades pedidas con el nuevo valor 33
#SELECT *
#FROM productos
#INNER JOIN categorias ON productos.categoriaid = categorias.categoriaid

DELIMITER $$
CREATE PROCEDURE incrementar_unidades_pedidas(
IN porcentaje double,
IN parametro_categoria varchar(50))
BEGIN
	DECLARE VAR INT DEFAULT 0;
	SELECT CategoriaId INTO VAR FROM categorias WHERE categoriaNombre = parametro_categoria;
    IF VAR > 0 THEN
    	UPDATE productos
		Set UnidadesPedidas = UnidadesPedidas + floor(UnidadesPedidas*porcentaje)
		where Categoriaid = @VAR;
	END IF;	
END $$
DELIMITER ;

#DROP procedure incrementar_unidades_pedidas;

SELECT * from productos;
#Listar los productos de la categoría Beverages para ver cuántas unidades pedidas hay de cada uno de ellos. 
SELECT * FROM productos where categoriaid = 1;
#c)Invocar al SP con los valores Beverages como categoría y 15 como porcentaje. 
CALL incrementar_unidades_pedidas(0.15, 'Beverages');
#d) Volver a listar los productos como en (a), y validar los resultados.
SELECT * FROM productos where categoriaid = 1;



#3) Actualización de empleados 
#a) Crear un SP que cree una tabla con los nombres, apellidos y teléfono de contacto de todos los empleados que hayan sido contratados con fecha anterior a una fecha dada.
DELIMITER $$
CREATE PROCEDURE empleados_contratados_despues_de(
IN parametro_fecha DATE)
BEGIN
	DROP TABLE IF EXISTS empleados_temp;
	CREATE TABLE IF NOT EXISTS empleados_temp(
		nombre VARCHAR(50),
        apellido VARCHAR(50),
        telefono VARCHAR(25)
    );
    INSERT INTO empleados_temp (nombre, apellido, telefono)
    SELECT nombre, apellido, telefono
    FROM empleados
    WHERE fechaContratacion < parametro_fecha;
END $$
DELIMITER ;

#DROP procedure empleados_contratados_despues_de;

#Ejecutar el SP para generar una tabla de empleados con fecha de contratación anterior a 01/01/1994. 
CALL empleados_contratados_despues_de('1994-01-01')



