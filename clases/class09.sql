-- 1
select co.country_id as id, co.country as country_name, count(ci.city_id) as amount_city from country co
inner join city ci on co.country_id = ci.country_id
group by co.country_id
order by co.country, co.country_id;

-- 2
select co.country_id as id, co.country as country_name, count(ci.city_id) as amount_city from country co
inner join city ci on co.country_id = ci.country_id
group by co.country_id
having amount_city > 10
order by amount_city desc;

-- 3
select first_name, last_name, a.address as address, 
		(select count(*) from rental r where r.customer_id=c.customer_id) as films_rental,
        (select sum(amount) from payment p where p.customer_id=c.customer_id) as total_spent 
        from customer c
inner join address a on c.address_id=a.address_id
group by first_name, last_name, a.address, c.customer_id
order by total_spent desc;


-- 4
select c.name, avg(length) as promedio from category c 
inner join film_category fc on fc.category_id= c.category_id
inner join film f on f.film_id=fc.film_id
group by c.name
order by promedio desc;

-- 5
select rating, sum(p.amount) as venta from film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id= i.inventory_id
inner join payment p on r.rental_id= p.rental_id
group by rating
order by venta desc;