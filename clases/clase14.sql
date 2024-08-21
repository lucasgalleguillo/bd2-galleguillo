-- 1
SELECT CONCAT(c.first_name, ' ', c.last_name), a.address, ci.city FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Argentina';

-- 2
SELECT f.title, l.name, CASE 
	WHEN f.rating = 'G' THEN 'G (GENERAL AUDIENCES) – ALL AGES ADMITTED.'
	WHEN f.rating = 'PG' THEN 'PG (PARENTAL GUIDANCE SUGGESTED) – SOME MATERIAL MAY NOT BE SUITABLE FOR CHILDREN.'
	WHEN f.rating = 'PG-13' THEN 'PG-13 (PARENTS STRONGLY CAUTIONED) – SOME MATERIAL MAY BE INAPPROPRIATE FOR CHILDREN UNDER 13.'
	WHEN f.rating = 'R' THEN 'R (RESTRICTED) – UNDER 17 REQUIRES ACCOMPANYING PARENT OR ADULT GUARDIAN.'
	WHEN f.rating = 'NC-17' THEN 'NC-17 (ADULTS ONLY) – NO ONE 17 AND UNDER ADMITTED.'
	ELSE 'RATING' END AS "Rating"
FROM film f
INNER JOIN language l ON f.language_id = l.language_id;

-- 3

SELECT f.title, f.release_year
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.first_name = LOWER('PENELOPE') AND a.last_name = LOWER('GUINESS');

-- 4 
SELECT f.title AS film_title, CONCAT(c.first_name, ' ', c.last_name) AS full_name, CASE 
	WHEN r.return_date IS NOT NULL THEN 'Yes'
	ELSE 'No'
    END AS returned
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) IN (5, 6);


-- 5
-- CAST y CONVERT son funciones en SQL que se utilizan para convertir datos de un tipo a otro. 
-- CAST es más estándar y funciona en la mayoría de las bases de datos, mientras que CONVERT hace lo mismo,
-- pero puede ofrecer más opciones en algunos sistemas específicos, como MySQL.
SELECT title, CONVERT(rental_rate, UNSIGNED) AS rental_rate_as_integer FROM film;
SELECT title, rental_rate, CAST(rental_rate AS CHAR) AS rental_rate_as_char FROM film;

-- 6
/* 
Las funciones NVL, ISNULL, IFNULL, y COALESCE se usan para reemplazar valores NULL con otro valor en SQL. 
NVL es específica de Oracle, ISNULL se usa en SQL Server y MySQL, IFNULL es para MySQL y SQLite, y COALESCE
es estándar en SQL, permitiendo devolver el primer valor no NULL en una lista. De estas, NVL no está en MySQL,
mientras que ISNULL, IFNULL, y COALESCE sí. Todas estas funciones ayudan a evitar problemas cuando los datos son NULL,
asegurando que siempre se tenga un valor válido.
*/
SELECT NVL(NULL, 'No Data') FROM dual;
SELECT ISNULL(NULL, 'No Data');
SELECT IFNULL(NULL, 'No Data');
SELECT COALESCE(NULL, NULL, 'No Data', 'Data');

