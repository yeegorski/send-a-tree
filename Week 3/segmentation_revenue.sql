-- 1.What's the total revenue for the invitation program?
-- To answer this question, we have to join the registration data (to extract the users from the invitation program) with the super tree sends data (to calculate the actual revenue)

SELECT registration.source,
       (COUNT(super_tree.user_id) - COUNT(DISTINCT (super_tree.user_id))) AS revenue --here I substract the number of unique users as the first super tree is sent for free
       FROM registration
  JOIN super_tree ON registration.user_id = super_tree.user_id
GROUP BY registration.source
ORDER BY revenue DESC;

--the answer is (as of May 2, 2020):

--source		revenue
--invite_a_friend	46995
--google		5897
--article		555
--paid			0	zero means that these users send a super tree only once, therefore, they did not bring any revenue


-- 2.What's the total revenue by phone_type? And by birth_year?
-- Same logic:

SELECT registration.phone_type, (COUNT(super_tree.user_id)-COUNT(DISTINCT(super_tree.user_id))) as revenue --here I substract the number of unique users as the first super tree is sent for free
FROM registration
JOIN super_tree
ON registration.user_id = super_tree.user_id
GROUP BY registration.phone_type
ORDER BY revenue DESC;

SELECT registration.birth_year, (COUNT(super_tree.user_id)-COUNT(DISTINCT(super_tree.user_id))) as revenue --here I substract the number of unique users as the first super tree is sent for free
FROM registration
JOIN super_tree
ON registration.user_id = super_tree.user_id
GROUP BY registration.birth_year
ORDER BY revenue DESC;

--the answers (as of May 2, 2020):

--phone_type	revenue
--android	27420
--error		24875
--ios		1152

--birth_year	revenue
--1993		13660
--1992		12577
--1991		11833
--1990		6201
--1994		4497
--1995		1373
--1989		1283
--1988		1113
--1996		477
--1987		219
--1997		193
--1998		13
--1999		5
--2000		3
--1986		0
--1985		0

--3.What's the total revenue for Android users, from Brazil or United States, from the invitation program?


SELECT registration.source,
       registration.phone_type,
       registration.country,
       (COUNT(super_tree.user_id) - COUNT(DISTINCT (super_tree.user_id))) AS revenue --here I substract the number of unique users as the first super tree is sent for free
       FROM registration
  JOIN super_tree ON registration.user_id = super_tree.user_id
GROUP BY registration.source,
         registration.phone_type,
         registration.country
HAVING registration.source = 'invite_a_friend' --using HAVING to see the requested outputs
   AND registration.phone_type = 'android'
   AND (registration.country = 'brazil' OR registration.country = 'united_states');

--the answer (as of May 2, 2020):

--source		phone_type	country		revenue
--invite_a_friend	android		brazil		11489
--invite_a_friend	android		united_states	12432



