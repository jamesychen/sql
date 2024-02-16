--175. Combine Two Tables----

--return first, last, city, state
--join two tables
--filter out Null value for Id\\
-- here we use a left join bc we don't want to return null value from address table


SELECT p.firstname, p.lastname, a.city, a.state
FROM Person p
Left JOIN address a ON p.personId = a.personid;



--182. Duplicate Emails--

SELECT Email
FROM Person
GROUP BY email
HAVING count(email) >1;



