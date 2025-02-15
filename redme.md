---sql
SELECT type, COUNT(type) AS number
FROM movies
GROUP BY type;
---
