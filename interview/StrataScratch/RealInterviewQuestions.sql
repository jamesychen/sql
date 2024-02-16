   
--Employee Project Budege by Microsoft--

-- inner join (exclude project with no employee)
--budget to employee ratio = budget/count(employee)
-- group by name, budget
-- order by ratio DESC


SELECT mp.title project, mp.budget/COUNT(*) ratio
FROM ms_projects mp
JOIN ms_emp_projects ep
ON mp.id = ep.project_id
GROUP BY 1, budget
ORDER BY 2 DESC
LIMIT 5



--postmates, find the highest growth and lowest drop by city, by month(march, april)  --


-- extract month, city, sum amount by month and city--
WITH city_order_amt as (
SELECT extract(month from order_timestamp_utc)
  ,m.name 
  ,SUM(o.amount) amount
FROM postmates_orders o
JOIN postmates_markets m ON o.city_id=m.id
GROUP BY 1,2
ORDER BY name 
)

-- sum amount by month and subtract them to get growth -- 
, collapsed as (SELECT name
    , SUM(CASE WHEN date_part = 4 THEN amount ELSE NULL END) - SUM(CASE WHEN date_part = 3 THEN amount ELSE NULL END) amount_difference
FROM city_order_amt
GROUP BY 1
ORDER BY name 
)

-- select max and min 

SELECT *
FROM collapsed 
WHERE amount_difference  = (SELECT MAX(amount_difference) FROM collapsed)
OR amount_difference  = (SELECT MIN(amount_difference) FROM collapsed)


--google count the receiving emails by labels(promo, social, shopping)

SELECT to_user 
  ,SUM(CASE WHEN l.label='Promotion' THEN 1 else 0 END) promotion
  ,SUM(CASE WHEN l.label= 'Social' THEN 1 else 0 END) social
  ,SUM(CASE WHEN l.label= 'Shopping' THEN 1 else 0 END) shopping
FROM google_gmail_emails e 
JOIN google_gmail_labels l ON e.id=l.email_id
GROUP BY 1


---- median


SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY age)
FROM olympics_athletes_events
WHERE medal = 'Gold'

------ hard

WITH amounts_by_months AS (
SELECT EXTRACT(month from invoicedate) AS month
  ,description 
  ,RANK() OVER (Partition by EXTRACT(month from invoicedate) ORDER BY SUM(unitprice*quantity) DESC)
  ,SUM(unitprice*quantity) AS amount_paid
FROM online_retail
GROUP BY 1,2)

SELECT month
  ,description  
  ,amount_paid 
FROM amounts_by_months
WHERE rank=1
ORDER BY 1,2



WITH amounts_by_months AS (
SELECT EXTRACT(month from invoicedate) AS month
  ,description 
  ,SUM(unitprice*quantity) AS amount_paid
FROM online_retail
GROUP BY 1,2)

SELECT month
  ,description  
  ,amount_paid 
FROM amounts_by_months
WHERE (month, amount_paid) IN (SELECT month, MAX(amount_paid) FROM amounts_by_months GROUP BY 1)
ORDER BY 1,2


WITH amounts_by_months AS (
SELECT to_char( invoicedate,'YYYY-MM') AS month
  ,description 
  ,SUM(unitprice*quantity) AS amount_paid
FROM online_retail
GROUP BY 1,2
ORDER BY 1
)
