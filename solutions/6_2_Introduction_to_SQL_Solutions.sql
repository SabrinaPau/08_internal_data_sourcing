/* This file is full of practical exercises that will help you in building up your SQL skills.
 */

/* Q1. Select the first 20 rows of columns that have
 * 	   - the full date of the flight,
 * 	   - the airport code of the origin airport
 * 	   - the airport code of the destination airport
 * 	   - whether the flight was cancelled or not
 * 	   from the flights table.
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
SELECT COUNT(*)
FROM flights;

361.428;

/* Q3.2 What is the total number of unique airlines in the flights table?
 * 		Please provide the query and answer below.
 */
SELECT COUNT(DISTINCT airline)
FROM flights;

17;

/* Q4. How many airports does Germany have?
 *     Please provide the query and answer below.
 */
SELECT COUNT(*)
FROM airports
WHERE country = 'Germany';

95;

/* Q5. How many airport codes start with the letter 'A'?
 *     Please provide the query and answer below.
 */
SELECT COUNT(*) 
FROM airports
WHERE faa LIKE 'A%';

352;

/* Q6. How many airports are above 500 and below 1500 altitude?
 *     Please provide the query and answer below.
 */
SELECT COUNT(*) AS total_airports
FROM airports
WHERE alt BETWEEN 500 AND 1500;

1.361;

/* Q7. How many flights had a departure delay smaller or equal to 0?
 *     Please provide the query and answer below.
 */
SELECT COUNT(*) AS total_flights
FROM flights
WHERE dep_delay <= 0;

294.310;

/* Q8. What was the average departure delay of all flights on January 1, 2021.
 *     Please provide the query and answer below.
 */
SELECT AVG(dep_delay) AS avg_dep_delay
FROM flights
WHERE flight_date = '2021-01-01';

5.99;

/* Q9.1 How many flights have a missing value (NULL value) as their departure time?
 *      Please provide the query and answer below.
 */
SELECT COUNT(*) AS no_dep_time
FROM flights
WHERE dep_time IS NULL;

3.535;

/* Q9.2 Out of all flights how many flights were cancelled? 
 *      Is this number equal to the number of flights that have a NULL value as their departure time above?
 *      Please provide the query and answer below.
 */
SELECT SUM(cancelled) AS cancelled_flights
FROM flights;

6.647 - NOT equal;

/* Q9.3 What does the answer you arrived at in the question above (Q9.2) mean and how could it be explained?
* The numbers are not equal even though they should be. Cancelled flights should not have a departure time. 
* The difference could be explained by last minute cancellations after pushback.
*/

/* Q10. What's the total number of airports FROM BENELUX countries?
 *      Please provide the query and answer below.
 */
SELECT COUNT(*) AS total_airports
FROM airports
WHERE country IN ('Belgium', 'Netherlands', 'Luxembourg');

21;

/* Q11. What's the total number of airports from BENELUX countries that are below 0 altitude?
 *      Please provide the query and answer below.
 */
SELECT COUNT(*) AS total_airports
FROM airports
WHERE country IN ('Belgium', 'Netherlands', 'Luxembourg')
  AND alt < 0;
  
3;

/* Q12. What's the total number of flights on January 1, 2021 that have a departure time of NULL or were cancelled?
 *      Please provide the query and answer below.
 */
SELECT COUNT(*) AS total_flights
FROM flights
WHERE flight_date = '2021-01-01'
  AND (dep_time IS NULL OR cancelled = 1);
  
329;

/* Q13. What's the name of the airport that is shown in the first row when sorting by airport code descending?
 *      Please provide the query and answer below.
 */
SELECT name 
FROM airports
ORDER BY faa DESC
LIMIT 1;

Zanesville Municipal Airport;

/* Q14. Select the country, city and name of all airports. Filter them to only include airports from Hamburg and Berlin.
 * 	    Sort city in ascending and name in descending order.
 * 		What's the name of the airport that is listed last?
 *      Please provide the query and answer below.
 */
SELECT country,
	   city,
	   name
FROM airports
WHERE city IN ('Hamburg', 'Berlin')
ORDER BY city ASC,
		 name DESC;

Hamburg Airport;

/* Q15. Which airport has the lowest altitude?
 *      Please provide the query and answer below.
 */
SELECT MIN(alt)
FROM airports;

SELECT name
FROM airports
WHERE alt = -1266;

SELECT name, alt 
FROM airports
ORDER BY alt
LIMIT 1;

Bar Yehuda Airfield;

/* Q16. Which airport would have the lowest altitude if we transformed all positive altitudes into negative altitudes and vice versa?
 *      Please provide the query and answer below.
 */
SELECT MIN(alt*-1)
FROM airports;

SELECT name
FROM airports
WHERE alt = 14472;

Daocheng Yading Airport;

/* Q17. Give each column selected in the query below a more descriptive name using aliasing.
 * 		If you're not sure what the column means, check out this documentation: https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf
 */
SELECT faa AS airport_code,
	   lat AS latitude,
	   lon AS longitude,
	   alt AS altitude,
	   tz AS timezone,
	   dst AS daylight_savings_timezone
FROM airports;

/* Q18.1 Which country has the highest number of airports?
 *        Please provide the query and answer below.
 */
SELECT country,
	   COUNT(*) AS total_airports
FROM airports
GROUP BY country
ORDER BY COUNT(*) DESC;

United States;

/* Q18.2 Which city has the highest number of airports?
 *        Please provide the query and answer below.
 */
SELECT count(*) AS cnt, city, country 
FROM airports
WHERE city IS NOT NULL
GROUP BY country, city	
ORDER BY cnt DESC;

6 airports at Columbus and Houston;

/* Q19. Which plane has flown the most flights? Which airline is it belonging to, and how often was it in the air?
 *      Please provide the query and answer below.
 */
SELECT airline,
	   tail_number,
	   COUNT(*) AS total_flights
FROM flights
WHERE tail_number IS NOT NULL
GROUP BY airline,
		 tail_number
ORDER BY COUNT(*) DESC;

HA - N480HA - 218;

/* Q20. How many planes have only done 1 flight in total in 2021?
 * 		Please provide the query and answer below.
 */
SELECT tail_number,
	   COUNT(*) AS total_flights
FROM flights
GROUP BY tail_number 
HAVING COUNT(*) = 1;

21;
