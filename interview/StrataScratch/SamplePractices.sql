/* ID 10308: Salaries Differences
Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the difference in salaries.
*/

--output the difference between mark and engi
SELECT abs(max(salary) - (SELECT max(salary) 
FROM db_employee
WHERE department_id = 1
)) difference
FROM db_employee
WHERE department_id = 4

/*
ID 10299: Finding Updated Records
We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. 
Find the current salary of each employee assuming that salaries increase each year. 
Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.
*/


--output id, name, department, current salary
-- calculate current salary (increase by year)

SELECT id, first_name, last_name, max(salary) salary, department_id
FROM ms_employee_salary 
GROUP BY 1, 2, 3, 5
ORDER BY 1


/*
ID 10176: Bikes Last Used
Find the last time each bike was in use. Output both the bike number and the date-timestamp of the bike's last use 
(i.e., the date-time the bike was returned). Order the results by bikes that were most recently used.
*/


--output bike number, last time used
--most recently used (max)
-- order by time last used

SELECT bike_number, max(end_time) AS last_used
FROM dc_bikeshare_q1_2012
GROUP BY 1
ORDER BY 2 DESC



/* ID 10087: Find all posts which were reacted to with a heart
Find all posts which were reacted to with a heart.
*/

--output post id
select distinct p.* from facebook_posts p
join facebook_reactions r on p.post_id = r.post_id
where reaction = 'heart'

/* ID 10061: Popularity of Hack
Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. 
The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. 
Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. 
Luckily the user IDs of employees completing the surveys were stored. Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.
*/
--join two tables
--find average popularity per office
--output location and average popularity 

SELECT location, AVG(popularity) AS average_popularity
FROM facebook_employees e
JOIN facebook_hack_survey s
ON e.id = s.employee_id
GROUP BY location 
ORDER BY 2 DESC

/* ID 10026: Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut
Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut.
Output unique winery values only.
*/

-- select * from winemag_p1;
-- find wine processed by plum, cherry, rose, hazelnut
--ILIKE instead of LIKE to ignore case sensitivity
--output unique wine

SELECT distinct winery
FROM winemag_p1
WHERE description ILIKE '%plum%' OR 
      description ILIKE '%cherry%' OR
       description ILIKE '%rose%' OR
      description  ILIKE '%hazelnut%' 
                       


/*ID 10128: Count the number of movies that Abigail Breslin nominated for oscar
Count the number of movies that Abigail Breslin was nominated for an oscar.
*/


--count movies by abigail breslin
-- output movies

SELECT COUNT(*) AS number_of_movies
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin'

