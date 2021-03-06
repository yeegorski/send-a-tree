--In this complex query first I extract the data like user IDs (and the count of user IDs, which is 1 in all instances in registrations),
--countries, sources, and phone types from the registration table.
--Then one by one I add the distinct user IDs counts from the free_tree table and super_tree.
--Lastly, I extract users who send more than one super tree, and add them also as a separate column to the final table.
--This query was directly inserted into Google Data Studio -- the final report is saved as pdf in the folder Week 4.


SELECT reg_free_super_f.user_id,
       reg_free_super_f.source,
       reg_free_super_f.phone_type,
       reg_free_super_f.country,
       reg_free_super_f.registration,
       reg_free_super_f.free_tree,
       reg_free_super_f.super_tree_first,
       COUNT(DISTINCT (super_paid.user_id)) AS super_tree_paid
FROM (SELECT reg_free.user_id,
             reg_free.source,
             reg_free.phone_type,
             reg_free.country,
             reg_free.registration,
             reg_free.free_tree,
             COUNT(DISTINCT (super_first.user_id)) AS super_tree_first
      FROM (SELECT reg.user_id,
                   reg.source,
                   reg.phone_type,
                   reg.country,
                   reg.registration,
                   COUNT(DISTINCT (free_tree.user_id)) AS free_tree
            FROM (SELECT user_id, source, phone_type, country,
                         COUNT(user_id) AS registration
                  FROM registration
                  GROUP BY user_id, source, phone_type, country) AS reg
              FULL JOIN free_tree ON reg.user_id = free_tree.user_id
            GROUP BY reg.user_id,
                     reg.source,
                     reg.phone_type,
                     reg.country,
                     reg.registration) AS reg_free
        FULL JOIN (SELECT user_id,
                          COUNT(DISTINCT (user_id))
                   FROM super_tree
                   GROUP BY user_id) AS super_first ON reg_free.user_id = super_first.user_id
      GROUP BY reg_free.user_id,
               reg_free.source,
               reg_free.phone_type,
               reg_free.country,
               reg_free.registration,
               reg_free.free_tree) AS reg_free_super_f
  FULL JOIN (SELECT user_id,
                    COUNT(DISTINCT (user_id))
             FROM super_tree
             GROUP BY user_id
             HAVING COUNT(user_id) > 1) AS super_paid ON reg_free_super_f.user_id = super_paid.user_id
GROUP BY reg_free_super_f.user_id,
         reg_free_super_f.source,
         reg_free_super_f.phone_type,
         reg_free_super_f.country,
         reg_free_super_f.registration,
         reg_free_super_f.free_tree,
         reg_free_super_f.super_tree_first;
         
--The query result looks like this (first 10 rows):
--If a user sent free_tree, first super_tree, or paid super_tree, 1 would appear in the respective column.
--user_id	source		phone_type	country		registration	free_tree	super_tree_firstsuper_tree_paid
--1000001	invite_a_friend	android		sweden		1		1		0		0
--1000002	invite_a_friend	ios		united_states	1		1		0		0
--1000003	invite_a_friend	error		sweden		1		1		0		0
--1000004	invite_a_friend	error		germany		1		0		0		0
--1000005	invite_a_friend	ios		united_states	1		1		0		0
--1000006	invite_a_friend	android		sweden		1		1		0		0
--1000007	invite_a_friend	android		sweden		1		1		1		0
--1000008	article		android		united_states	1		0		0		0
--1000009	invite_a_friend	android		united_states	1		1		0		0
--1000010	invite_a_friend	error		brazil		1		1		1		1
