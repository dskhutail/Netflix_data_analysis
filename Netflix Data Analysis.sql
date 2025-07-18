use project;

-- View the Total Number of Titles

SELECT COUNT(*) AS total_titles
FROM titles;

 -- Find the Top 10 Movies by IMDb Rating

SELECT title, imdb_score
FROM titles
WHERE type = 'Movie'
ORDER BY imdb_score DESC
LIMIT 10;

-- Get All Titles Released in a Specific Year

SELECT title, release_year
FROM titles
WHERE release_year = 2020;

-- Find the Number of Titles in Each Genre

SELECT genre, COUNT(*) AS count_per_genre
FROM titles
GROUP BY genre
ORDER BY count_per_genre DESC;

-- Average IMDb Score by Genre

SELECT genre, AVG(imdb_score) AS avg_imdb_score
FROM titles
GROUP BY genre
HAVING AVG(imdb_score) IS NOT NULL
ORDER BY avg_imdb_score DESC;

-- Get the Longest Movie (by Duration)

SELECT title, duration
FROM titles
WHERE type = 'Movie'
ORDER BY duration DESC
LIMIT 1;

-- Count of Titles by Type (Movies vs TV Shows)

SELECT type, COUNT(*) AS total
FROM titles
GROUP BY type;

 -- Find Titles with the Highest Number of Cast Members

 SELECT t.title, COUNT(c.name) AS cast_count
FROM titles t
JOIN credits c ON t.id = c.title_id
WHERE c.role = 'Actor'
GROUP BY t.title
ORDER BY cast_count DESC
LIMIT 10;

 -- Find All Titles with a Specific Actor

 SELECT t.title, c.name AS actor
FROM titles t
JOIN credits c ON t.id = c.title_id
WHERE c.role = 'Actor' AND c.name = 'Robert Downey Jr.';

-- List of Directors and the Number of Titles They Directed

SELECT c.name AS director, COUNT(t.id) AS directed_titles
FROM titles t
JOIN credits c ON t.id = c.title_id
WHERE c.role = 'Director'
GROUP BY c.name
ORDER BY directed_titles DESC;

-- List of Actors in a Specific Movie

SELECT c.name AS actor
FROM credits c
JOIN titles t ON c.title_id = t.id
WHERE t.title = 'Inception' AND c.role = 'Actor';

-- Average IMDb Score for Each Release Year

SELECT release_year, AVG(imdb_score) AS avg_imdb_score
FROM titles
GROUP BY release_year
HAVING AVG(imdb_score) IS NOT NULL
ORDER BY avg_imdb_score DESC;

 -- Get the Total Number of Movies Released by Year

 SELECT release_year, COUNT(*) AS total_movies
FROM titles
WHERE type = 'Movie'
GROUP BY release_year
ORDER BY release_year DESC;

 -- Find Titles with More than 5 Cast Members

 WITH cast_counts AS (
    SELECT c.id, COUNT(*) AS cast_count
    FROM credits c
    WHERE role = 'Actor'
    GROUP BY c.id
)
SELECT t.title, cc.cast_count
FROM titles t
JOIN cast_counts cc ON t.id = cc.id
WHERE cc.cast_count > 1;


-- List Movies Directed by a Specific Director

SELECT t.title, c.name AS director
FROM titles t
JOIN credits c ON t.id = c.title_id
WHERE c.role = 'Director' AND c.name = 'Christopher Nolan';

