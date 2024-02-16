--LESSON4--

--Subquery

SELECT channel, AVG(avg_events) avg
FROM (SELECT DATE_TRUNC('day', w.occurred_at) AS day, 
		      channel, COUNT(*)avg_events
        FROM web_events w
        GROUP BY 1,2
        ORDER BY 3) sub
 GROUP BY 1
 ORDER BY 2 DESC
 
 
SELECT AVG(standard_qty) mean_std, AVG(gloss_qty) mean_gloss , AVG(poster_qty) mean_post, SUM(total_amt_usd) 
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
        (SELECT MIN(DATE_TRUNC('month', occurred_at)) min_mon
         FROM orders)


SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;



SELECT t3.sales_rep, t3.reg, t3.sum_
FROM (SELECT reg, MAX(sum_) sum_
      FROM(SELECT s.name sales_rep, r.name reg, SUM(o.total_amt_usd) sum_
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        JOIN sales_reps s
        ON a.sales_rep_id = s.id
        JOIN region r
        On s.region_id = r.id
        GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name sales_rep, r.name reg, SUM(o.total_amt_usd) sum_
     FROM orders o
     JOIN accounts a
     ON o.account_id = a.id
     JOIN sales_reps s
     ON a.sales_rep_id = s.id
     JOIN region r
     On s.region_id = r.id
     GROUP BY 1, 2
     ORDER BY 3 DESC) t3
ON t3.reg = t2.reg AND t3.sum_ = t2.sum_;


WITH t1 AS(
SELECT s.name s_name, r.name r_name, SUM(o.total_amt_usd) sum_total
           FROM orders o
           JOIN accounts a
           ON o.account_id = a.id
           JOIN sales_reps s
           ON a.sales_rep_id = s.id
           JOIN region r 
           ON s.region_id = r.id
           GROUP BY 1, 2),
     t2 AS(
           SELECT r_name, MAX(sum_total) sum_total
           FROM  t1
           GROUP BY 1)
          
SELECT t1.s_name, t2.r_name, t1.sum_total
FROM t1
JOIN t2
ON t1.r_name = t2.r_name AND t1.sum_total = t2.sum_total



WITH t1 AS 
(SELECT  r.name r_name, SUM(o.total_amt_usd) sum_total
           FROM orders o
           JOIN accounts a
           ON o.account_id = a.id
           JOIN sales_reps s
           ON a.sales_rep_id = s.id
           JOIN region r 
           ON s.region_id = r.id
           GROUP BY 1
           ),       
t2 AS
       (SELECT MAX(sum_total)
        FROM t1)   
 SELECT r.name, COUNT(*) orders_amt
           FROM orders o
           JOIN accounts a
           ON o.account_id = a.id
           JOIN sales_reps s
           ON a.sales_rep_id = s.id
           JOIN region r 
           ON s.region_id = r.id
           GROUP BY 1
           HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);
           
           
WITH t1 AS
        (SELECT a.name, SUM(o.total) sum_total, SUM(o.standard_qty) sum_std_qty
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY 1
        ORDER BY 3 DESC
        LIMIT 1
        )
      t2 AS
        (SELECT a.name
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY 1
        HAVING o.total > t1.sum_total
        
 SELECT COUNT(*) 
 FROM t1
 
 
 WITH t1 AS
        (SELECT a.name, SUM(o.total) sum_total, SUM(o.standard_qty) sum_std_qty
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY 1
        ORDER BY 3 DESC
        LIMIT 1
        ),
      t2 AS
        (SELECT a.name
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY 1
        HAVING SUM(o.total) > (SELECT sum_total FROM t1))    
 	SELECT COUNT(*) 
 	FROM t2                               
 	
WITH t1 AS
        (SELECT a.name, a.id, SUM(o.total_amt_usd) total_amt
        FROM accounts a
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY 1,2
        ORDER BY 3 DESC
        LIMIT 1)

SELECT a.name w.channel, COUNT(*)
          FROM accounts a
          JOIN web_events w
          ON w.account_id = a.id AND a.id = (SELECT id FROM t1)
          GROUP BY 1,2
          ORDER BY 3 DESC
          

WITH t1 AS (SELECT a.name, SUM(o.total_amt_usd) tot_spent
            FROM accounts a
            JOIN orders o
            ON o.account_id = a.id
            GROUP BY 1,3
            ORDER BY 2 DESC
            LIMIT 10)
 SELECT AVG(tot_spent)
 FROM t1


 WITH t1 AS (SELECT o.account_id, SUM(o.total_amt_usd) tot_spent
            FROM orders o)
            
SELECT a.name, AVG(tot_spent) avg_spent
            FROM t2
            JOIN accounts a
            ON (SELECT id FROM t1 )= a.id
            HAVING o.total_amt_usd > AVG(tot_spent)
            GROUP BY 1
            ORDER BY 2 DESC

 WITH t1 AS (SELECT AVG(o.total_amt_usd) avg_all
            FROM orders o
            ),
            
      t2 AS (SELECT o.account_id, AVG(o.total_amt_usd) avg_spent
            FROM orders o
            GROUP BY 1
            HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))                                        
            
 SELECT AVG(avg_spent)
 FROM t2
