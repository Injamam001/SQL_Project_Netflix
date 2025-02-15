<p align="center">
  <img src="https://github.com/Injamam001/sql_project_netflix/blob/main/logo.png" alt="Netflix Logo" width="300">
</p>

<h1 align="center">Netflix Content Analytics: SQL Data Exploration</h1>

# Overview
This project leverages SQL to analyze Netflix's movie and TV show data to solve business challenges. By exploring data points such as genres, ratings, and release years, the analysis uncovers valuable insights that can inform content strategy, optimize decision-making, and help address key business objectives.

# Objectives
- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

# Dataset
You can access and download the dataset used for this project [HERE](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

# Data quality improvement steps
- Removed blank rows
- Removed unwanted characters/spaces
- Standardized date formats
- Handled missing values
# Schema
To create the schema and tables in your SQL IDE, click this [LINK](https://github.com/Injamam001/sql_project_netflix/blob/main/sql_code_for_importing_netflix_data.sql) and download sql code file. This code was written in MySQL Workbench

#### Table columns
```sql
CREATE TABLE movies (
    show_id	VARCHAR(512),
    type	VARCHAR(512),
    title	VARCHAR(512),
    director	VARCHAR(512),
    cast	VARCHAR(1000),
    country	VARCHAR(512),
    date_added	date,
    release_year	INT,
    rating	VARCHAR(512),
    duration	VARCHAR(512),
    listed_in	VARCHAR(512),
    description	VARCHAR(2500)
);
```
# Business problems and solutions
#### 1. Count the number of Movies vs TV Shows
```sql
SELECT type, COUNT(type) AS number
FROM movies
GROUP BY type;
```
#### 2. Find the most common rating for movies and TV shows
```sql
WITH rating_table AS (
SELECT 
	type, 
	rating, 
    COUNT(rating) AS rating_count,
    RANK() OVER(PARTITION BY type ORDER BY COUNT(rating) DESC) AS ranking
FROM movies
WHERE rating IS NOT NULL
GROUP BY type, rating)

SELECT type, rating, rating_count
FROM rating_table
WHERE ranking = 1
```
#### 3. List all movies released in a specific year (e.g., 2020)
```sql
SELECT *
FROM movies
WHERE 
	type = 'Movie'
    AND release_year = 2020
;
```
#### 4. Find the top 5 countries with the most content on Netflix
```sql
WITH cte AS (
SELECT 
	    distinct(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country, ',', n),',',-1))) AS country,
        show_id
FROM movies
JOIN (
        SELECT 1 AS n UNION ALL
        SELECT 2 UNION ALL
        SELECT 3 UNION ALL
        SELECT 4 UNION ALL
        SELECT 5 UNION ALL
        SELECT 6 UNION ALL
        SELECT 7 UNION ALL
        SELECT 8 UNION ALL
        SELECT 9 UNION ALL
        SELECT 10 UNION ALL
        SELECT 11 UNION ALL
        SELECT 12 UNION ALL
        SELECT 13 UNION ALL
        SELECT 14 UNION ALL
        SELECT 15 UNION ALL
        SELECT 16 UNION ALL
        SELECT 17 UNION ALL
        SELECT 18) AS numbers
        
    ON CHAR_LENGTH(cast) - CHAR_LENGTH(REPLACE(cast, ',', '')) >= n - 1
   )
SELECT 
	country,
    COUNT(show_id) AS content
FROM cte
GROUP BY country
ORDER BY content DESC
LIMIT 5;
```

#### 5. Identify the longest movie
```sql
SELECT title, duration
FROM movies
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1)AS UNSIGNED) DESC
LIMIT 1;
```

#### 6. Find content added in the last 5 years
```sql
SELECT *
FROM movies
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY date_added ASC;
```

#### 7. 
```sql

```

#### 8. 
```sql

```

#### 9. 
```sql

```

#### 10. 
```sql

```

#### 11. 
```sql

```

#### 12. 
```sql

```

#### 13. 
```sql

```

#### 14. 
```sql

```

#### 15. 
```sql

```

