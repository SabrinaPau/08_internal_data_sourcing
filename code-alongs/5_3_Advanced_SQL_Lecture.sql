/* 
 * Welcome to Advanced SQL!
 * This document includes practical examples of all advanced SQL commands you will learn in this lecture.

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

/* Joining Data
 * INNER JOIN
 * Easy example: Destination airports in the dest column in the flights table starting with the letter E
 * and matching values in the faa column airports table that start with the letter E are returned.
 */
SELECT DISTINCT f.dest,
	   a.faa
FROM flights f
INNER JOIN airports a
	   ON f.dest = a.faa
WHERE f.dest LIKE 'E%' OR a.faa LIKE 'E%';

/* Hard example:
 * Destination airports in the dest column from 2021-01-01 with the destination of XWA, EAR or JFK and 
 * matching airports and their location information in the airport table are returned.
 * Even though we selected 3 (XWA, EAR, JFK) destinations only JFK was returned.
 * -> This means the airports XWA and EAR are not available in the airports table
 */
SELECT DISTINCT f.flight_date,
	   f.dest,
	   a.faa,
	   a.country,
	   a.city,
	   COUNT(*) AS number_of_flights
FROM flights f
INNER JOIN airports a
	   ON f.dest=a.faa
WHERE f.dest IN ('XWA', 'EAR', 'JFK')
  AND f.flight_date = DATE('2021-01-01')
GROUP BY f.flight_date,
		 f.dest,
		 a.faa,
		 a.country,
		 a.city;

/* LEFT JOIN
 * Easy example: All destination airports from the flights table (=left table) and
 * matching records from the airports table (=right table) are returned.
 * The destination airport 'EAR' was not found in the faa column in the airports table and is NULL.
 */
SELECT DISTINCT f.dest,
	   a.faa
FROM flights f
LEFT JOIN airports a
	   ON f.dest = a.faa
WHERE dest LIKE 'E%' OR a.faa LIKE 'E%';

/* Hard example: Same query as INNER JOIN but with LEFT JOIN. 
 * All records from the left flights table (=left table) and matching records
 * from the airports table are returned.
 * This time EAR and XWA are returned and we can see that there were 2 flights with destination EAR
 * and 2 flights with destination XWA. Since no matches for these airports were found in the airports table
 * the column values are set to NULL.
 */
SELECT DISTINCT f.flight_date,
	   f.dest,
	   a.faa,
	   a.country,
	   a.city,
	   COUNT(*) AS number_of_flights
FROM flights f
LEFT JOIN airports a
	   ON f.dest=a.faa
WHERE f.dest IN ('XWA', 'EAR', 'JFK')
  AND f.flight_date = DATE('2021-01-01')
GROUP BY f.flight_date,
		 f.dest,
		 a.faa,
		 a.country,
		 a.city;

/* RIGHT JOIN
 * The right join is simply the opposite of the LEFT JOIN
 * By simply changing the order of the table you will get the same result of the LEFT JOIN.
 * Easy example:
 */
SELECT DISTINCT f.dest,
	   a.faa
FROM airports a
RIGHT JOIN flights f
	   ON f.dest = a.faa
WHERE dest LIKE 'E%' OR a.faa LIKE 'E%';

-- Hard example:
SELECT DISTINCT f.flight_date,
	   f.dest,
	   a.faa,
	   a.country,
	   a.city,
	   COUNT(*) AS number_of_flights
FROM airports a
RIGHT JOIN flights f
	   ON f.dest=a.faa
WHERE f.dest IN ('XWA', 'EAR', 'JFK')
  AND f.flight_date = DATE('2021-01-01')
GROUP BY f.flight_date,
		 f.dest,
		 a.faa,
		 a.country,
		 a.city;
		
/* FULL JOIN
 * All destination airports from the flights table and 
 * all airports listed in the airports table are returned.
 * Compared to the other joins, we have all data from both tables
 * 1. destination airports in the flights table with matches in the airports table
 * 2. destination airports in the flights table with no matches in the airports table
 * 3. airports in the airports table with no matches in the flights table
 */
SELECT DISTINCT f.dest,
	   a.faa
FROM flights f
FULL JOIN airports a
	   ON f.dest = a.faa
WHERE dest LIKE 'E%' OR a.faa LIKE 'E%';

/* CROSS JOIN
 * Don't worry if you don't understand the code. All you need to know is that two tables
 * are created each with one column called number. Each column has 5 rows with the numbers from 1 to 5.
 * The CROSS JOIN then combines both tables by cross combining all rows with each other.
 */
SELECT *
FROM(
(SELECT * FROM (VALUES (1), (2), (3), (4), (5)) AS numbers(number)) AS table1
CROSS JOIN 
(SELECT * FROM (VALUES (1), (2), (3), (4), (5)) AS numbers(number)) AS table2
);

/* Self Join
 * We join the airports table to itself to match airports that are located in the same city 
*/
SELECT a1.name AS airport1,
	   a2.name AS airport2,
	   a1.city
FROM airports a1, airports a2
WHERE a1.city=a2.city
  AND a1.faa<>a2.faa --Filter out self matches
ORDER BY a1.name;

/* UNION [ALL]
 * In this example we select all airports in Hamburg and append all airports from Berlin.
 * We technically don't need UNION in this example and in reality we would always use 
 * one query with WHERE city IN ('Hamburg', 'Berlin')
 */
SELECT faa,
	   name,
	   city
FROM airports
WHERE city='Hamburg'
UNION
SELECT faa,
	   name,
	   city
FROM airports
WHERE city='Berlin';

/* INTERSECT [ALL]
 * In this example we return all distinct rows that are in the result-set
 * of both SELECT statements. Only the airports in Berlin are in both results.
 */
SELECT faa,
	   name,
	   city
FROM airports
WHERE city IN ('Hamburg', 'Berlin')
INTERSECT
SELECT faa,
	   name,
	   city
FROM airports
WHERE city='Berlin';

/* EXCEPT [ALL]
 * In this example we return all distinct rows that are in the result-set
 * of the first but not the second SELECT statements. Berlin airports are in both results,
 * therefore only Hamburg airports are returned.
 */
SELECT faa,
	   name,
	   city
FROM airports
WHERE city IN ('Hamburg', 'Berlin')
EXCEPT
SELECT faa,
	   name,
	   city
FROM airports
WHERE city='Berlin';

/* Semi Join
 * In this example we return all records from the outer query that have matches from
 * the inner query. The result-set contains all destination airports that can also be found
 * in the airports table
 */
SELECT DISTINCT dest AS destination_airport
FROM flights
WHERE dest IN (SELECT faa
			   FROM airports);
			  
/* Anti Join
 * In this example we return all records from the outer query that have no matches from
 * the inner query. The result-set contains all destination airports that can not be found
 * in the airports table
 */
SELECT DISTINCT dest AS destination_airport
FROM flights
WHERE dest NOT IN (SELECT faa
			       FROM airports);
			   
/* Subqueries
 * Surprise! We have already used subqueries in the two examples above.
 * In this example we select the flight connections where both the origin
 * and the destination airport's location is above 100m and not in the United States
 */
SELECT DISTINCT origin,
	   dest
FROM flights f
WHERE f.origin IN (SELECT faa
				   FROM airports
				   WHERE alt >= 100
				   AND country <> 'United States')
  AND f.dest IN (SELECT faa
  				 FROM airports
  				 WHERE alt >= 100
  				 AND country <> 'United States'
  				   )		
ORDER BY origin;

/* Conditional Expressions
 * CASE
 * In this example we use CASE to translate the department_delay into a categorical variable.
 * Depending on the delay a flight will be either 'Early', 'On time' or 'Delayed'
 * We can see that the majority of flights departed early or on time.
 */
SELECT flight_date,
	   CASE WHEN dep_delay < 0 THEN 'Early'
			WHEN dep_delay = 0 THEN 'On time'
			ELSE 'Delayed'
	   END AS dep_punctuality,
	   COUNT(*) AS total_flights
FROM flights
WHERE flight_date = '2021-01-01'
GROUP BY 1,2;

/* COALESCE
 * The column dep_time has a lot if NULL values, which can have multiple reasons and shows that
 * data often is 'dirty' and needs to be cleaned. COALESCE lets us set the dep_time to the schedu_dep_time
 * whenever it finds a NULL value in dep_time.
 */
SELECT flight_date,
	   origin,
	   dest,
	   dep_time,
	   sched_dep_time,
	   COALESCE(dep_time, sched_dep_time) AS dep_time_clean
FROM flights
WHERE dep_time IS NULL;

/* CAST
 * In the example below we want to extract the year from the flight_date column.
 * For that we need to extract the first four characters. The function LEFT() is perfect for this.
 * Simply place the column inside the function and specifiy the number of characters, starting from
 * the left, you would like to extract. Unfortunately, this function only works with character type columns.
 * flight_date is of type DATE. We can change this by casting the column to type VARCHAR.
 */
-- This query will fail and throw an error because flight_date is of type DATE
SELECT LEFT(flight_date, 4)
FROM flights;

-- CASTing the flight_date column to type VARCHAR resolves this
SELECT LEFT(CAST(flight_date AS VARCHAR), 4)
FROM flights;

/* Advanced Aggregation
 * Window Functions
 * Window functions perform calculations across a set of table rows
 * that are somehow related to the current row.
 * Let's start by adding the total count of all airports in Germany as a new column.
 */
SELECT country,
	   city,
	   name,
	   faa,
	   (SELECT COUNT(*)
	    FROM airports
	    WHERE country = 'Germany') AS total_airports
FROM airports
WHERE country = 'Germany'
ORDER BY country,
		 city,
		 name;

/* With window functions we can achieve the same result. This time we don't need a subquery 
 * in the SELECT clause and also no GROUPY BY clause, but can instead count each row OVER 
 * the the whole table using the OVER statement.
 */
SELECT country,
	   city,
	   name,
	   faa,
	   COUNT(*) OVER () AS total_airports
FROM airports
WHERE country = 'Germany'
ORDER BY country,
		 city,
		 name;

/* What if we, instead of the total number of airports, want to have a running count of
 * airports alphabetically from A-Z across country, city and name. We can achieve this by 
 * adding an ORDER BY clause to the OVER statement.
 */
SELECT country,
	   city,
	   name,
	   faa,
	   COUNT(*) OVER (ORDER BY country, city, name) AS running_total_airports
FROM airports
WHERE country = 'Germany'
ORDER BY country,
		 city,
		 name;
		 
/* What if we wanted to COUNT the number of airports per city to find out which cities
 * have more than one airport? For this we need to add the argument PARTITION BY and the columns
 * that SQL should use to create groups and perform the window calculation OVER 
 */
SELECT country,
	   city,
	   name,
	   faa,
	   COUNT(*) OVER (PARTITION BY country, city) AS total_airports_by_city
FROM airports
WHERE country = 'Germany'
ORDER BY country,
		 city,
		 name;

/* Lastly, we can combine all of the techniques used above and calculate 
 * a running count of airports ordered alphabetically across country, city and name
 * per country and city. Check out the cities with more than one airport and their running count.
 */	
SELECT country,
	   city,
	   name,
	   faa,
	   COUNT(*) OVER (PARTITION BY country, city ORDER BY country, city, name) AS running_total_airports_by_city
FROM airports
WHERE country = 'Germany'
ORDER BY country,
		 city,
		 name;