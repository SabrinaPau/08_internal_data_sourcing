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
 * LEFT JOIN
 * The flights_join table has 104 flights with origin 'CPR' and 'LFT'
 * The airports_join table has 2 airports, 'GRK' and 'CPR'
 * Performing a left join on the origin with flights as the left and airports as the right table 
 * results in ALL flights and matching airports.
 */

SELECT * 
FROM flights_part AS fp;

SELECT *
FROM airports_part AS ap;

SELECT *
FROM flights_part fp LEFT JOIN airports_part ap
	   ON fp.origin = ap.faa;

/* RIGHT JOIN
 * Performing a right join on the origin with flights as the left and airports as the right table 
 * results in ALL airports with matching flights.
 */
SELECT * 
FROM flights_part fp RIGHT JOIN airports_part ap
	    ON fp.origin = ap.faa;

/* INNER JOIN
 * Performing an inner join on the origin with flights as the left and airports as the right table 
 * results in flights with matching airports ONLY.
 */
SELECT *
FROM flights_part fp
INNER JOIN airports_part ap
	    ON fp.origin = ap.faa;

/* FULL JOIN
 * All flights and all airports are returned.
 * Compared to the other joins, we have all data from both tables
 */
SELECT *
FROM flights_part fp
FULL JOIN airports_part ap
	   ON fp.origin = ap.faa;

/* CROSS JOIN
 * Two tables are created with one column each called number. Each column has 5 rows with the numbers from 1 to 5.
 * The CROSS JOIN then combines both tables by cross combining all rows with each other.
 */	  
SELECT *
FROM flights_part fp
CROSS JOIN airports_part ap;

SELECT *
FROM flights_part fp, airports_part ap;

SELECT *
FROM(
	(SELECT * FROM (VALUES (1), (2), (3), (4), (5)) AS numbers(number)) AS table1
	CROSS JOIN 
	(SELECT * FROM (VALUES (1), (2), (3), (4), (5)) AS numbers(number)) AS table2
);

/* Self Join
 * We join the airports table to itself to match airports that are located in the same city 
*/

SELECT  a1.name AS airport1,
	a2.name AS airport2,
	a1.city
FROM airports a1, airports a2
WHERE a1.city=a2.city
  AND a1.faa<>a2.faa --Filter out self matches
ORDER BY a1.name;

SELECT e.employee_name AS employee,
		s.employee_name AS supervisor
FROM employees e, employees s
WHERE s.employee_id = e.supervisor_id;

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

SELECT faa,
	name,
	city
FROM airports
WHERE city IN ('Hamburg', 'Berlin')
UNION --ALL
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
  				 AND country <> 'United States')		
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
	   COUNT(dep_delay) AS total_flights
FROM flights
WHERE flight_date = '2021-01-01' AND cancelled = 0
GROUP BY 1,2;

/* COALESCE
 * The column dep_time has a lot of NULL values, which can have multiple reasons and shows that
 * data often is 'dirty' and needs to be cleaned. With COALESCE we can tell SQL to use the value 
 * in sched_dep_time instead whenever dep_time is NULL.
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

-- We can either CAST the flight_date column to type VARCHAR to resolve this
SELECT LEFT(CAST(flight_date AS VARCHAR), 4)
FROM flights;

-- or use the ::TYPE notation
SELECT LEFT(flight_date::VARCHAR, 4)
FROM flights;

/* OPTIONAL: Advanced Aggregations with Window Functions
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
 * the the whole table (=window) using the OVER statement.
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
		 
/* What if we wanted to COUNT the number of airports per city to find out which cities have
 * more than one airport? We can use PARTITION BY to perform calculations over specific groups.
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
