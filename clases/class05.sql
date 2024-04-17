-- 1
select first_name, last_name from actor c1 
where exists(select * from actor c2     
			where c1.last_name = c2.last_name and c1.actor_id <> c2.actor_id    
            )order by c1.last_name;

-- 2
select * from actor c 
where c.actor_id not in(select fa.actor_id from film_actor fa);

-- 3
select c.first_name, c.last_name from customer c 
inner join rental r on c.customer_id = r.customer_id 
group by c.customer_id having 1=count(c.customer_id);

-- 4
select c.first_name, c.last_name from customer c 
inner join rental r on c.customer_id = r.customer_id 
group by c.customer_id having 1=count(c.customer_id);

-- 5
select a.first_name, a.last_name, f.title from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id 
inner join film f on fa.film_id = f.film_id 
where f.title in ('BETRAYED REAR', 'CATCH AMISTAD');

-- 6
select a.first_name, a.last_name, f.title from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id 
inner join film f on fa.film_id = f.film_id 
where f.title in ('BETRAYED REAR') and 
a.actor_id NOT IN ( SELECT a.actor_id FROM actor a     
					JOIN film_actor fa  ON a.actor_id = fa.actor_id     
					JOIN film f ON fa.film_id = f.film_id     
					WHERE f.title = 'CATCH AMISTAD' );

-- 7
select a.first_name, a.last_name, f.title from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id 
inner join film f on fa.film_id = f.film_id 
where f.title in ('BETRAYED REAR') and 
a.actor_id IN ( SELECT a.actor_id FROM actor a     
					JOIN film_actor fa  ON a.actor_id = fa.actor_id     
					JOIN film f ON fa.film_id = f.film_id     
					WHERE f.title = 'CATCH AMISTAD' );
                    
-- 8
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE title IN ('BETRAYED REAR', 'CATCH AMISTAD')
    )
);

