select 
*,
sum(amount) over (partition by customer_id)
from payment;

select 
f.film_id,
f.title,
f.length,
ca.name as category,
round (avg(length) over (partition by ca.category_id),2) as avg_length_in_category
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category ca
on fc.category_id = ca.category_id
order by f.film_id asc;

select 
*,
count(*) over (partition by amount, customer_id ) as no_payments_with_that_amount
from payment
order by payment_id asc;

select 
flight_id,
departure_airport,
sum(actual_arrival-scheduled_arrival) over (order by flight_id, departure_airport) as flight_lateness 
from flights;

select 
flight_id,
departure_airport,
sum(actual_arrival-scheduled_arrival) over (partition by departure_airport order by flight_id, departure_airport) as flight_lateness 
from flights;

