/* Write your T-SQL query statement below */
--find out second highest salary
--rank them 


WITH t1 AS 
    (SELECT salary, dense_rank () over (ORDER BY salary DESC) rank
    FROM employee
    )
    
    
    SELECT MAX(salary) SecondHighestSalary
    FROM t1
    WHERE rank = 2;
    
solution :

SELECT DISTINCT
    Salary AS SecondHighestSalary
FROM
    Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1
