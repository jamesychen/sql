--SUM

SELECT SUM(o.poster_qty) sum_poster
FROM orders o

SELECT SUM(standard_qty) total_stdq
FROM orders

SELECT SUM(total_amt_usd) 
FROM orders

SELECT standard_amt_usd + gloss_amt_usd total_amt
FROM orders

SELECT SUM(standard_amt_usd)/SUM(standard_qty)  std_per_unit 
FROM orders

--MIN, MAX
SELECT MIN(occurred_at)
FROM web_events 

SELECT occurred_at
FROM web_events 
ORDER BY occurred_at 
LIMIT 1

SELECT MAX(occurred_at)
FROM web_events 

SELECT occurred_at
FROM web_events 
ORDER BY occurred_at DESC
LIMIT 1

SELECT AVG(standard_amt_usd) avg_std, AVG(gloss_amt_usd) avg_gls, AVG(poster_amt_usd)avg_post, AVG(standard_qty) avg_stdq, AVG(gloss_qty)avg_gls, AVG(poster_qty)avg_post
FROM orders

--MEDIAN
SELECT *
FROM (SELECT total_amt_usd
FROM orders
ORDER BY total_amt_usd 
LIMIT 3457) AS t1
ORDER BY total_amt_usd DESC
LIMIT 2


--GROUPBY
SELECT a.name, MIN(w.occurred_at) early
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.name
ORDER BY early

SELECT a.name, w.occurred_at
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1

SELECT a.name, SUM(o.total_amt_usd) total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1

SELECT channel, count(channel) used_time
FROM web_events
GROUP BY channel

SELECT w.occurred_at, a.primary_poc
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1

SELECT a.name, o.total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY total_amt_usd


SELECT r.name region_name, COUNT(s.name) sales_num
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY sales_num

SELECT a.name, AVG(o.standard_qty) SQ, AVG(o.gloss_qty)GQ, AVG(o.poster_qty) PQ
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name


SELECT a.name, AVG(o.standard_amt_usd) SQ, AVG(o.gloss_amt_usd)GQ, AVG(o.poster_amt_usd) PQ
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name

SELECT s.name, w.channel, COUNT(*) num
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN web_events w
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY num DESC


SELECT r.name, w.channel, COUNT(*) num
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN web_events w
ON w.account_id = a.id
GROUP BY r.name, w.channel
ORDER BY num DESC

DISTINCT!!
SELECT a.name acc_name, r.name reg_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
On s.region_id = r.id

SELECT DISTINCT a.name, s.name s_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id

SELECT DISTINCT name 
FROM sales_reps

SELECT DISTINCT id, name
FROM accounts

SELECT s.name, s.id, COUNT(*)num
FROM sales_reps s
JOIN accounts a
On a.sales_rep_id = s.id
GROUP BY s.name, s.id
HAVING COUNT(*) > 5
ORDER BY num

SELECT a.name, COUNT(*)num_orders
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING COUNT(*) >20
ORDER BY num_orders

SELECT a.name, COUNT(*)num_orders
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1

SELECT a.name, SUM(total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(total_amt_usd) >30000
ORDER BY total_usd DESC

SELECT a.name, SUM(total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(total_amt_usd) <1000
ORDER BY total_usd DESC

SELECT a.name, SUM(total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_usd DESC
LIMIT 1

SELECT a.name, SUM(total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_usd
LIMIT 1

SELECT a.name, w.channel, COUNT(*) ctimes
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook' AND COUNT(*)>6
ORDER BY ctimes


SELECT a.name, w.channel, COUNT(*) ctimes
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook'
ORDER BY ctimes DESC 
LIMIT 1

SELECT a.name, w.channel, COUNT(*) ctimes
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.name, w.channel
ORDER BY ctimes DESC 
