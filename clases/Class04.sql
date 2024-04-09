#1
select title, special_features from film where rating="PG-13";

#2
select distinct length from film;

#3
select title, rental_rate, replacement_cost from film where replacement_cost between 20 and 24;

#4
select title, rating, category.name from film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where special_features like "%Behind the Scenes%";

#5
select first_name, last_name from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
where f.title = 'ZOOLANDER FICTION';

#6
SELECT address, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE store.store_id = 1;

#7
SELECT f1.title AS title1, f2.title AS title2, f1.rating
FROM film f1
JOIN film f2 ON f1.rating = f2.rating AND f1.film_id < f2.film_id;

#8
select distinct f.title, f.release_year, st.first_name as manager_of_store2 from film f
inner join inventory inv on f.film_id = inv.film_id
inner join store s on s.store_id = inv.store_id
inner join staff st on s.manager_staff_id = st.staff_id
where s.store_id = 2;	