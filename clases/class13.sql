
-- 1
INSERT INTO customer (store_id, address_id, first_name, last_name, email)
VALUES(1, 
	(SELECT MAX(address_id) FROM address
	INNER JOIN city ON address.city_id = city.city_id
	INNER JOIN country ON city.country_id = country.country_id
	WHERE country.country = 'United States'),
	'A',
	'A',
	'A.A@A.com');

-- 2
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), 
	(SELECT I.inventory_id FROM inventory AS I
	INNER JOIN film AS F on I.film_id = F.film_id
	WHERE F.title = 'ACADEMY DINOSAUR'
	LIMIT 1), 
	1, 
	CURRENT_DATE(), 
	(SELECT MAX(staff_id) FROM staff WHERE store_id = 2));

-- 3 
SET SQL_SAFE_UPDATES = 0;
UPDATE film
SET release_year = CASE rating
                       WHEN 'G' THEN '2010'
                       WHEN 'PG' THEN '2014'
                       WHEN 'PG-13' THEN '2017'
                       WHEN 'R' THEN '2018'
                       WHEN 'NC-17' THEN '2019'
                       ELSE release_year END;
                       
                       
-- 4 
SELECT f.film_id FROM film as f
INNER JOIN inventory AS i on i.film_id = f.film_id
INNER JOIN rental AS r on i.inventory_id = r.inventory_id
WHERE r.return_date IS NULL
ORDER BY rental_date DESC
LIMIT 1;

-- 5 
DELETE FROM film WHERE film_id = 1;
-- Al intentar eliminar nos salta error 1451 ya que tiene claves foraneas 
DELETE FROM film_actor WHERE film_id = 1;

DELETE FROM film_category WHERE film_id = 1;

DELETE FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1);

DELETE FROM inventory WHERE film_id = 1;

DELETE FROM film WHERE film_id = 1;


-- 6 

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                         WHERE NOT EXISTS(SELECT *
                                          FROM rental AS R
                                          WHERE R.inventory_id = I.inventory_id
                                            AND R.return_date < CURRENT_DATE())
                         LIMIT 1), 1, CURRENT_DATE(), 1);
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, (SELECT LAST_INSERT_ID()), 10.2, CURRENT_DATE)
