--The inventory manager asks you how many rentals have not been returned yet. Write a SQL 
--querry to get the answers.
select
count(*)
from public.rental
where return_date is null;

--The sales manager asks you for a list of all the payment_ids with an amount less than or 
--equal to $2. Include payment_id and the amount.
select 
payment_id, amount
from public.payment
where amount <= 2
order by amount desc;

--The support manager asks you about a list of all the payment of the customer 322, 346, 354 
--where the amount is either less than $2 or greater than $10. It should be ordered by the 
--customer first(ASC) and then as second condition order by amount in a descending order.
select *
from public.payment
where (customer_id = 322
or customer_id = 346
or customer_id = 354)
and (amount < 2 
or amount > 10)
order by customer_id asc, amount desc;

--There have been some faulty payments and you need to help to found out how many payments have
--been affected. How many payments have been made on january 26th and 27th 2020 with an amount
--between 1.99 and 3.99?
select
count(*)
from public.payment
where payment_date between '2020-01-26' and '2020-01-27 23:59'
and amount between 1.99 and 3.99;

--There have been 6 complaints of customers about their payments. Customer_id(12,25,67,93,124,234)
--The concerned payments are all the payments of these customers with amounts 4.99,7.99 and 9.99
--in January 2020.
select *
from public.payment
where customer_id in (12,25,67,93,124,234)
and amount in (4.99,7.99,9.99)
and payment_date between '2020-01-01' and '2020-01-31 23:59';

--You need to help the inventory manager to find out how many movies are there that contain
--the "Documentary" in the description?
select 
count(*) 
from public.film
where description ilike '%Documentary%';

--How many customers are there with a first name that is 3 letters long and either an 'X' or a
--'Y' as the last letter in the last name?
select 
count(*)
from public.customer
where length(first_name) = 3
and (last_name like '%X' or last_name like '%Y');

/* How many movies are there that contain 'Saga' in the description and where the title
starts either with 'A' or ends with 'R'? Use the alias 'no_of_movies'.*/
select 
count(*) as no_of_movies
from public.film
where description like '%Saga%'
and (title like 'A%' or title like '%R');

/* Create a list of all customers where the first name contains 'ER' and has an 'A' as the
second letter. Order the results by the last name descendingly.*/
select *
from public.customer
where first_name like '%ER%'
and first_name like '_A%'
order by last_name desc;

/* How many payments are there where the amount is either 0 or is between 3.99 and 7.99 and
in the same time has happened on 2020-05-01.*/
select 
count(*) as no_of_payments
from public.payment
where amount = 0 or amount between 3.99 and 7.99
and payment_date = '2020-05-01 23:59';

--THANK YOU