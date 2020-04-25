--Segmenting by countries, marketing sources, and phone types

--for the registrations:

SELECT country, count(*) 
FROM registration 
GROUP BY country
ORDER BY count DESC;

SELECT source, count(*) 
FROM registration 
GROUP BY source
ORDER BY count DESC;

SELECT phone_type, count(*) 
FROM registration 
GROUP BY phone_type
ORDER BY count DESC;

--from the above queries we get to know that our biggest segments are: US (country), invitation from a friend (source), and Android users (phone type).
--What about the subsegments? Here is the query to find it out:

SELECT country, source, phone_type, count(*) 
FROM registration 
GROUP BY country, source, phone_type
ORDER BY count DESC;

--The biggests subsegments based on country, marketing source, and user's phone type are:
--US     - invite_a_friend - android
--US     - invite_a_friend - error (missing information on the phone type)
--Brazil - invite_a_friend - android 

--To check the data for free tree and super tree sends we have to bring the necessary data from the registration data. I'll use JOIN for that:

SELECT country, count(*) 
FROM registration 
JOIN free_tree
ON registration.user_id = free_tree.user_id
GROUP BY country
ORDER BY count DESC;

--Similarly to the queries on the registrations queries, we discover that the biggest segments amount users who used a free tree function are: US (country), invitation from a friend (source), and Android users (phone type).
 
--The biggest subsegments amoung the free tree senders are(the respective query below):
--US     - invite_a_friend - android
--US     - invite_a_friend - error
--Sweden - invite_a_friend - android

SELECT country, source, phone_type, count(*) 
FROM registration 
JOIN free_tree
ON registration.user_id = free_tree.user_id
GROUP BY country, source, phone_type
ORDER BY count DESC;

--The results for the super tree senders:
--The biggest segments: US (country), invitation from a friend (source), and Android users (phone type).
--The subsegments:
--US     - invite_a_friend - android
--US     - invite_a_friend - error
--Brazil - invite_a_friend - android

--From this preliminary analysis, we can clearly see the segments that are important for the business. 
--Those would be the users from US and Android users. We also see that referrals bring the most users out of all acquisition channels.

