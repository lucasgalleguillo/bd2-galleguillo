-- 2
USE VIVERO_FENIX;
DROP PROCEDURE ClienteLocalidad;


DELIMITER //
CREATE PROCEDURE ClienteLocalidad(IN localidad VARCHAR(50), OUT lista_cliente TEXT)
BEGIN
    DECLARE sep VARCHAR(5) DEFAULT '';
    DECLARE finish INT DEFAULT 0;
    DECLARE cliente_seleccionado VARCHAR(255);  -- Asegúrate de que el nombre de la variable sea correcto

    DECLARE cursor_cliente CURSOR FOR 
        SELECT CONCAT(C.NOMBRE, ' ', C.APELLIDO) 
        FROM CLIENTES C
        INNER JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
        WHERE L.NOMBRE = localidad;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finish = 1;
    SET lista_cliente = '';

    OPEN cursor_cliente;

    loop_cliente: LOOP
        FETCH cursor_cliente INTO cliente_seleccionado;  -- Corrige aquí usando 'cliente_seleccionado'
		
        IF finish = 1 THEN
            LEAVE loop_cliente;
        END IF;
		
        SET lista_cliente = CONCAT(lista_cliente, sep, cliente_seleccionado);
		
        SET sep = '; ';
    END LOOP loop_cliente;

    CLOSE cursor_cliente;  -- Asegúrate de cerrar el cursor
END //
DELIMITER ;

SET @lista_cliente = '';
CALL ClienteLocalidad('cordoba', @lista_cliente);
SELECT @lista_cliente;


-- 3

DELIMITER //

CREATE TRIGGER update_plantas
BEFORE update on PLANTAS 
FOR EACH ROW
BEGIN 
	SET NEW.ultimaModificacion = NOW();
    SET NEW.ultimaModificacionUser = CURRENT_USER();

END //

CREATE TRIGGER insert_plantas
BEFORE insert on PLANTAS 
FOR EACH ROW
BEGIN 
	SET NEW.ultimaModificacion = NOW();
    SET NEW.ultimaModificacionUser = CURRENT_USER();
END //
delimiter ;

select * from PLANTAS;

UPDATE PLANTAS SET DESCRIPCION = 'PLanta12' where COD_PLANTA = 1;

select * FROM PLANTAS;

DROP TRIGGER insert_plantas;
DROP TRIGGER update_plantas;

describe PLANTAS;

-- 1

Create view customer_purchase_summary as 
	SELECT C.COD_CLIENTE, concat(C.NOMBRE, ' ', C.APELLIDO) AS NombreCOMPLETO, 
    COUNT(distinct F.NRO_FACTURA) AS ComprasREALIZADAS,
	SUM(P.PRECIO * DF.CANTIDAD)  AS TotalGastado,
			(SELECT TP1.NOMBRE
				FROM DETALLES_FACTURAS DF
				JOIN PLANTAS P USING(COD_PLANTA)
                JOIN FACTURAS F USING(NRO_FACTURA)
                JOIN TIPOS_PLANTAS TP1 USING(COD_TIPO_PLANTA)
                WHERE C.COD_CLIENTE = F.COD_CLIENTE
                group by TP1.NOMBRE
                ORDER BY SUM(DF.CANTIDAD) DESC
                LIMIT 1) AS PlantaMasComprada,
                
		(SELECT GROUP_CONCAT(plant_summary) 
		 FROM (
			 SELECT CONCAT(TP.NOMBRE, ': ', SUM(DF.CANTIDAD)) AS plant_summary
			 FROM DETALLES_FACTURAS DF
			 JOIN PLANTAS P2 USING(COD_PLANTA)
			 JOIN TIPOS_PLANTAS TP USING(COD_TIPO_PLANTA)
			 JOIN FACTURAS F USING(NRO_FACTURA)
			 WHERE F.COD_CLIENTE = C.COD_CLIENTE
			 GROUP BY TP.COD_TIPO_PLANTA 
		 ) AS subquery
		) AS PlantasXCategoria
    FROM CLIENTES C
    JOIN FACTURAS F USING(COD_CLIENTE)
    JOIN DETALLES_FACTURAS DF USING(NRO_FACTURA)
    JOIN PLANTAS P USING(COD_PLANTA)
    JOIN TIPOS_PLANTAS TP USING(COD_TIPO_PLANTA)
    GROUP BY C.COD_CLIENTE;

SELECT * FROM customer_purchase_summary;