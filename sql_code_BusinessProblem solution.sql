-- 15 BUSINESS PROBLEM QUESTIONS AND SOLUTIONS
# 1. Count the number of Movies vs TV Shows

SELECT type, COUNT(type) AS number
FROM movies
GROUP BY type;

# 2. Find the most common rating for movies and TV shows

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
;


# 3. List all movies released in a specific year (e.g., 2020)

SELECT *
FROM movies
WHERE 
	type = 'Movie'
    AND release_year = 2020
;

# 4. Find the top 5 countries with the most content on Netflix

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


# 5. Identify the longest movie

SELECT title, duration
FROM movies
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1)AS UNSIGNED) DESC
LIMIT 1;

# 6. Find content added in the last 5 years

SELECT *
FROM movies
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY date_added ASC;


# 7. Find all the movies/TV shows by director 'Rajiv Chilaka'.

SELECT *
FROM movies
WHERE director REGEXP 'Rajiv Chilaka';

# 8. List all TV shows with more than 5 seasons

SELECT *
FROM movies
WHERE 
	type = 'TV Show'
    AND CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED)>5
ORDER BY CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED) ASC
;

# 9. Count the number of content items in each genre


WITH cte_genre AS (
	SELECT
		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in,',',n),',',-1)) AS genre,
        show_id
		FROM movies
		JOIN (
			SELECT 1 AS n UNION ALL
			SELECT 2 UNION ALL
			SELECT 3 UNION ALL
			SELECT 4 ) AS numbers
		ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in,',','')) >= n-1
		)
	SELECT 
		genre, count(show_id) content
	FROM cte_genre
    GROUP BY genre
    ORDER BY content DESC;
    

# 10.Find each year and the average numbers of content release in India on netflix. 
# return top 5 year with highest avg content release!

SELECT COUNT(show_id)
FROM movies
WHERE country REGEXP 'india';

SELECT 
	release_year,
    COUNT(show_id) AS total_content,
    ROUND(COUNT(show_id)*100/ (SELECT COUNT(show_id)
	FROM movies
	WHERE country REGEXP 'india')) AS avg_content
FROM movies
WHERE country REGEXP 'india'
GROUP BY release_year
ORDER BY avg_content DESC
LIMIT 5;

# 11. List all movies that are documentaries

SELECT *
FROM movies
WHERE 
	listed_in REGEXP 'documentaries'
    and type = 'Movie';

# 12. Find all content without a director

SELECT *
FROM movies
WHERE director IS NULL;

# 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT 
	*
FROM movies
WHERE 
	cast REGEXP 'salman khan'
    AND release_year >= YEAR(CURDATE()) - 10
ORDER BY release_year DESC;

# 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

WITH split_names AS (
    SELECT trim(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', n), ',', -1)) AS actor_name
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
    WHERE country REGEXP 'India'
    AND type = 'Movie'
)
SELECT actor_name, COUNT(*) AS frequency
FROM split_names
GROUP BY actor_name
ORDER BY frequency DESC
limit 10;

# 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in  the description field. 
-- Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.
   
SELECT 
		title, 
        description,
        CASE
            WHEN description LIKE '% kill%' THEN 'bad'
            WHEN description LIKE '%violence%' THEN 'bad'
            ELSE 'good'
        END AS category
        FROM movies;
   
WITH cte_category AS (
    SELECT 
        title, 
        CASE
			WHEN description LIKE '% kill%' THEN 'bad'
            WHEN description LIKE '%violence%' THEN 'bad'
            ELSE 'good'
        END AS category
    FROM movies
)
SELECT 
    category, 
    COUNT(category) AS count
FROM cte_category
GROUP BY category;



