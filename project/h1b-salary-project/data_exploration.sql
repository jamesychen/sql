-- Project Goal: 
--    The goal of this project is to give me direction to applying for jobs in data analyst, business analyst, business intelligence analyst, and analytics enginner


-- overview

select * from h1b_salary.salaries



-- h1b approve rate in a single year

  select ROUND(100.00 * 
        (select count(*) 
         from h1b_salary.salaries
         where case_status = 'CERTIFIED' and extract(year from start_date) = '2020')
         / count(*), 2) as approved_rate
from h1b_salary.salaries
where extract(year from start_date) = '2020'


-- (improved) h1b approve rate in a single year

select 
        ROUND(100.00 * 
        sum(case when case_status = 'CERTIFIED' and date_part('year', start_date) = '2020' then 1 else 0 end)
       /sum(case when date_part('year', start_date) = '2020' then 1 else 0 end)
        ,2) as approved_rate
from h1b_salary.salaries             


-- find the h1b approve rate by each year and output the year and approve rate (can't solve it)

select  date_part('year', start_date):: varchar as year,
        ROUND(100.00 * 
        sum(case when case_status = 'CERTIFIED'  then 1 else 0 end)
       /count(*), 2) as approved_rate
from h1b_salary.salaries       
group by 1
order by 1 DESC     


-- approved count by year

select date_part('year', start_date):: varchar as year, count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED'
group by 1
order by 1 DESC

-- approved count by employer in 2020

select employer, count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
order by 2 DESC


-- top 7 approved count by job title in 2020

select job_title, count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
order by 2 DESC
limit 7

findings: DS > BA > DA > sr.BA > BIA > sr.DS > sr.DA > PA 


-- approved count by city

select location, count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
order by 2 DESC

-- cleaned up city

select left(location, length(location) - 2) as city, 
       count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
order by 2 DESC


-- approved count by state (extract state)

select right(location, 2) as state , count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
order by 2 DESC

(findings: CA > NY > TX > NJ > VA )


-- Look at job titles in CA 

select right(location, 2) as state , job_title, count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020' and right(location, 2) = 'CA'
group by 1, 2
order by 3 DESC

(findings: the DA sponsor numbers and close to BA sponsors in CA and VA unlike NY, TX, NJ where BA is much greater than DA)


-- Find numbers of each position in each state, filter out total numbers < 200 

select right(location, 2) as state , 
       sum(case when job_title ilike 'data scientist' then 1 else 0 end) DS_count,
       sum(case when job_title ilike 'data analyst' then 1 else 0 end) DA_count,
       sum(case when job_title ilike 'business analyst' then 1 else 0 end) BA_count,
       sum(case when job_title ilike 'business intelligence analyst' then 1 else 0 end) BIA_count,
       sum(case when job_title ilike 'analytics engineer' then 1 else 0 end) AE_count,
       count (*) total_count
       
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
having count(*) > 200
order by 2 DESC, 3 DESC, 4 DESC, 5 DESC, 6 DESC, 7 DESC


-- find out the employeers who sponsor for H1b and get approved in 2021

select employer, 
       count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2021' and job_title ilike 'business analyst'
group by 1
order by 2 DESC
