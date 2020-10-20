/*Lab | SQL Self and cross join
In this lab, you will be using the Sakila database of movie rentals.

Instructions
	Get all pairs of actors that worked together.
	Get all pairs of customers that have rented the same film more than 3 times.
	Get all possible pairs of actors and films.*/
    
USE sakila;

-- 1) Get all pairs of actors that worked together.
CREATE VIEW ac1 AS SELECT actor.actor_id, concat(first_name, ' ', last_name) as full_name, film_id from actor
INNER JOIN film_actor on actor.actor_id = film_actor.actor_id;

CREATE VIEW ac2 AS SELECT actor.actor_id, concat(first_name, ' ', last_name) as full_name, film_id from actor
INNER JOIN film_actor on actor.actor_id = film_actor.actor_id;

SELECT * FROM ac1 
JOIN ac2  on ac1.film_id = ac2.film_id and ac1.actor_id <> ac2.actor_id
ORDER BY ac1.actor_id;

-- 2) Get all pairs of customers that have rented the same film more than 3 times.
CREATE VIEW tab1 as SELECT rental.customer_id as customer_id, film_id, count(rental_id) as film_count
FROM rental
INNER JOIN inventory on rental.inventory_id = inventory.inventory_id
GROUP BY rental.customer_id, film_id
ORDER BY rental.customer_id;

SELECT * FROM tab1
WHERE film_count > 3;

CREATE VIEW tab2 as SELECT rental.customer_id as customer_id, film_id, count(rental_id) as film_count
FROM rental
INNER JOIN inventory on rental.inventory_id = inventory.inventory_id
GROUP BY rental.customer_id, film_id
ORDER BY rental.customer_id;

SELECT tab1.customer_id, tab1.film_id, tab1.film_count, tab2.customer_id, tab2.film_count FROM tab1
JOIN tab2 ON tab1.customer_id <> tab2.customer_id and tab1.film_id = tab2.film_id
GROUP BY tab1.customer_id, tab1.film_count, tab1.film_id, tab2.customer_id
HAVING tab1.film_count = 2 and tab2.film_count = 2;

-- 3) Get all possible pairs of actors and films.
SELECT * from (select distinct actor.actor_id from actor) tab1
CROSS JOIN 
(select distinct film_id from film) tab2
ORDER BY actor_id, film_id;

