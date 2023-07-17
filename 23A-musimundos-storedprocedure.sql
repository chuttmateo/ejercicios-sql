USE MUSIMUNDOS;

#Crear un stored procedure que solicite como parámetros de entrada el nombre de un país y una ciudad, 
#y que devuelva como resultado la información de contacto de todos los clientes de ese país y ciudad.
#En el caso que el parámetro de ciudad esté vacío, se debe devolver todos los clientes del país indicado.

#DROP PROCEDURE obtener_clientes;

DELIMITER $$
CREATE PROCEDURE obtener_clientes(
IN parametro_pais VARCHAR(25),
IN parametro_ciudad VARCHAR(25)
)
BEGIN
	IF parametro_ciudad = "" THEN 
		SELECT * FROM clientes WHERE pais = parametro_pais;
	ELSE
		SELECT * FROM clientes WHERE pais = parametro_pais AND ciudad = parametro_ciudad;
        END IF;
END $$

call musimundos.obtener_clientes('Brazil', 'São José dos Campos');




#Crear un stored procedure que reciba como parámetro un nombre de género musical y lo inserte en la tabla de géneros.
#Además, el stored procedure debe devolver el id de género que se insertó.
#TIP! Para calcular el nuevo id incluir la siguiente línea dentro del bloque de
#código del SP: SET nuevoid = (SELECT MAX(id) FROM generos) + 1;
DELIMITER $$
CREATE PROCEDURE insertar_genero(
IN parametro_genero VARCHAR(25),
OUT nuevo_id INT
)
BEGIN
	SET nuevo_id = (SELECT MAX(id) FROM generos) + 1;
	INSERT INTO generos(id, nombre) 
    VALUES(nuevo_id,parametro_genero);
END $$

#DROP PROCEDURE insertar_genero;




