-- after exploring the dataset I found great insights that support my objective



-- find the h1b approve rate by each year and output the year and approve rate 

select  date_part('year', start_date):: varchar as year,
        ROUND(100.00 * 
        sum(case when case_status = 'CERTIFIED'  then 1 else 0 end)
       /count(*), 2) as approved_rate
from h1b_salary.salaries       
group by 1
order by 1 DESC     



-- top 7 approved count by job title in 2020

select job_title, count(*) as approved_counts
from h1b_salary.salaries
where case_status = 'CERTIFIED' and date_part('Year', start_date) = '2020'
group by 1
order by 2 DESC
limit 7

findings: DS > BA > DA > sr.BA > BIA > sr.DS > sr.DA > PA 


-- approved count by city (cleaned up city)

select left(location, length(location) - 3) as city, 
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
