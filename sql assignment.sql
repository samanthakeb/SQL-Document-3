-- 1. List all customers who live in Texas (use joins)
select customer_id, first_name, last_name
from customer
inner join address
on customer.customer_id = address.address_id 
where address.district = 'Texas';

-- 2. Get all payments above $6.99 with the customers full name
SELECT customer.first_name, customer.last_name, payment.customer_id, payment.amount
FROM customer
RIGHT JOIN payment ON customer.customer_id = payment.customer_id 
WHERE payment.amount > 6.99;
 
-- 3. Show all customers names who have made payments over $175 (use subqueries)
select first_name, last_name
from customer
where customer_id in (
	select customer_id 
	from payment
	where amount > 175
);

-- 4. List all customers that live in Nepal (use the city table)
select customer_id, first_name, last_name
from customer
inner join address 
on customer.address_id = address.address_id 
inner join city 
on address.city_id = city.city_id 
where city = 'Nepal';


-- 5. Which staff member had the most transactions?
select staff_id, COUNT(distinct rental_id) as transaction_count
from rental
group by staff_id 
order by transaction_count desc 
limit 1;

-- 6. How many movies of each rating are there?
select rating, COUNT(*) as movie_count
from film
group by rating;

-- 7. Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE c.customer_id IN (
    SELECT customer_id 
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) = 1 AND MAX(amount) > 6.99
);

-- 8. How many free rentals did our stores give away?
select count(*)
from rental r
inner join payment p on r.rental_id = p.rental_id 
where p.amount = 0;



