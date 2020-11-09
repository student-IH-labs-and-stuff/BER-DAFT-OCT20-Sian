#stage 1 - most prolific 

# film_actor and film 
#qu :  Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select actor_id  from film_actor
inner join film
using (film_id)
group by actor_id
order by count(film_id) desc
limit 1

#next -get the films this person starred in 

# select films from list of films starring actor in subquery above ---


select a.film_id, f.title from film_actor as a
join film as f using (film_id)

where actor_id =  
(
select actor_id  from film_actor
inner join film
using (film_id)
group by actor_id
order by count(film_id) desc
limit 1 
)
order by release_year desc


# Customers who spent more than the average payments?
# first find avg, then look for customers with > avg 
# customer table + payment table 

select customer_id, sum(amount) as payment
from customer
inner join payment
using (customer_id)
group by customer_id
having sum(amount) 
> (
select avg(total_payment)
from 
(
select customer_id, sum(amount) total_payment
from payment
group by customer_id
) as t
)
order by payment desc;


