SELECT *
FROM airbnb_data.ny_listings
lIMIT 10;

--count listing by 3 room_type

SELECT neighbourhood_group, COUNT(CASE WHEN room_type = 'Entire home/apt' THEN 1 ELSE NULL END) entire_homes_listings
                          , COUNT(CASE WHEN room_type = 'Private room' THEN 1 ELSE NULL END) private_listings
                          ,COUNT(CASE WHEN room_type = 'Shared room' THEN 1 ELSE NULL END) share_listings
        , COUNT(*) as listings
FROM airbnb_data.ny_listings
GROUP BY 1
ORDER BY listings desc

SELECT neighbourhood_group, COUNT(CASE WHEN room_type = 'Entire home/apt' THEN 1 ELSE NULL END) entire_homes_listings
                          , COUNT(CASE WHEN room_type = 'Private room' THEN 1 ELSE NULL END) private_listings
                          ,COUNT(CASE WHEN room_type = 'Shared room' THEN 1 ELSE NULL END) share_listings
        , COUNT(*) as listings
FROM airbnb_data.ny_listings
WHERE number_of_reviews > 0
GROUP BY 1

--find any host under sonder

SELECT neighbourhood_group
        , room_type
        , ROUND(AVG(price), 2) as avg_price
        , COUNT(1)
FROM    airbnb_data.ny_listings
WHERE host_name LIKE '%Sonder%'
GROUP BY 1,2
ORDER BY 3 DESC

-- find avg price with name sonder
SELECT host_id
        , CASE WHEN host_name LIKE '%Sonder%' THEN 'Sonder' ELSE host_name END as host_name
        , COUNT(*) listings
FROM    airbnb_data.ny_listings
WHERE host_name LIKE '%Sonder%'
GROUP BY 1, 2
ORDER BY 3 DESC

-- count review per listing for sonder
SELECT host_id
        , host_name
        , SUM(number_of_reviews) as reviews
        , COUNT(*) as listings
        , ROUND(SUM(number_of_reviews)/ COUNT(*), 2) as review_per_listing
FROM airbnb_data.ny_listings
GROUP BY 1,2
ORDER BY 3 DESC
