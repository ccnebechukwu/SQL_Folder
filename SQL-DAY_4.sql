/* In the email system there was a problem with names where either the first name or the last
name is more than 10 characters long. Find these customers and output the list of these first
and last names in all lower case.*/
select 
customer_id,
lower(first_name) as First_Name,
lower(last_name) as Last_Name,
lower(email) as Email
from public.customer
where length(lower(first_name)) > 10 
or length(lower(last_name)) > 10;

/* Extract the last 5 characters of the email address first. The email address always ends
with '.org'. How can you extract just the dot '.' from the email address?*/
select 
lower(email) as email,
right(email, 5),
right(left(right(email, 5),2),1) as dot
from public.customer;

/* You need to create an anonymized version of the email addresses. It should be the first
character followed by '***' and then the last part starting with '@'. Note the email address
always ends with '@sakilacustomer.org'.*/
select 
email,
left(email, 1) || '***' || '@sakilacustomer.org' as anonymized_email
from public.customer;

/* In this challenge you have only the email address and the last name of the customers.
You need to extract the first name from the email address and concatenate it with the last
name. It should be in the form: "Last name, First name".*/
select
email,
last_name,
left(email, position('.' in email)-1) as first_name,
last_name || ', ' || left(email, position('.' in email)-1) as full_name
from public.customer;

/* You need to create an anonymized form of the email addresses in the following way:
M***.S***@sakilacustomer.org. In a second query create an anonymized form of the email
addresses in the following way: ***Y.S***@sakilacustomer.org*/
select 
email,
substring(email from 1 for 1) 
|| '***' 
|| substring(email from position('.' in email) for 2)
|| '***' ||right(email,19)
from public.customer;

select
email,
'***' 
|| substring(email from position('.'in email)-1 for 1) 
|| substring(email from position('.' in email) for 2) 
|| '***'
|| right(email,19)
from public.customer;

/* You need to analyze the payments and find out the following: 
1. What is the month with the highest total payment amount?
2. What is the day of week with the highest total payment amount? (0 is Sunday)
3. What is the highest amount one customer has spent in a week?*/
select 
extract(month from payment_date) as month,
sum(amount) as amount
from public.payment
group by extract(month from payment_date)
order by sum(amount) desc;

select 
customer_id,
extract(dow from payment_date) as dow,
sum(amount) as amount
from public.payment
group by extract(dow from payment_date), customer_id
order by sum(amount) desc;

select 
customer_id,
sum(amount) as amount,
extract('week' from payment_date) as week
from public.payment
group by customer_id, extract('week' from payment_date)
order by sum(amount) desc;

/* You need to sum payments and group in the following formats:
1. Fri, 24/01/2020
2. May, 2020
3. Thu,02:44 */
select 
sum(amount) as amount,
to_char(payment_date, 'Dy, dd/mm/yyyy') as day
from public.payment
group by day
order by sum(amount) desc;

select 
sum(amount) as amount,
to_char(payment_date, 'Mon, yyyy') as day
from public.payment
group by day
order by sum(amount) desc;

select 
sum(amount) as amount,
to_char(payment_date, 'Dy, hh:mi') as day
from public.payment
group by day
order by sum(amount) desc;

/* You need to create a list for the support team of all rental durations of customer with
customer_id 35. Also you need to find out for the support team which customer has the longest
average rental duration?*/
select
current_timestamp,
customer_id,
return_date - rental_date as rental_duration
from public.rental
where customer_id = 35;

select
current_timestamp,
customer_id,
avg(return_date - rental_date) as avg_rental_duration
from public.rental
group by customer_id
order by avg_rental_duration desc;

--THANK YOU!
