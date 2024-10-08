-- 1
CREATE OR REPLACE VIEW list_of_customers AS
	SELECT c.customer_id, concat(c.first_name, ' ', c.last_name) AS nombre_completo, a.address, a.postal_code, a.phone, ci.city, co.country, c.store_id, 
    CASE WHEN c.active = 1 THEN 'active' ELSE 'inactive'END
	FROM customer c
	INNER JOIN address a ON c.address_id = a.address_id
	INNER JOIN city ci ON a.city_id = ci.city_id
	INNER JOIN country co ON ci.country_id = co.country_id
	INNER JOIN store s ON c.store_id = s.store_id;

-- 2

CREATE OR REPLACE VIEW film_details AS
	SELECT f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating, GROUP_CONCAT(a.first_name, ' ', a.last_name)
    FROM film f
    INNER JOIN film_category fc ON fc.film_id = f.film_id
	INNER JOIN category c ON c.category_id = fc.category_id
    INNER JOIN film_actor fa ON fa.film_id = f.film_id
    INNER JOIN actor a ON a.actor_id = fa.actor_id
    GROUP BY f.film_id, f.title, f.description, f.rental_rate, f.rental_rate, f.length, f.rating, c.name;
   
SELECT * FROM film_details;
-- 3 

CREATE OR REPLACE VIEW sales_by_film_category AS
	SELECT C.name, COUNT(R.rental_id) AS 'total_rental'
	FROM category AS C
    INNER JOIN film_category AS FC ON C.category_id = FC.category_id
	INNER JOIN film AS F ON FC.film_id = F.film_id
	INNER JOIN inventory AS I ON F.film_id = I.film_id
	INNER JOIN rental AS R ON I.inventory_id = R.inventory_id
	GROUP BY C.name;
    
-- 4

CREATE OR REPLACE VIEW actor_information AS
	SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad
	FROM actor a
	LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id, a.first_name, a.last_name;
    

/*
La vista actor_information nos permite motrar la relación entre actores y 
las películas en las que han actuado. Utiliza LEFT JOIN para asegurarse de que todos los actores 
estén representados, incluso si no han actuado en ninguna película. El uso de la función COUNT 
permite contar las películas de manera eficiente sin ultilizar una subconsulta, y el GROUP BY organiza los 
resultados adecuadamente para que cada actor se muestre con un único registro en la vista
*/    


SELECT * FROM actor_information;
    
/*
Una vista materializada es una vista que almacena físicamente los resultados de una consulta en lugar de 
calcularlos cada vez que se consulta, lo que mejora el rendimiento en operaciones complejas o frecuentes. 
Son útiles para reportes y análisis, ya que evitan recalcular datos y aceleran las consultas.
DBMS con soporte de vistas materializadas:
Oracle: Soporte completo y actualizaciones automáticas.
PostgreSQL: Se deben refrescar manualmente.
SQL Server: Implementadas como Indexed Views.
MySQL: No tiene soporte nativo, pero se pueden emular.
Las alternativas a usarse pueden ser indices (estructuras de datos optimizadas),
tablas de resumen (cuando se neecesitan generar estadisticas, promedios, etc), particionamiento de tablas,
materializacion del sistema en general
*/