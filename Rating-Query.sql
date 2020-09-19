SELECT title, rating 
FROM series 
JOIN reviews 
ON series.id = reviews.series_id;

-- Find the average rating of the tvv shows and list them from lowest to highest

SELECT title, AVG(rating) as avg_rating 
FROM series JOIN reviews ON series.id = reviews.series_id
-- need to use a groupby for the title 
GROUP BY series.id 
ORDER BY avg_rating; -- asc will show lowest at the top 






