/* Return all the films that are available in the inventory in store 2 more than 3 times
*/
select *
from public.film
where film_id 
in
(select 
film_id
from public.inventory
where store_id=2
group by film_id
having count(*)>3);

/* Return all customers' first and last name that have made a payment on '2020-01-25'.*/
select
first_name,
last_name
from public.customer
where customer_id 
in
(select 
customer_id
from public.payment
where date(payment_date) = '2020-01-25');

/* Return all customers' first_name and email addresses
that have spent more than $30 */
select
first_name,
email
from public.customer
where customer_id
in
(select 
customer_id
from public.payment
group by customer_id
having sum(amount) > 30);

/* Return all the customers' first and last names that are
from California and have spent more than 100 in total.*/
select
first_name,
last_name
from public.customer
where customer_id
in
(select 
cu.customer_id
from public.city c
inner join address a
on c.city_id = a.city_id
inner join customer cu
on cu.address_id = a.address_id
inner join payment p
on cu.customer_id = p.customer_id
where district = 'California'
group by cu.customer_id
having sum(amount) > 100)

/* what is the average total amount spent per day(average daily revenue)?*/
select 
round(avg(sum_of_payment),2) as avg_per_day
from
(select
date(payment_date),
sum(amount) as sum_of_payment
from public.payment p
group by date(payment_date)) as subquerry;

/* Show all the payments together with how much the payment amount is below the 
maximum payment amount.*/
select *,
(select 
max(amount)
 from public.payment
)-amount as max_amount_difference
from public.payment;

/* Show only movie titles, their associated film_id and replacement_cost with the 
lowest replacement_costs in each rating category - also show the rating.*/
select
title,
film_id,
replacement_cost,
rating
from public.film f1
where replacement_cost = (select
	   min(replacement_cost)
	  from public.film f2
	  where f1.rating = f2.rating);
	  
/* Show only those movie titles, their associated film_id, and the length that have 
the highest lenght in each rating category - also show the rating.*/
select
title,
film_id,
length,
rating
from public.film f1
where length = (select 
			    max(length)
			   from public.film f2
				where f1.rating = f2.rating
			   )

/* Show all the payments plus the total amount for every customer as well as the
number of payments of each customer.*/
select
payment_id,
customer_id,
staff_id,
amount,
(select sum(amount) as sum_amount
 from public.payment p2
 where p1.customer_id = p2.customer_id
),
(select count(amount) as count_payments
from public.payment p2
where p1.customer_id = p2.customer_id)
from payment p1
order by customer_id, amount desc;

/* Show only the highest replacement costs for each rating and their average. */
select title,
replacement_cost,
rating,
(select avg(replacement_cost)
from film f1
where f1.rating = f2.rating)
from film f2
where replacement_cost = (select
						 max(replacement_cost)
						 from film f3
						 where f2.rating = f3.rating);
						 
/* Show the top payments for each customer including the payment_id. How would you 
solve this question if you would not need to include thye payment_id? */
select
first_name,
amount,
payment_id
from payment p1
inner join customer c
on p1.customer_id = c.customer_id
where amount = (select
			   max(amount)
			   from payment p2
			   where p1.customer_id = p2.customer_id);

/* Without payment_id. */
select
first_name,
max(amount)
from payment p1
inner join customer c
on p1.customer_id = c.customer_id
group by first_name;




