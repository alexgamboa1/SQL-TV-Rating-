# Exploring Multiple Tables of TV Series information with SQL 

In this project, I am apart of a tv show streaming service who wants to know more about their current show selection and what their users think of each series. I was assigned multiple tables of tv show information and fictional reviewer ratings of the show. I am using SQL database to demonstrate a few different ways in which SQL can be used to query data and answer business questions. 


# What is a Relational Data Base? 

- Relational Databases: Databases that organize information into one or more tables.
- Table: A collection of data organized into rows and columns.
- Columns + Rows: Information is stored in type-specific groups.

- CREATE TABLE: This is a clause. Clauses perform specific tasks in SQL.
- table_name is the name of the table to which the clause / command is applied to.
- ( ): Is a parameter, which can be a list of columns, data types, or values.


The following is the list of tables and their corresponding column titles: 

- Reviewers (id, first_name, last_name) 
- Series (id, title, released_year, genre) 
- Reviews (id, rating, series_id, reviewer_id)

# Setting Up Database Tables 
In order to understand the given data it is helpful to create an Entity Relationship Diagram (ERD). ERD helps the user to understand the relationships between different data tables and makes it easier to understand where data is when querying. 

\
\
![](https://github.com/alexgamboa1/SQL-TV-Rating-/blob/master/Data%20Model%20.png) 
\


Below is an example of the SQL code based on the schema to insert the table `series` along with the names of its column into our database. Series is the table that holds the information on tv series description in the network. Note there are different datatypes representing integers (`int`), dates (`year`), and strings with variable lengths (`varchar`).
```
CREATE TABLE series (
	id INT AUTO_INCREMENT PRIMARY KEY, 
    title VARCHAR(100), 
    released_year YEAR(4), 
    genre VARCHAR(100)
);
```

# Data Querying 
In this project the main objective is to answer relative business questions to understand the reviewers feed back of the current tv series selection on the online streaming service. In order to perform some data exploration we must use different querying techniques to solve the business requirements we are looking to find. 

### New Streaming Service wants to analyze the tv series within their current selection of listed shows. Return the TV show name and the results of all the reviewers rating. 
```
SELECT title, rating 
FROM series 
JOIN reviews 
ON series.id = reviews.series_id;
```
SQL can handle data and queries across multiple tables. 
Join was used to combine the tables based on a primary key. 

### The Service wants to find out what the avg rating of the tv shows were and list them from lowest to highest. Include title and avg rating. 
```
SELECT title, AVG(rating) as avg_rating 
FROM series JOIN reviews ON series.id = reviews.series_id
-- need to use a groupby for the title 
GROUP BY series.id 
ORDER BY avg_rating;
```
In this query I used an aggregate function of AVG(rating) with an alias of avg_rating to descripe the new column. 
In order to aggregate appropriate data for AVG(rating) to work it must be grouped by a field that represents the tv series in this instance it is series.id. 
Used Order BY to go from lowest to highest. 

### The service wants me to return the first and last name of the reviewers and the rating that each reviewer has given for each series. 
Organize the query information by last name. 
```
SELECT first_name, last_name, rating
FROM reviewers JOIN reviews 
ON reviewers.id = reviews.reviewer_id
ORDER BY last_name;
```
Used join to bring the two tables together of the reviewers information and the reviews they gave for each show.
Return the query by order by of last name to add structure and guidance to the return of the query. 

### Find the Series that are unreviewed. 
```
SELECT title AS unreviewed_series
FROM series LEFT JOIN reviews 
ON series.id = reviews.series_id 
WHERE reviews.rating IS NULL;
```
For this question I used a left join to bring all the information that matches with the tv series information. If there was no reviews information that matches the series there would be a NULL value. `NULL` is a special value in SQL that represents missing or unknown data. Used a `WHERE` clause to tell the query if reviews under rating was null. Also gave an alias to the title for proper classification of the new table. 

### The streaming service company wants to find out what the average rating is per genre. The company has money to acquire new films and produce new films for next year production. 
```
SELECT genre, ROUND(AVG(rating), 2) AS avg_rating
FROM series
INNER JOIN reviews ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating;
```
Inner join on reviews and series to find the common relationship in the series, genre, and rating. Use the ROUND() to insert the column you would like to round add a comma and write the amount of decimals you want the interger to have. 
Aggregate data with genre with the group by cause to put together the types of tv show series. 
Use Order By aggregation to organize the data from lowest to highest. 


### The Streaming Service wants the analytics on the reviewers. Give the information of the reviewers by name as well as some quantitative details on on their reviews. Return the amount of reviews, minimum, maximum, average rating, and status of reviewing. 
```
SELECT first_name, last_name, 
		COUNT(rating) AS COUNT,    -- count the ratings by reviewers.id 
        IFNULL(MIN(rating),0) AS MIN,   -- use if null ( MIN rating, as 0 ) as min 
        IFNULL(MAX(rating),0) AS MAX, 
        ROUND(IFNULL(AVG(rating),0)) AS AVG,    
        CASE                                                                                         
			WHEN COUNT(rating) >= 1 THEN 'ACTIVE'
            ELSE 'NON ACTIVE'
        END AS STATUS
FROM reviewers LEFT JOIN reviews on reviewers.id = reviews.reviewer_id 
GROUP BY reviewers.id;
```
In this complex query its important to understand that some of the reviewers my not be reviewing at the time "Status" so the relationship between the databases is a left join.`Left join` allows to pull the information only if it matches. Once that is done you can start to pull in information to get quantiative analytics. 
Use `COUNT()` to select the count the rating by reviewers.id to see how many reviews they have done. 
We have applied IFNULL because of the left join and there may be no information so `IFNULL(argument(column), 0)` the zero is set to allow 0 if there is a `NULL` value. Add min and max functions of aggregation. 
Use `CASE` to create the condition of a status of the active and non active users. We must start with Case, then `WHEN` this happens `THEN` apply this `ELSE` apply this next function. Always end with `END` to close the `CASE`.

### Its important to review the integrity of the reviewers and the data. Return the each series in alphabetical order, the rating, and the reviewers name. Its important to view 

```
SELECT title, rating, CONCAT(first_name,' ',last_name) AS reviewer
FROM reviewers JOIN reviews ON reviewers.id = reviews.reviewer_id
INNER JOIN series ON series.id = reviews.series_id
ORDER BY title ASC; 
```
use Concat to join two type of information from different columns into a single column. 
Its important to select the proper `JOINS` by using the ERD diagram to pick the specific `PRIMARY KEY` to match the data you want to pull from each of the data source. 
