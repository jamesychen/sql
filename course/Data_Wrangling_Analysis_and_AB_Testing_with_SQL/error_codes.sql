-- Exercise 1:
-- Goal: Here we use users table to pull a list of user email addresses. Edit the query to pull email
-- addresses, but only for non-deleted users.

SELECT *
FROM dsv1069.users, email_address
where deleted_at ISNULL

--Goal: Use the items table to count the number of items for sale in each category
-- Exercise 2:

select category, count(id) as item count
from dsv1069.items
group by 1 

--Exercise 3:
--Goal: Select all of the columns from the result when you JOIN the users table to the orders

select u.*, o.* from dsv1069.users u
join dsv1069.orders o on u.id = o.user_id



-- Exercise 4:
-- Goal: Check out the query below. This is not the right way to count the number of viewed_item
-- events. Determine what is wrong and correct the error.

SELECT
event_id, count(*)
FROM dsv1069.events
where event_name = 'view_item'
group by 1


-- Exercise 5:
-- Goal:Compute the number of items in the items table which have been ordered. The query
-- below runs, but it isn’t right. Determine what is wrong and correct the error or start from scratch.


select count(distinct item_id)
from dsv1069.orders o 


--Exercise 6:
--Goal: For each user figure out IF a user has ordered something, and when their first purchase
--was. The query below doesn’t return info for any of the users who haven’t ordered anything.


--output first purchase, user_id
--join two tables
--we use a left join because we want to include other users who didn't pay

select u.id, min(paid_at)
from dsv1069.users u 
left join dsv1069.orders o on o.user_id = u.id
group by 1



-- Exercise 7:
-- --Goal: Figure out what percent of users have ever viewed the user profile page, but this query
-- isn’t right. Check to make sure the number of users adds up, and if not, fix the query.


-- calculate view percentage for the profile page


with first_view as (
        SELECT users.id AS user_id,
		    MIN(event_time) AS first_view
	
	      FROM dsv1069.users
	
	      LEFT JOIN dsv1069.events
		    ON events.user_id = users.id
		    AND event_name = 'view_user_profile'
	      GROUP BY users.id
	     )
        
        SELECT 
        CASE WHEN first_view IS NULL THEN false ELSE true	END as profile,
        count(user_id) as user
        from first_view
        group by 1
        
