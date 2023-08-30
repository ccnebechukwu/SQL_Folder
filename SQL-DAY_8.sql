/* What is the lowest replacement cost? */
select 
min(distinct(replacement_cost))
from public.film;

/* How many films have a replacement cost in the "low" group? - (9.99 - 19.99) */
select 
count(*)
from public.film
where replacement_cost between 9.99 and 19.99;

/* In which category is the longest film and how long is it? */
select 
f.title,
c.name as category,
length
from public.film f
inner join public.film_category fc
on f.film_id = fc.film_id
inner join public.category c
on fc.category_id = c.category_id
where name in('Drama', 'Sports')
group by f.title, c.name, f.length
order by length desc;

/* Which category(name) is the most common among the films? */
select 
count (*) as number_of_movies,
c.name as category
from public.film f
inner join public.film_category fc
on f.film_id = fc.film_id
inner join public.category c
on fc.category_id = c.category_id
group by c.name
order by count(*) desc;

/* Which actor is part of most movies? */
select
a.first_name,
a.last_name,
count(*)
from public.actor a
inner join public.film_actor fa
on a.actor_id = fa.actor_id
inner join public.film f
on fa.film_id = f.film_id
group by a.first_name, a.last_name
order by count(*) desc;

/* How many addresses are not associated to any customer? */ 
select *
from public.address a
left join public.customer c
on a.address_id = c.address_id
where c.first_name is null;

/* Which city has the most sales? */
select
ct.city,
sum(amount)
from public.address a
inner join public.customer c
on a.address_id = c.address_id
inner join public.payment p
on c.customer_id = p.customer_id
inner join public.city ct
on a.city_id = ct.city_id
group by ct.city
order by sum(amount) desc;

/* Which country, city has the least sales? */
select
co.country,
ct.city,
concat(co.country,ct.city) "country, city",
sum(amount)
from public.address a
inner join public.customer c
on a.address_id = c.address_id
inner join public.payment p
on c.customer_id = p.customer_id
inner join public.city ct
on a.city_id = ct.city_id
inner join public.country co
on ct.country_id = co.country_id
group by ct.city, co.country, concat(co.country, ct.city) 
order by sum(amount) asc;

/* 


