-- 2. Select the albums db for use and display chosen db.

USE albums_db;
SELECT database();

-- 3. Explore the structure of the albums table.

-- I can show the tables housed in the db.
SHOW tables;

-- I can inspect a single table within the db.
DESCRIBE albums;

-- I can take a quick peak at the first 5 rows of the table.
SELECT *
FROM albums
LIMIT 5;

-- I can inspect the unique values of a single column if I like.
SELECT DISTINCT genre
FROM albums;

-- 4. Write queries to find the following information:

-- a. the name of all albums by Pink Floyd.

SELECT name AS 'Albums by Pink Floyd'
FROM albums WHERE artist = 'Pink Floyd';

-- b. the year Sgt. Pepper's Lonely Hearts Club Band was released.

SELECT release_date AS 'Release Date for Sgt. Pepper\'s Lonely Hearts Club Band'
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- c. the genre for the album Nevermind.

SELECT genre AS 'Genre for Nevermind'
FROM albums
WHERE name = 'Nevermind';

-- d. albums were released in the 1990s.

SELECT artist, 
       name AS 'Albums Released in the 1990s'
FROM albums
WHERE release_date LIKE '199%';

-- We can also use WHERE BETWEEN AND.

SELECT artist, 
       name AS 'Albums Released in the 1990s'
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- We can find albums released in the 90s also using greater than or equal to and less than or equal to

SELECT artist, 
       name AS 'Albums Released in the 1990s'
FROM albums
WHERE release_date >= 1990 AND release_date <= 1999;

-- e. albums had less than 20 million certified sales.

SELECT name AS 'Albums Selling Less than 20 million'
FROM albums
WHERE sales < 20;

-- f. All the albums with a genre of 'Rock'. Why do these query results not include albums with a genre of 'Hard rock' or 'Progressive rock'? (single = w/ a where clause in SQL is the same as == in Python)

SELECT * 
FROM albums
WHERE genre = 'Rock';

-- What if we want a query that gives any kind of rock?
-- Contents of a string are NOT case-sensitive

SELECT *
FROM albums
WHERE genre LIKE '%rock%';