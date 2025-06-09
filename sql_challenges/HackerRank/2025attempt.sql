/*
1. 
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
select 
case 
when a+b<=c or a+c<= b OR b+c<= a then 'Not A Triangle'
when a=b and b=c and a=c then 'Equilateral'
when a=b or b=c or a=c then 'Isosceles'
when a!=b and b!=c and a!=c then 'Scalene'
end
from triangles

/*
2.
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
The output should consist of four columns (Doctor, Professor, Singer, and Actor) in that specific order, with their respective names listed alphabetically under each column.

Note: Print NULL when there are no more names corresponding to an occupatio
*/
  
with t as(
select 
name,
occupation,
row_number() over (partition by occupation order by name) AS rn
from occupations
)
select 
max(case when occupation = 'Doctor' then name end),
max(case when occupation = 'Professor' then name end),
max(case when occupation = 'Singer' then name end),
max(case when occupation = 'Actor' then name end)
from t
group by rn
order by rn
