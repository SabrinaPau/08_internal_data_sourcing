/* This file is full of practical exercises that will help you in building up your SQL skills.
 */

/* Q1. Select the first 20 rows of columns that have
 * 	   - the full date of the flight,
 * 	   - the airport code of the origin airport
 * 	   - the airport code of the destination airport
 * 	   - whether the flight was cancelled or not
 * 	   from the flights table.
 */
/*SELECT *
FROM flights
LIMIT 20;

SELECT origin
FROM flights
LIMIT 20;

SELECT dest
FROM flights
LIMIT 20;

SELECT cancelled
FROM flights
LIMIT 20;
*/

SELECT flight_date,
		origin,
		dest,
		cancelled
FROM flights
LIMIT 20;

/* Q2. Select the first 20 rows of all columns in the flights table.
 */
SELECT *
FROM flights
LIMIT 20;

/* Q3.1 What is the total number of rows in the flights table?
 * 		Please provide the query and answer below.
 */
SELECT COUNT (*)
FROM flights;
--361,428

/* Q3.2 What is the total number of unique airlines in the flights table?
 * 		Please provide the query and answer below.
 */
SELECT COUNT(DISTINCT airline), COUNT(DISTINCT tail_number)
FROM flights;
-- 17

/* Q4. How many airports does Germany have?
 *     Please provide the query and answer below.
 */
SELECT count(DISTINCT faa)
FROM airports
WHERE country = 'Germany';
--95

/* Q5. How many airport codes start with the letter 'A'?
 *     Please provide the query and answer below.
 */
SELECT count(DISTINCT faa)
FROM airports
WHERE faa LIKE 'A%'
-- 352

/* Q6. How many airports are above 500 and below 1500 altitude?
 *     Please provide the query and answer below.
 */
SELECT count(alt)
FROM airports 
WHERE alt > 500 AND alt < 1500;			-- 1357
--WHERE alt BETWEEN 500 AND 1500;		-- 1361 (BETWEEN includes the ranges)


/* Q7. How many flights had a departure delay smaller or equal to 0?
 *     Please provide the query and answer below.
 */
SELECT count(dep_delay)
FROM flights 
WHERE dep_delay <= 0; 
-- 294,310

/* Q8. What was the average departure delay of all flights on January 1, 2021.
 *     Please provide the query and answer below.
 */
SELECT avg(dep_delay) AS "Average Departure Delay"
FROM flights 
WHERE flight_date = '2021-01-01%';
-- 5.99 hours


/* Q9.1 How many flights have a missing value (NULL value) as their departure time?
 *      Please provide the query and answer below.
 */
SELECT count(flight_date)
FROM flights f 
WHERE dep_time ISNULL;
-- 3,535

/* Q9.2 Out of all flights how many flights were cancelled? 
 *      Is this number equal to the number of flights that have a NULL value as their departure time above?
 *      Please provide the query and answer below.
 */
SELECT count(cancelled)
FROM flights f 
WHERE cancelled = 1;
-- 3,647

/* Q9.3 What conclusion can you derive from Q9.2? Try to come up with possible explanations.
 */
SELECT * --count(flight_date)
FROM flights f
WHERE cancelled = 1
ORDER BY dep_time ASC;
-- it seems as if they departured, but didn't arrive => did they explode?
-- reality: they get some delayed, but then were cancelled

/* Q10. What's the total number of airports from BENELUX countries?
 *      Please provide the query and answer below.
 */
--SELECT faa, city, country 
SELECT count(faa)
FROM airports a 
WHERE country = 'Belgium' OR country = 'Netherlands' OR country = 'Luxembourg';														-- 21
--WHERE country IN ('Belgium', 'Netherlands', 'Luxembourg')
--WHERE country = 'Belgium' OR country = 'Netherlands' OR country = 'Netherlands Antilles' OR country = 'Luxembourg';				-- 26

/* Q11. What's the total number of airports from BENELUX countries that are below 0 altitude?
 *      Please provide the query and answer below.
 */
--SELECT faa, city, country, alt
SELECT count(faa)
FROM airports a 
WHERE alt < 0 AND country IN ('Belgium', 'Netherlands', 'Luxembourg');
-- 3

/* Q12. What's the total number of flights on January 1, 2021 that have a departure time of NULL or were cancelled?
 *      Please provide the query and answer below.
 */
SELECT count(flight_date)
FROM flights 
WHERE flight_date = '2021-01-01%' 
	AND (dep_time ISNULL OR cancelled = 1);
-- 329

/* Q13. What's the name of the airport that is shown in the first row when sorting by airport code descending?
 *      Please provide the query and answer below.
 */
SELECT name
FROM airports a 
ORDER BY faa DESC
LIMIT 1;
-- Zanesville Municipal Airport

/* Q14. Select the country, city and name of all airports. Filter them to only include airports from Hamburg and Berlin.
 * 	    Sort city in ascending and name in descending order.
 * 		What's the name of the airport that is listed last?
 *      Please provide the query and answer below.
 */
SELECT country, city, name 
FROM airports 
WHERE city IN ('Hamburg', 'Berlin')
ORDER BY city, name DESC;
-- Hamburg Airport


/* Q15. Which airport has the lowest altitude?
 *      Please provide the query and answer below.
 */
SELECT name, alt
FROM airports 
ORDER BY alt 
LIMIT 1;
-- Bar Yehuda Airfield

/* Q16. Which airport would have the lowest altitude if we transformed all positive altitudes into negative altitudes and vice versa?
 *      Please provide the query and answer below.
 */
SELECT name, -(alt)
FROM airports a 
ORDER BY 2
LIMIT 1;
-- Daocheng Yading Airport

/* Q17. Give each column selected in the query below a more descriptive name using aliasing.
 * 		If you're not sure what the column means, check out this documentation: https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf
 */
SELECT faa AS "FAA Airport Code",
	   lat AS "Latitude",
	   lon AS "Longitude",
	   alt AS "Altitude",
	   tz AS "Timezone offset from GMT",
	   dst AS "Daylight savings time zone"
FROM airports;

/* Q18.1 Which country has the highest number of airports?
 *       Please provide the query and answer below.
 */
SELECT country, count(*)
FROM airports a 
GROUP BY country
ORDER BY 2 DESC
LIMIT 1; 
-- United States

/* Q18.2 Which city has the highest number of airports?
 *       Please provide the query and answer below.
 */
SELECT city, country, count(city)
FROM airports a 
GROUP BY city, country
ORDER BY 3 DESC
--LIMIT 10; 
-- Columbus & Houston OR London OR Moskow => not sure because many cities are named same

/* Q19. Which plane has flown the most flights? Provide the plane number and the airline it belongs to?
 *      Please provide the query and answer below.
 */
SELECT tail_number, count(tail_number)
FROM flights 
GROUP BY 1
ORDER BY 2 DESC
--LIMIT 2;

SELECT tail_number, airline, count(tail_number)
FROM flights f
GROUP BY 1, 2
ORDER BY 3 DESC 
--LIMIT 2;


/* Q20. How many planes have flown just a single flight?
 * 		Please provide the query and answer below.
 */
SELECT airline, tail_number, count(*)
FROM flights 
GROUP BY 1, 2
HAVING count(tail_number) = 1
ORDER BY 3 DESC;
-- 23 Zeilen
--doesn't show the sum, therefore you have to use

SELECT COUNT(*) AS single_flight
FROM (
    SELECT tail_number
    FROM flights
    GROUP BY tail_number
    HAVING COUNT(*) = 1
) AS single_flights;
-- 23
