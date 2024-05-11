/* This file is full of practical exercises that will help you in building up your advanced SQL skills.
 */
SELECT count(*)
FROM flights;
-- 361,428

SELECT *
FROM airports;
-- 6,072

SELECT *
FROM flights f;

SELECT *
FROM airports a;

/* Q1.1 Which countries had any departures on the '2021-01-04'?
 *      Please provide the query and answer below.
 */ 
SELECT DISTINCT country, count(country)
FROM flights f FULL JOIN airports a ON f.origin = a.faa
WHERE flight_date = '2021-01-04'
GROUP BY 1
ORDER BY 2;
-- Northern Mariana Islands, Guam, Virgin Islands, Puerto Rico, United States

/* Q1.2 Which plane had the most departures?
 *      Please provide the query and answer below.
 */
SELECT tail_number, count(tail_number)
FROM flights f
WHERE flight_date = '2021-01-04'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
-- N487HA: 11


/* Q1.3 Which country had the most departures?
 *      Please provide the query and answer below.
 */
SELECT a.country, count(a.country)
FROM flights f FULL JOIN airports a ON f.origin = a.faa
WHERE flight_date = '2021-01-04' AND f.cancelled = 0 AND f.dep_time IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;
-- United States: 13,981 OR 13,804 OR 13,795


/* Q1.4 To which city/cities does the airport with the second most arrivals belong?
 *      Please provide the query and answer below.
 */
SELECT city, count(dest)
FROM flights f FULL JOIN airports a ON f.dest = a.faa 
WHERE (flight_date = '2021-01-04' AND city IS NOT NULL AND arr_time IS NOT NULL)
GROUP BY 1
ORDER BY 2 DESC
OFFSET 1
LIMIT 1;
-- Dallas-Fort Worth: 725

SELECT city, count(dest)
FROM flights f INNER JOIN airports a ON f.dest = a.faa 
--WHERE (flight_date = '2021-01-04' AND city IS NOT NULL AND arr_time IS NOT NULL)
GROUP BY 1
ORDER BY 2 DESC
OFFSET 1
LIMIT 1;
-- Dallas-Fort Worth: 19,748



/* Q2. How many rows are in your result set when you inner join the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you left join the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you right join the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you full join the flights and airports table on faa and origin column?
 *     Please explain why the number of rows are different.
 */
SELECT count(*)
FROM flights f INNER JOIN airports a ON f.origin = a.faa;
-- 361,311

SELECT count(*)
FROM flights f LEFT JOIN airports a ON f.origin = a.faa;
-- 361,428

SELECT count(*)
FROM flights f RIGHT JOIN airports a ON f.origin = a.faa;
-- 367,028

SELECT count(*)
FROM flights f FULL JOIN airports a ON f.origin = a.faa;
-- 367,145


/* Q3.1 Filter the data to January 1, 2021 and count all rows for that day so that your result set has two columns: flight_date, total_flights.  
 *      Repeat this step, but this time only include data from January 2, 2021.
 *      Combine the two result sets using UNION.
 */
SELECT flight_date, count(flight_date) AS total_flights
FROM flights f
WHERE flight_date = '2021-01-01'
GROUP BY 1
UNION
SELECT flight_date, count(flight_date)
FROM flights f 
WHERE flight_date = '2021-01-02'
GROUP BY 1;


/* Q3.2 Rewrite the query above so that you get the same output, but this time you are not allowed to use UNION.
 */
SELECT flight_date, count(flight_date) AS total_flights
FROM flights f 
WHERE flight_date IN ('2021-01-01', '2021-01-02')
GROUP BY 1;


/* Q3.3 Take your query from Q3.1 and replace the UNION operator with the INTERSECT operator.
 *      Explain your results.
 */
SELECT flight_date, count(flight_date) AS total_flights
FROM flights f
WHERE flight_date = '2021-01-01'
GROUP BY 1
INTERSECT 
SELECT flight_date, count(flight_date)
FROM flights f 
WHERE flight_date = '2021-01-02'
GROUP BY 1;


/* Q3.4 Take your query from Q3.1 and replace the UNION operator with the EXCEPT operator.
 *      Explain your results.
 */
SELECT flight_date, count(flight_date) AS total_flights
FROM flights f
WHERE flight_date = '2021-01-01'
GROUP BY 1
EXCEPT 
SELECT flight_date, count(flight_date)
FROM flights f 
WHERE flight_date = '2021-01-02'
GROUP BY 1;


/* Q4. What's the highest number of flights that have departed in a day from an airport above altitude 7800?
 *     You are NOT allowed to use INNER, LEFT, RIGHT, FULL or CROSS joins!
 *     Please provide the query and answer below.
 */
SELECT flight_date, origin, count(dep_time) AS total
FROM flights f 
WHERE origin IN (SELECT faa
				 FROM airports a
				 WHERE alt > 7800)
	AND f.dep_time	IS NOT NULL AND cancelled = 0 
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 2;
-- ASE: 28


/* Q5.1 How many flights have departed and arrived in the United States?
 *      You are NOT allowed to use INNER, LEFT, RIGHT, FULL or CROSS joins!
 *      Please provide the query and answer below.
 * 
 * select only United States in countries
 * select the flights with origin or destination in US
 * count the number of step 2
 */

-- that's the correct solution:
SELECT count(*)
FROM flights f 
WHERE origin IN (SELECT faa 
				 FROM airports a 
				 WHERE country = 'United States'
				 )
	OR dest IN (SELECT faa 
				 FROM airports a 
				 WHERE country = 'United States'
				 );

------

WITH airports_US AS (
	 SELECT faa
	 FROM airports
	 WHERE country = 'United States'
	 )
SELECT count(origin)
FROM flights
WHERE origin IN (SELECT faa
				 FROM airports_US
				 )
	AND dest IN (SELECT faa
				FROM airports_US
				);
-- 356,125 out of 361,428 total flights
			
----
			
SELECT
    (SELECT COUNT(*)
     FROM flights
     WHERE origin IN (SELECT faa
                     FROM airports
                     WHERE country = 'United States')) AS departures,
    (SELECT COUNT(*)
     FROM flights
     WHERE dest IN (SELECT faa
                   FROM airports
                   WHERE country = 'United States')) AS arrivals;
-- dept: 358,735	arr: 358,730

-----

SELECT count(*)
FROM flights
LEFT JOIN airports
 ON flights.dest = airports.faa
WHERE airports.country = 'Canada';


/* Q5.2 [Hard] Take your query from above and calculate the percentage of flights that have departed 
 *      and arrived in the United States compared to all flights, rounded to one decimal.
 *      Please provide the query and answer below.
 */
WITH airports_US AS (
	 SELECT faa
	 FROM airports
	 WHERE country = 'United States'
	 )
SELECT
		round((CAST(sum(CASE WHEN dest IN (SELECT faa
							FROM airports_US)
				OR origin IN (SELECT faa
									FROM airports_US)
				THEN 1
			ELSE 0 END) AS decimal) / count(*)) * 100, 2) AS percentage_flights_US
FROM flights;

------

SELECT round (count (*)*100.0/ (SELECT COUNT (*)
						FROM flights f),1) AS percentage_flights
FROM flights f
WHERE origin IN (SELECT faa
				FROM airports a
				WHERE country = 'United States')
AND dest  IN (SELECT faa
				FROM airports a
				WHERE country = 'United States');


 /* Q6. Which flight had the highest departure delay?
 *      How big was the delay?
 *      What was the plane's tail number?
 *      On which day and in which city?   
 *      Answer all questions with a single query.
 */

SELECT dep_delay, tail_number, flight_date, a.city
FROM flights f
	INNER JOIN airports a ON f.origin = a.faa
WHERE dep_delay IS NOT NULL AND tail_number IS NOT NULL 
--GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC, 2
LIMIT 1;


/* Q7. What's the flight connection that covers the shortest distance?
 *     Please provide a list with 5 columns: 
 *     - origin_airport = The full name of the origin airport
 *     - origin_country = The country of the origin airport
 *     - destination_airport = The full name of the destination airport
 *     - destination_country = The country of the destination airport
 *     - smallest_distance = The flight distance between origin_airport and destination_airport
 *     Remember: Only provide the flight connection with the shortest distance of all flights in the flights table.
 *     Please provide the query below.
 */
WITH origin_airport AS
		(SELECT name
		FROM airports a INNER JOIN flights f ON a.faa = f.origin),
		destination_airport AS 
		(SELECT name
		FROM airports a INNER JOIN flights f ON a.faa = f.dest)

SELECT name AS "Origin Airport" --f.origin, --a1.name AS "Name of the origin airport",
		--destination_airport.name --f.dest, --a2.name AS "Name of the destination airport",
		--f.distance
FROM origin_airport
--	LEFT JOIN airports a ON f.origin = a.faa
--WHERE f.tail_number IS NOT NULL AND cancelled != 1
--ORDER BY 2

-- Origin Airport & Country ordered by Distance
SELECT tail_number, distance, a.name AS "Origin Airport", a.country AS "Origin Country"--, dest
FROM flights f INNER JOIN airports a ON f.origin = a.faa
ORDER BY distance

-- Destination Airport & Country ordered by Distance
SELECT tail_number, distance, a.name AS "Destination Airport", a.country AS "Destination Country"
FROM flights f INNER JOIN airports a ON f.dest = a.faa 
ORDER BY distance

WITH (	origin_airport AS (
		SELECT a.name 
		FROM airports a INNER JOIN flights f ON a.faa = f.origin
		WHERE f.origin = a.faa
		),
		destination_airport AS (
		SELECT a.name
		FROM airports a INNER JOIN flights f ON a.faa = f.dest
		)

------
--labis solution:
SELECT
   (SELECT name FROM airports WHERE faa = f.origin) AS origin_airport,
   (SELECT country FROM airports WHERE faa = f.origin) AS origin_country,
   (SELECT name FROM airports WHERE faa = f.dest) AS destination_airport,
   (SELECT country FROM airports WHERE faa = f.dest) AS destination_country,
   distance AS smallest_distance
FROM flights f
ORDER BY distance ASC
LIMIT 1;

----
--matts solution:
SELECT DISTINCT
	distance,
    f.origin AS origin_airport,
    a1.country AS origin_country,
    a1.name AS origin_name,
    f.dest AS dest_airport,
    a2.country AS destination_country,
    a2.name AS destination_name
FROM
    flights f
JOIN
    airports a1 ON f.origin = a1.faa
JOIN
    airports a2 ON f.dest = a2.faa
WHERE f.distance = (SELECT min(distance)
					FROM flights)
--ORDER BY
--    f.distance ASC
--LIMIT 1;
 
----
-- Gios solution:
SELECT 
	f.flight_date,
	f.flight_number,
	f.origin AS flight_origin, 
    origin.name AS origin_airport,
    origin.country AS origin_country,
    f.dest AS flight_destination,
    destination.name AS destination_airport,
    destination.country AS destination_country,
    f.distance AS smallest_distance
FROM 
    airports origin, 
    airports destination,
    flights f
WHERE 
    f.origin = origin.faa
    AND f.dest = destination.faa
    AND f.distance = (
        SELECT 
            MIN(distance) 
        FROM 
            flights
    )
ORDER BY flight_date
LIMIT 1;
		
/* OPTIONAL: Advanced Aggregations using Window Functions
 * Q8.1 The airline American Airlines (AA) wants you to take a look at one of their planes: N825AW
 *      They want you to provide a list with 4 columns: flight_date, tail_number, arr_delay, acc_flight_delay.
 *      The 'acc_flight_delay' should calculate the running sum of the arr_delay from beginning to the end of the month
 *      The list should be sorted by the flight date starting with the earliest date
 *      Please provide the query below and answer the following question:
 *      How much delay time has the plane accumulated on its last day?
 */



/* Q8.2 After American Airlines looked at the output you gave them, they realised that the arrival delay
 *      is heavily influenced by the departure delay. If a plane already departed late then it has a high
 *      chance of arriving late. That's why they want you to add the column dep_delay to the list and calculate
 *      the net_flight_delay which is the difference of arr_delay and dep_delay.
 *      Change the acc_flight_delay to acc_net_fligt_delay and adjust the calculation accordingly.
 *      How big is the difference between the previously calculated arr_delay and the net_flight_delay?
 *      Please provide the query and answer below.
 */



/* Q8.3 American Airlines has one more request: Please summarise the previous output and provide
 *      them with a table that has flight_date, tail_number and the sum of net_flight_delay grouped
 *      by flight_date and tail_number.
 */



/* Q8.4 They love it! Good job! Since your work has been very helpful to them they want to expand the output to
 *      more planes that they own. Please add the following planes in your output: N825AW, N756AM, N9018E.
 *      Additionally they would like you to add an additional column to the output called net_flight_delay_cat.
 *      This column should one of three categories depending on the value of net_flight_delay.
 *      If net_flight_delay > 0 then '1-Slower'
 *      net_flight_delay = 0 then '2-As_expected'
 *      else '3-Faster'.
 *      Please provide the query below.
 */



/* Q8.5 You've been doing an amazing job, American Airlines has one last request for you:
 *      Please summarise the previous output so that the final output groups by the tail_number
 *      and the dep_delay_cat and aggregates the number of flights in each category in a column
 *      called total_flights and the average flight delay in the column avg_daily_flight_delay.
 */



/* Q9. Final question: 
 *     Three SQL databases walk into a bar... then they leave. Why?
 *     They couldn't find a table. *badum ts*
 */
