-- Q1) Pull a list of customer ids with the customer’s full name, and address,
-- along with combining their city and country together. Be sure to make a
-- space in between these two and make it UPPER CASE.

SELECT firstname, lastname, address, city, country, UPPER(city || ' ' || country) cityofcoun
FROM customers
WHERE customerId = 16;

------------------------------------------------------------------------------------
-- Q2) Create a new employee user id by combining the first 4 letter of the
-- employee’s first name with the first 2 letters of the employee’s last name. 
-- Make the new field lower case and pull each individual step to show your work.

SELECT firstname, lastname, SUBSTR(firstname, 1, 4) || SUBSTR(lastname, 1, 2) newuserid
FROM employees

------------------------------------------------------------------------------------
-- Q3) Show a list of employees who have worked for the company for 15 or more 
-- years using the current date function. Sort by lastname ascending.

SELECT lastname, firstname, employeeId, HireDate, STRFTIME('%Y', 'now') - STRFTIME('%Y', hiredate) yearworked
FROM employees
GROUP BY 1
ORDER BY 1 

------------------------------------------------------------------------------------
-- Q4) Profiling the Customers table, answer the following question.

SELECT *
FROM customers
WHERE phone is NULL

-- columns: FirstName, PostalCode, Company, Fax, Phone, Address


------------------------------------------------------------------------------------
-- Q5) Find the cities with the most customers and rank in descending order.

SELECT customerID, city, COUNT(customerID)
FROM customers
GROUP BY 2
ORDER BY 3 DESC

------------------------------------------------------------------------------------
-- Q6) Create a new customer invoice id by combining a customer’s invoice id with
-- their first and last name while ordering your query in the following order:
-- firstname, lastname, and invoiceID.

SELECT i.invoiceid, c.firstname, c.lastname, c.firstname || c.lastname || i.invoiceid new
FROM invoices i
JOIN customers c ON c.customerid = i.customerid
WHERE new LIKE 'AstridGruber%'
WHERE NewId LIKE 'AstridGruber%'
