/* 
 * Welcome to Introduction to SQL!
 * This document includes practical examples of all basic SQL commands you will learn in this lecture.

 * If you have 2 screens:
 * Open the zoom call with the presentation on one screen and DBeaver with this file on your other screen.

 * If you have 1 screen:
 * Open and resize the zoom call with the presentation to fit on one half and DBeaver with this file open on the other.

 * How to use this file:
 * This file includes practical examples already pre-coded for you.
 * They will show you how they can be applied in reality and how the output changes based on each SQL command.
 * To execute an example simply click anywhere in the query and press the control and ⮐ button simoultaneously.
 * This shortcut will execute the SQL statement and return the output below as a table.

 * The lecture will cover a lot of SQL commands, but don't worry we have a lot of practical exercises prepared for you.
 * With the exercises you will build up your SQL skills in no time! 
 */ 

-- Your first SQL query
SELECT name
FROM airports;

/* SELECTing Data - SELECT
 * SELECT multiple columns of a table
 */
SELECT faa,
	   name,
	   city,
	   country
FROM airports;

-- SELECT all columns of a table
SELECT *
FROM airports;

/* SELECT DISTINCT
 * The first query selects all the different timezone differences available in the tz column.
 * We can see that certain time differences are present multiple times in the table.
 */ 
SELECT tz
FROM airports
ORDER BY tz;

/* The second query selects only the distinct timezone differences.
 * This time each time difference is only shown once.
 */ 
SELECT DISTINCT tz
FROM airports
ORDER BY tz;

/* LIMIT
 * Compared to 200 rows that DBeaver returns by default, LIMIT 15 only returns 15 rows.
 */
SELECT *
FROM airports
LIMIT 15;

-- Filtering Data - WHERE
-- Operator: =
SELECT name, 
	   city, 
	   country
FROM airports
WHERE country = 'Iceland';

-- Operator: >=
SELECT name, 
	   city, 
	   country,
	   alt
FROM airports
WHERE alt >= 12400
ORDER BY alt;

/* Operator: LIKE
 * The % sign inside 'X%' is called a wildcard operator and means "List all airports where faa starts with an X".
 * There exist more wildcard operators but you don't have to worry about them now.
 */
SELECT faa,
	   name, 
	   city, 
	   country,
	   alt
FROM airports
WHERE faa LIKE 'X%';

-- Operator: IN
SELECT name, 
	   city, 
	   country,
	   alt
FROM airports
WHERE city IN ('Hamburg', 'Berlin');

-- WHERE with AND, OR, NOT
-- AND
SELECT name, 
	   city, 
	   country,
	   alt
FROM airports
WHERE alt >= 12400
  AND country <> 'China'
ORDER BY alt;

-- AND + OR
SELECT name, 
	   city, 
	   country,
	   alt
FROM airports
WHERE alt >= 12400
  AND (country = 'China' OR country = 'Nepal')
ORDER BY alt;

-- NOT
SELECT name, 
	   city, 
	   country
FROM airports
WHERE country = 'Germany'
  AND city NOT IN ('Hamburg', 'Berlin')
ORDER BY city;

/* WHERE with NULL values
 * The first query will not return any records because you can't filter for NULL values using the = operator.
 */
SELECT name, 
	   city, 
	   country
FROM airports
WHERE country = 'Philippines'
  AND city = NULL;

/* This query will run successfully since we correctly used IS NULL.
 * !Always use IS NULL to filter for NULL values!
 */
SELECT name, 
	   city, 
	   country
FROM airports
WHERE country = 'Philippines'
  AND city IS NULL;
  
/* Sorting Data - ORDER BY
 * Columns in ORDER BY can also be referenced by their index, both examples return the same results
 */
SELECT name, 
	   city, 
	   country
FROM airports
ORDER BY country ASC, city DESC;

SELECT name, 
	   city, 
	   country
FROM airports
ORDER BY 3 ASC, 2 DESC;

/* Aliasing - AS
 * Aliases for columns
 */
SELECT name,
	   city,
	   country,
	   tz AS timezone,
	   alt AS altitude
FROM airports;

-- Aliases for columns and tables
SELECT a.name,
	   a.city,
	   a.country,
	   a.tz AS timezone,
	   a.alt AS altitude
FROM airports a;

/* Aggregating Data
 * MIN() and MAX()
 */
SELECT MAX(alt) AS maximum_altitude
FROM airports;

SELECT MIN(alt) AS minimum_altitude
FROM airports;
 
-- AVG(), COUNT(), SUM()
SELECT AVG(alt) AS average_altitude
FROM airports;

SELECT COUNT(name) AS total_airports
FROM airports;

SELECT SUM(alt) AS total_altitude
FROM airports
WHERE country = 'China';

-- Using DISTINCT with COUNT returns unique values only, compare the output of the two queries below
SELECT COUNT(country) AS total_countries
FROM airports;

SELECT COUNT(DISTINCT country) AS total_unique_countries
FROM airports;

/* Arithmetic Operators
 * Addition
 */
SELECT name, 
	   city, 
	   country,
	   alt,
	   alt + 1000 AS higher_altitude
FROM airports
WHERE alt >= 12400
  AND (country = 'China' OR country = 'Nepal')
ORDER BY alt;

/* Division
 * The ROUND() function rounds the value to the specified decimal
 */
SELECT name, 
	   city, 
	   country,
	   alt AS altitude_in_feet,
	   ROUND(alt/3.281) AS altitude_in_m,
	   ROUND((alt/3.281) / 1000.0, 1) AS altitude_in_km
FROM airports
WHERE alt >= 12400
  AND (country = 'China' OR country = 'Nepal');

--

-- Modulo
SELECT (11 % 2) AS modulo;

/* GROUP BY
 * COUNT of total airports by country and timezone.
 */
SELECT country,
	   tz AS timezone,
	   COUNT(*) AS total_airports
FROM airports
WHERE country = 'United States'
GROUP BY country,
		 tz
ORDER BY tz;

/* Refererencing columns by their index is also possible with GROUPY BY.
 * The query below returns the same output as the query above.
 */
SELECT country,
	   tz AS timezone,
	   COUNT(*) AS total_airports
FROM airports
WHERE country = 'United States'
GROUP BY 1, 2 -- 1 refers to country and 2 to tz
ORDER BY 2;

/* Average altitude of airports per country with AVG()
 * The ROUND() function rounds the value to the specified decimal
 */
SELECT country,
	   ROUND(AVG(alt),0) AS avg_airport_altitude
FROM airports
GROUP BY country
ORDER BY AVG(alt) DESC;

/* HAVING
 * Countries that have an average altitude of airports greater than or equal 5000
 * The first query will throw an error because the aggregate condition is inside the WHERE clause which is not allowed
 */ 
SELECT country,
	   ROUND(AVG(alt),0) AS avg_airport_altitude
FROM airports
WHERE AVG(alt) >= 5000
GROUP BY country
ORDER BY AVG(alt) DESC;

-- This query produces the desired output because we correctly use the aggregate condition in the HAVING clause
SELECT country,
	   ROUND(AVG(alt),0) AS avg_airport_altitude
FROM airports
GROUP BY country
HAVING AVG(alt) >= 5000
ORDER BY AVG(alt) DESC;

/* Documenting Code
 * SQL Comments
 */
-- Single-line comment

/* Multi-line
 * Comment
*/

-- Commenting out parts of your query
SELECT faa,
	   name,
	   --country
FROM airports
/*WHERE faa LIKE 'A%'
ORDER BY 1*/;
