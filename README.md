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


