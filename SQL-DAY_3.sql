/* Your manager wants to get a better understanding of the films. That's why you are asked to
write a query to see the (1.) Minimum (2.) Maximum (3.) Average(rounded) (4.) Sum of the 
replacement cost of the films.*/
select 
min(replacement_cost),
max(replacement_cost),
round(avg(replacement_cost),2) as average_cost,
sum(replacement_cost)
from public.film;

/* Your manager wants to know which of the two employees(staff_id) is responsible for more
payments? Which of the two is responsible for a higher overall payment amount? How do these
amounts change if we don't consider amounts equal to 0?*/
select 
staff_id,
count(payment_id),
sum(amount)
from public.payment
group by staff_id;

select 
staff_id,
count(payment_id),
sum(amount)
from public.payment
where amount != 0
group by staff_id;

/* There are two competitions between the two employees. Which employee had the highest sales 
amount in a single day? Which employee had the most sales in a single day(not counting payments
with amount = 0?)*/
select 
staff_id,
sum(amount),
date(payment_date)
from public.payment
group by staff_id, date(payment_date)
order by sum(amount) desc;

select 
staff_id,
count(*) as no_of_sales,
date(payment_date)
from public.payment
where amount != 0
group by staff_id, date(payment_date)
having count(*) > 400
order by count(*) desc;

/* In 2020, April 28, 29 and 30 were days with very high revenue. That's why we want to focus 
in this task only on these days(filter accordingly). Find out what is the average payment amount 
grouped by customer and day - consider only the days/customers with more than 1 payment
(per customer and day). Order by the average amount in a descending order.*/
select 
date(payment_date),
round(avg(amount), 2) as avg,
customer_id,
count(*) as no_of_payments
from public.payment
where date(payment_date) in ('2020-04-28', '2020-04-29', '2020-04-30')
group by customer_id, date(payment_date)
having count(*) > 1
order by avg(amount) desc;

--THANK YOU!