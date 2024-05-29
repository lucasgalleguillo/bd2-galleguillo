use sakila;

-- 1
select title from film f left join inventory i using (film_id) where i.inventory_id is null ;

-- 2
select i.inventory_id, f.title from film f 
inner join inventory i using (film_id) 
left join rental r on i.inventory_id = r.inventory_id
where r.rental_id is null;

-- 3
select c.first_name, c.last_name, s.store_id, f.title
from customer c
inner join rental r on c.customer_id = r.customer_id
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join store s on i.store_id = s.store_id
where r.return_date is not null
order by s.store_id, c.last_name;

-- 4

select concat(c.city, ', ', co.country) as store_location, concat(m.first_name, ' ', m.last_name) as manager_name, sum(p.amount) as total_sales
from store s
inner join address a on s.address_id = a.address_id
inner join city c on a.city_id = c.city_id
inner join country co on c.country_id = co.country_id
inner join staff m on s.manager_staff_id = m.staff_id
inner join inventory i on s.store_id = i.store_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by s.store_id
order by total_sales desc;

-- 5
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as film_count from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by film_count desc
limit 1;


