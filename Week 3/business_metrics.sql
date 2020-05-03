--Calculating daily active users (union of users who send free trees and super trees)

SELECT date,
       COUNT(DISTINCT (user_id)) as active_users
FROM (SELECT * FROM free_tree UNION ALL SELECT * FROM super_tree) AS free_super
GROUP BY DATE;

--date 		active_users
--2019-09-13	79
--2019-09-14	132
--2019-09-15	155
--2019-09-16	216
--2019-09-17	254
--2019-09-18	286
--2019-09-19	322
--2019-09-20	361
--2019-09-21	344
--2019-09-22	372
--...
--2020-02-05	3233
--2020-02-06	3380
--2020-02-07	3353
--2020-02-08	3269
--2020-02-09	3270
--...
--2020-04-26	9119
--2020-04-27	9387
--2020-04-28	9646
--2020-04-29	9832
--2020-04-30	9940
--2020-05-01	9926

--To see only the data from the last day available aka yesterday:

SELECT date,
       COUNT(DISTINCT (user_id)) AS active_users
FROM (SELECT * FROM free_tree UNION ALL SELECT * FROM super_tree) AS free_super
GROUP BY DATE
HAVING date = (SELECT CURRENT_DATE -1 AS yesterday);

--date		active_users
2020-05-02	9598


--To calculate the daily revenue for the last day available aka yesterday (keeping in mind that free super tree is free)

SELECT COUNT(user_id)
  -(SELECT COUNT(DISTINCT (user_id))                       --here I'm checking the number of people who have already sent super trees on the previous days
      -(SELECT COUNT(DISTINCT (user_id))                   --so that I can check how many first timers I have in a given day 
        FROM super_tree                                    --then I substract that number from all super trees sent in a given day to get the actual revenue
        WHERE DATE < CURRENT_DATE -1) AS not_first_timers
    FROM super_tree) AS daily_revenue
FROM super_tree
WHERE DATE = CURRENT_DATE -1;

--the result (for the data from May 2, 2020):

--daily_revenue
--616
