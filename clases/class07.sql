use sakila;

-- 1
select f1.title, f1.rating from film f1
where f1.length <= ALL(select f2.length from film f2
						where f1.film_id <> f2.film_id);
                      
                      
-- 2
select f1.title, f1.length from film f1
where f1.length < ALL(select f2.length from film f2 where f1.film_id <> f2.film_id)
and not exists(select * from film f2 where f2.film_id <> f1.film_id and f2.length <= f1.length);


-- 3

select c.first_name, c.last_name, min(p.amount), a.address from customer c
inner join payment p on c.customer_id = p.customer_id
inner join address a on c.address_id = a.address_id
group by c.first_name, c.last_name, a.address;

select c.first_name, c.last_name, a.address, p.amount from customer c
inner join payment p on c.customer_id = p.customer_id
inner join address a on c.address_id = a.address_id
where p.amount <= ALL(select p1.amount from payment p1 
                    where p1.customer_id = c.customer_id)
group by c.first_name, c.last_name, a.address, p.amount;


-- 4

SELECT customer_id,
	   first_name,
	   last_name,
	   (SELECT MAX(amount) 
	      FROM payment 
	     WHERE payment.customer_id = customer.customer_id) AS max_amount,
		(SELECT MIN(amount) 
	      FROM payment 
	     WHERE payment.customer_id = customer.customer_id) AS min_amount
  FROM customer
 ORDER BY max_amount ;

