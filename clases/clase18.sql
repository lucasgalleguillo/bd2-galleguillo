USE sakila;
-- 1 
DELIMITER //
CREATE FUNCTION CopiasFilm(film VARCHAR(50), storeId INT) RETURNS INT
BEGIN
    DECLARE copies INT;
    SELECT COUNT(*) INTO copies FROM inventory i
    INNER JOIN film f ON i.film_id = f.film_id
    WHERE (f.film_id = film OR f.title = film) AND i.store_id = storeId;
    RETURN copies;
END //
DELIMITER ;

-- 2 
DELIMITER //
DROP PROCEDURE getListOfCustomer;
CREATE PROCEDURE getListOfCustomer(IN countryName VARCHAR(100), OUT listOfCustomer TEXT)
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE selectedCustomer VARCHAR(255) DEFAULT '';
    DECLARE sep VARCHAR(3) DEFAULT '';  -- Separador
    
    DECLARE customerCursor CURSOR FOR 
        SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer 
        FROM customer c
        INNER JOIN address ad ON ad.address_id = c.address_id
        INNER JOIN city ci ON ci.city_id = ad.city_id
        INNER JOIN country co ON co.country_id = ci.country_id
        WHERE co.country = countryName;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    SET listOfCustomer = '';
    OPEN customerCursor;
    
    addCustomersToString: LOOP
        FETCH customerCursor INTO selectedCustomer;
        
        IF finished = 1 THEN
            LEAVE addCustomersToString;
        END IF;
        
        IF listOfCustomer != '' THEN
            SET listOfCustomer = CONCAT(listOfCustomer, '; ');  -- Agregar separador solo si ya hay contenido
        END IF;

        SET listOfCustomer = CONCAT(listOfCustomer, selectedCustomer);
    END LOOP addCustomersToString;
    
    CLOSE customerCursor;
END //
DELIMITER ;

SET @listOfCustomer = '';
CALL getListOfCustomer('Colombia', @listOfCustomer);
SELECT @listOfCustomer;

-- 3
/*
inventory_in_stock devuelve un tinyint(1) (verdadero o falso) y se basa en dos variables internas: 
una que contabiliza el número de alquileres del artículo y otra que cuenta los alquileres con una 
fecha de devolución faltante. Así, proporciona una verificación efectiva de la disponibilidad del 
artículo en el inventario de la tienda 
*/
SET @result = inventory_in_stock(10);
SELECT @result;

/*
El procedimiento almacenado film_in_stock tiene como objetivo principal determinar la cantidad total 
de copias de una película específica que están disponibles para alquilar en una tienda determinada. 
Este procedimiento acepta dos parámetros de entrada: p_film_id, que representa el ID de la película, 
y p_store_id, que indica la tienda específica en la que se desea consultar la disponibilidad.
*/
CALL film_in_stock(1, 1, @result);
SELECT @result;


