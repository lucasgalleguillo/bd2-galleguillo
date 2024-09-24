CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'bd2024';

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

CREATE TABLE table_random
(id   INT AUTO_INCREMENT PRIMARY KEY);
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'table_random'

UPDATE film
SET title = 'TEO-REYNA-LA-VENGANZA'
WHERE film_id = 1;
-- Query OK, 1 row affected (0.03 sec) Rows matched: 1  Changed: 1  Warnings: 0

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';
-- Query OK, 0 rows affected, 1 warning (0.00 sec)

UPDATE film
SET title = 'TEO-REYNA-LA-VENGANZA-2'
WHERE film_id = 1;
-- ERROR 1142 (42000) UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'