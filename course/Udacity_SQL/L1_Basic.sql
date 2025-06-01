--OREDERBY
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occured_at
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;


--WHERE!!
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

--AS
SELECT id, account_id, ROUND((standard_amt_usd/standard_qty),2) AS unit_price
FROM orders
LIMIT 10;

SELECT id, account_id, poster_amt_usd/
(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS perc_rev
FROM orders
LIMIT 10;

--LIKE
SELECT name
FROM accounts
WHERE name LIKE 'C%';

SELECT name
FROM accounts
WHERE name LIKE '%one%';

SELECT name
FROM accounts
WHERE name LIKE '%s';

--IN!!
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

--NOT
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstorm');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT *
FROM accounts
WHERE name NOT LIKE ('C%');

SELECT *
FROM accounts
WHERE name NOT LIKE ('%one%');

SELECT *
FROM accounts
WHERE name NOT LIKE ('%s');

--AND,BETWEEN
SELECT *
FROM orders 
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT * 
FROM accounts  
WHERE name NOT LIKE 'C%' AND name LIKE '%s'

SELECT occurred_at, gloss_qty
FROM orders 
WHERE gloss_qty BETWEEN 24 AND 29;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC

--OR

SELECT gloss_qty, poster_qty, id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND gloss_qty > 1000 OR poster_qty >1000

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
AND primary_poc NOT LIKE '%eana%'
