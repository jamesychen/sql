SELECT accounts.*, orders.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id

SELECT standard_qty, gloss_qty, poster_qty, website, primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, 
       orders.poster_qty,  accounts.website, 
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id


SELECT r.name region, s.name salesrep, a.name accounts
FROM sales_reps s
JOIN region r 
ON s.region_id = r.id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name

SELECT r.name region, s.name salesrep, a.name accounts
FROM sales_reps s
JOIN region r 
ON s.region_id = r.id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE s.name LIKE 'S%'
AND r.name = 'Midwest'
ORDER BY a.name

SELECT r.name region, s.name salesrep, a.name accounts
FROM sales_reps s
JOIN region r 
ON s.region_id = r.id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE s.name LIKE '% K%'
AND r.name = 'Midwest'
ORDER BY a.name


SELECT r.name region, a.name account, a.total_amt_usd/(a.total+0.01) u/p
FROM orders o
JOIN region r 
ON s.region_id = r.id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE o.standard_qty > 100

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unitp
FROM orders o
JOIN accounts a
ON	 o.account_id = a.id 
JOIN sales_reps s
ON   a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unitp
FROM orders o
JOIN accounts a
ON	 o.account_id = a.id 
JOIN sales_reps s
ON   a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100
AND poster_qty >50
ORDER BY unitp


ON	 o.account_id = a.id 
JOIN sales_reps s
ON   a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100
AND poster_qty >50
ORDER BY unitp DESC

SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

SELECT w.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN web_events w
ON w.account_id = a.id
WHERE w.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC;
