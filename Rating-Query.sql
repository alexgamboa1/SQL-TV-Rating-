SELECT title, rating 
FROM series 
JOIN reviews 
ON series.id = reviews.series_id;

-- Find the average rating of the tvv shows and list them from lowest to highest

SELECT title, AVG(rating) as avg_rating 
FROM series JOIN reviews 
ON series.id = reviews.series_id
-- need to use a groupby for the title 
GROUP BY series.id 
ORDER BY avg_rating; -- asc will show lowest at the top 

-- Return first and last name of the reviewers with rating, organized by last name 
SELECT first_name, last_name, rating
FROM reviewers JOIN reviews 
ON reviewers.id = reviews.reviewer_id;

-- Find the series that have not been reviewed 
SELECT title AS unreviewed_series
FROM series LEFT JOIN reviews 
ON series.id = reviews.series_id 
WHERE reviews.rating IS NULL;  -- use where to find the NULL values 

-- Return the avg_rating per genre 
SELECT genre, ROUND(AVG(rating), 2) AS avg_rating
FROM series
INNER JOIN reviews ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating;

-- Return first and last of reviewer as well as analytics on their ratings: 
# of reviews, min / max rating, avg rating, and status 

SELECT first_name, last_name, 
		COUNT(rating) AS COUNT, 
        IFNULL(MIN(rating),0) AS MIN, 
        IFNULL(MAX(rating),0) AS MAX, 
        ROUND(IFNULL(AVG(rating),0)) AS AVG,
        CASE 
			WHEN COUNT(rating) >= 1 THEN 'ACTIVE'
            ELSE 'NON ACTIVE'
        END AS STATUS
FROM reviewers LEFT JOIN reviews on reviewers.id = reviews.reviewer_id 
GROUP BY reviewers.id;









