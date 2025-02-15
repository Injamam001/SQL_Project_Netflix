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

### Columns of the table are 
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

### 1. Count the number of Movies vs TV Shows
```sql
SELECT type, COUNT(type) AS number
FROM movies
GROUP BY type;
