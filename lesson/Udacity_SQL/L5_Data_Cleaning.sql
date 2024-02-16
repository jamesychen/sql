--DATACLEANING--
 
 LEFT&RIGHT

 
SELECT right(website, 3) AS domain, COUNT(*)num
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;


SELECT LEFT(UPPER(name), 1) first_let, COUNT(*)
FROM accounts
GROUP BY 1
ORDER BY 2 DESC


WITH t1 AS (SELECT CASE WHEN LEFT(name, 1) IN ('1','2','3','4','5','6','7','8','9','0') THEN 1 
		ELSE 0 END num,
        CASE WHEN LEFT(name, 1) IN ('1','2','3','4','5','6','7','8','9','0') THEN 0 
		ELSE 1 END let
		FROM accounts)
SELECT SUM(num) num, SUM(let) let
FROM t1


WITH t1 AS (SELECT CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 1 
		ELSE 0 END vow,
        CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')THEN 0 
		ELSE 1 END non
		FROM accounts)
            
SELECT SUM(vow) vow, SUM(non)non
FROM t1

--POSITION STRPOS

SELECT primary_poc,
LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) first_name, RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc)) last_name
FROM accounts
 
SELECT name,
LEFT(name, POSITION(' ' IN name)-1) first_name, RIGHT(name, LENGTH(name) -POSITION(' ' IN name)) last_name
FROM sales_reps
                   
--CONCAT!

WITH t1 AS(SELECT primary_poc, name,
LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) first_name, RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc))last_name
FROM accounts)

SELECT first_name, last_name, first_name || '.' || last_name|| '@' || name ||'.com'                                                 
FROM t1      



WITH t1 AS(SELECT primary_poc, name,
LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) first_name, RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc))last_name
FROM accounts)

SELECT first_name, last_name, first_name || '.' || last_name|| '@' || REPLACE(name, ' ', '') ||'.com'                                                 
FROM t1                                          



WITH t1 AS(SELECT primary_poc, name,
LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) first_name, RIGHT(primary_poc, LENGTH(primary_poc) -POSITION(' ' IN primary_poc))last_name
FROM accounts)

SELECT first_name, last_name, first_name || '.' || last_name|| '@' || REPLACE(name, ' ', '') ||'.com' AS email, LOWER(LEFT(first_name, 1))|| LOWER(RIGHT(first_name, 1)) || LOWER(LEFT(last_name, 1)) || LOWER(RIGHT(last_name, 1)) || length(first_name) || length(last_name) || UPPER(REPLACE(name, ' ', '')) AS password                                                     
FROM t1


--TO_DATE&CAST


SELECT (SUBSTR(date, 7, 4)|| '-' ||SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data


SELECT (SUBSTR(date, 7, 4)|| '-' ||SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data
LIMIT 10


--COALESCE
SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
	COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, 
	COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, 
	COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, 
	COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
	COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
