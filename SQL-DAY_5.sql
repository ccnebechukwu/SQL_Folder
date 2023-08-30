/* Your manager is thinking about increasing the prices for films that are more expensive to
replace. For that reason, you should create a list of the films including the relation of rental
rate/replacement cost where the rental rate is less than 4% of the replacement cost. Also, create
a list of that film_ids together with the percentage rounded to 2 decimal places. For example
3.54(=3.54%).*/
select 
film_id,
round(rental_rate/replacement_cost*100,2) as percentage
from public.film
where round(rental_rate/replacement_cost*100,2) < 4.00
order by round(rental_rate/replacement_cost*100,2) desc;

/* You need to find out how many tickets you have sold in the following categories:
- Low price ticket: total_amount < 20,000
- Mid price ticket: total_amount between 20,000 and 150,000
- High price ticket: total_amount >= 150,000
How many high price tickets has the company sold?*/
select 
sum(total_amount) total_amount,
count(book_ref) as number_of_tickets,
case
when total_amount <20000 then 'Low price ticket'
when total_amount between 20000 and 150000 then 'Mid price ticket'
when total_amount >=150000 then 'High price ticket'
end as pricing
from bookings.bookings
group by pricing;

/* You need to find out how many flights have departed in the following seasons:
- Winter: December, January, February
- Spring: March, April, May
- Summer: June, July, August
- Fall: September, October, November */
select 
count (*) as flights,
case
when extract(month from scheduled_departure) in (12, 1, 2) then 'Winter'
when extract(month from scheduled_departure) <= 5 then 'Spring'
when extract(month from scheduled_departure) <=8 then 'Summer'
when extract(month from scheduled_departure) in (9, 10, 11) then 'Fall'
end as season
from bookings.flights
group by season;

/* You want to create a tier list in the following way:
1. Rating is 'PG' or 'PG-13' or length is more than 210 min: 'Great rating or 
long(tier 1)'
2. Description contains 'Drama' and length is more than 90 min: 'Long drama(tier 2)'
3. Description contains 'Drama' and length is not more than 90 min: 'Short drama
(tier 3)'
4. Rental_rate less than $1: 'Very cheap(tier 4)'
If one movie can be in multiple categories it gets the higher tier assigned.
How can you filter to only those movies that appear in one of these 4 tiers?*/
select
title,
case
when rating in ('PG','PG-13') or length >210 then 'Great rating or long(tier 1)'
when description like '%Drama%' and length >90 then 'Long drama(tier 2)'
when description like '%Drama%' and length <=90 then 'Short drama(tier 3)'
when rental_rate <1 then 'Very cheap(tier 4)'
end as tier_rating
from public.film
where 
case
when rating in ('PG','PG-13') or length >210 then 'Great rating or long(tier 1)'
when description like '%Drama%' and length >90 then 'Long drama(tier 2)'
when description like '%Drama%' and length <=90 then 'Short drama(tier 3)'
when rental_rate <1 then 'Very cheap(tier 4)'
end is not null

