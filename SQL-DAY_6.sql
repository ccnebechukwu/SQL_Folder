/* The airline wants to understand in which category they sell most tickets. How many 
people choose seats in the category: 1. Business, 2. Economy, 3. Comfort? 
You need to work on the seats table and the boarding_passes table.*/
select 
count(*) as sales_count,
fare_conditions
from boarding_passes
inner join seats
on boarding_passes.seat_no = seats.seat_no
group by fare_conditions;

/* The flight company is trying to find out what their most popular seats are. Try to
find out which seat has been chosen most frequently. Make sure all seats are included
even if they have never been booked. Are there seats that have never been booked?*/
select 
s.seat_no,
count(*) as frequency
from seats s
left join boarding_passes b
on s.seat_no = b.seat_no
group by s.seat_no
order by count(*) desc;

/* Try to find out which line (A, B, ..., H) has been chosen most frequently.*/
select 
right(s.seat_no,1),
count(*) as frequency
from seats s
left join boarding_passes b
on s.seat_no = b.seat_no
group by right(s.seat_no,1)
order by count(*) desc;

/* The company wants to run a phone call campaign on all customers in Texas(=district).
What are the customers(first_name, last_name, phone number and their district) from
Texas? Are there any (old) addresses that are not related to any customer? */
select 
first_name,
last_name,
phone,
district
from public.customer c
full join public.address a
on c.address_id = a.address_id
where district like '%Texas%';

select 
c.address_id,
address
from public.customer c
full join public.address a
on c.address_id = a.address_id
where c.address_id is null;

/* The company wants to customize their campaigns to customers depending on the country
they are from. Which customers are from Brazil? Write a querry to get first_name,
last_name, email and the country from all customers from Brazil */
select
first_name,
last_name,
email,
country
from public.customer c
inner join public.address a
on c.address_id = a.address_id
inner join public.city ct
on a.city_id = ct.city_id
inner join public.country co
on co.country_id = ct.country_id
where country like '%Brazil%';






