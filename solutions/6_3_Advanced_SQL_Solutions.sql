/* This file is full of practical exercises that will help you in building up your advanced SQL skills.
 */

/* Q1.1 Which countries had any departures on the '2021-01-04'?
 *     Please provide the query and answer below.
 */ 

SELECT DISTINCT a.country 
FROM airports a INNER JOIN flights f 
ON a.faa = f.origin 
WHERE flight_date = '2021-01-04';

/* Q1.2 Which plane had the most departures?
 *     Please provide the query and answer below.
 */

SELECT 	tail_number ,
		COUNT(*) AS number_departures
FROM flights f 
WHERE tail_number IS NOT NULL
GROUP BY tail_number
ORDER BY COUNT(*) DESC 
LIMIT 1;

/* Q1.3 What country had the most departures?
 *     Please provide the query and answer below.
 */
SELECT country,
       COUNT(*) AS total_departures
FROM airports a
INNER JOIN flights f
		ON a.faa = f.origin
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 1;

/* Q1.4 What city had the second most arrivals?
 *     Please provide the query and answer below.
 */
SELECT city,
       COUNT(*) AS total_arrivals
FROM airports a
INNER JOIN flights f
		ON a.faa = f.dest
GROUP BY country, city
ORDER BY COUNT(*) DESC
OFFSET 1
LIMIT 1;




/* Q2. How many rows are in your result set when you inner join the flights and airports table on faa and origin column?
 * 	   How many rows are in your result set when you left join the flights and airports table on faa and origin column?
 * 	   How many rows are in your result set when you right the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you full join the flights and airports table on faa and origin column?
 * 	   Please explain why the number of rows are different.
 */
SELECT COUNT(*)
FROM flights f
INNER JOIN airports a
	    ON f.origin=a.faa;

SELECT COUNT(*)
FROM flights f
LEFT JOIN airports a
	    ON f.origin=a.faa;

SELECT COUNT(*)
FROM flights f
RIGHT JOIN airports a
	    ON f.origin=a.faa;

SELECT COUNT(*)
FROM flights f
FULL JOIN airports a
	    ON f.origin=a.faa;

/* Q3.1 Filter the data to January 1, 2021 and count all rows for that day so that your result set has two columns: flight_date, total_flights.  
 * 		Repeat this step, but this time only include data from January 2, 2021.
 * 		Combine the two result sets using UNION.
 */
SELECT flight_date,
	   COUNT(*) AS total_flights
FROM flights
WHERE flight_date='2021-01-01'
GROUP BY flight_date 
UNION
SELECT flight_date,
	   COUNT(*) AS total_flights
FROM flights
WHERE flight_date='2021-01-02'
GROUP BY flight_date;

/* Q3.2 Rewrite the query above so that you get the same output, but this time you are not allowed to use UNION.
 */
SELECT flight_date,
	   COUNT(*) AS total_flights
FROM flights
WHERE flight_date IN ('2021-01-01', '2021-01-02')
GROUP BY flight_date;

/* Q3.3 Take your query from Q3.1 and replace the UNION operator with the INTERSECT operator.
 * 		Explain your results.
 */
SELECT flight_date,
	   COUNT(*) AS total_flights
FROM flights
WHERE flight_date='2021-01-01'
GROUP BY flight_date 
INTERSECT
SELECT flight_date AS total_flights,
	   COUNT(*)
FROM flights
WHERE flight_date='2021-01-02'
GROUP BY flight_date;

/* Q3.4 Take your query from Q3.1 and replace the UNION operator with the EXCEPT operator.
 * 		Explain your results.
 */
SELECT flight_date,
	   COUNT(*) AS total_flights
FROM flights
WHERE flight_date='2021-01-01'
GROUP BY flight_date 
EXCEPT
SELECT flight_date AS total_flights,
	   COUNT(*)
FROM flights
WHERE flight_date='2021-01-02'
GROUP BY flight_date;

/* Q4. What's the highest number of flights that have departed in a day from an airport above altitude 7800?
 *	   You are NOT allowed to use INNER, LEFT, RIGHT, FULL or CROSS joins!
 * 	   Please provide the query and answer below.
 */
SELECT flight_date,
	   COUNT(*) AS total_flights
FROM flights f 
WHERE origin IN (SELECT faa
				 FROM airports
				 WHERE alt > 7800)
GROUP BY flight_date
ORDER BY COUNT(*) DESC;

/* Q5.1 How many flights have departed and arrived in the United States?
 *      You are NOT allowed to use INNER, LEFT, RIGHT, FULL or CROSS joins!
 * 		Please provide the query and answer below.
 */
SELECT COUNT(*) AS total_flights
FROM flights
WHERE origin IN (SELECT faa
				 FROM airports
				 WHERE country='United States')
  AND dest IN (SELECT faa
			   FROM airports
			   WHERE country='United States');

/* Q5.2 [Hard] Take your query from above and calculate the percentage of flights that have departed 
 *      and arrived in the United States compared to all flights, rounded to one decimal.
 *      Please provide the query and answer below.
 */
SELECT ROUND((COUNT(*) * 1.00 / (SELECT COUNT(*) * 1.00
				                 FROM flights)*100), 1) AS share_of_us_flights
FROM flights
WHERE origin IN (SELECT faa
				 FROM airports
				 WHERE country='United States')
   AND dest IN (SELECT faa
				FROM airports
				WHERE country='United States');

/* Q6. Which flight had the highest departure delay?
 *     How big was the delay?
 * 	   What was the plane's tail number?
 * 	   What day was it?
 * 	   Please provide the query and answer below.
 */
SELECT flight_date,
	   flight_number,
	   dep_delay,
	   tail_number
FROM flights
WHERE dep_delay = (SELECT MAX(dep_delay)
				   FROM flights f);

/* Q7. What's the flight connection that covers the shortest distance?
 * 	   Please provide a list with 5 columns: 
 *     - origin_airport = The full name of the origin airport
 * 	   - origin_country = The country of the origin airport
 * 	   - destination_airport = The full name of the destination airport
 * 	   - destination_country = The country of the destination airport
 * 	   - smallest_distance = The flight distance between origin_airport and destination_airport
 * 	   Remember: Only provide the flight connection with the shortest distance of all flights in the flights table.
 * 	   Please provide the query below.
 */
SELECT DISTINCT a.name AS origin_airport,
	   a.country AS origin_country,
	   a2.name AS destination_airport,
	   a2.country AS destination_country,
	   f.distance AS smallest_distance
FROM flights f
LEFT JOIN airports a 
	   ON f.origin = a.faa
LEFT JOIN airports a2 
	   ON f.dest = a2.faa
WHERE distance = (SELECT MIN(distance)
				  FROM flights);
			  
/* BONUS: Advanced Aggregations using Window Functions
 * Q8.1 The airline American Airlines (AA) wants you to take a look at one of their planes: N825AW
 * 		They want you to provide a list with 4 columns: flight_date, tail_number, arr_delay, acc_flight_delay.
 * 		The 'acc_flight_delay' should calculate the running sum of the arr_delay from beginning to the end of the month
 * 		The list should be sorted by the flight date starting with the earliest date
 * 		Please provide the query below and answer the following questions: 
 * 		1. How much delay time has the plane accumulated on its last day?
 * 		2. On how many days did the plane arrive earlier than scheduled (=flight delay > 0)?
 */
SELECT flight_date,
	   tail_number,
	   arr_delay,
	   SUM(arr_delay) OVER (ORDER BY flight_date, arr_delay) AS acc_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number='N825AW'
ORDER BY flight_date;

SELECT count( DISTINCT flight_date)  
FROM flights f 
WHERE flight_date IN (SELECT flight_date FROM flights f2 WHERE dep_delay > 0)
GROUP BY flight_date;

/* Q8.2 After American Airlines looked at the output you gave them, they realised that the arrival delay
 *      is heavily influenced by the departure delay. If a plane already departed late then it has a high
 * 		chance of arriving late. That's why they want you to add the column dep_delay to the list and calculate
 * 		the net_flight_delay which is the difference of arr_delay and dep_delay.
 * 		Change the acc_flight_delay to acc_net_fligt_delay and adjust the calculation accordingly.
 * 		How big is the difference between the previously calculated arr_delay and the net_flight_delay?
 * 		Please provide the query and answer below.
 */
SELECT flight_date,
	   tail_number,
	   dep_delay,
	   arr_delay,
	   arr_delay-dep_delay AS net_flight_delay,
	   SUM(arr_delay-dep_delay) OVER (ORDER BY flight_date, arr_delay) AS acc_net_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number='N825AW'
ORDER BY flight_date;

/* Q8.3 American Airlines has one more request: Please summarise the previous output and provide
 * 		them with a table that has flight_date, tail_number and the sum of net_flight_delay grouped
 * 		by flight_date and tail_number.
 */
SELECT dl.flight_date,
	   dl.tail_number,
	   SUM(dl.net_flight_delay) AS net_flight_delay
FROM(
SELECT flight_date,
	   tail_number,
	   dep_delay,
	   arr_delay,
	   arr_delay-dep_delay AS net_flight_delay,
	   SUM(arr_delay-dep_delay) OVER (ORDER BY flight_date ASC, arr_delay) AS acc_net_flight_delay
FROM flights
WHERE airline = 'AA'
ORDER BY flight_date ASC) AS dl
GROUP BY 1,2;

/* Q8.4 They love it! Good job! Since your work has been very helpful to them they want to expand the output to
 * 		more planes that they own. Please add the following planes in your output: N206UW, N756AM, N9018E.
 * 		Hint: Make sure your window function can handle multiple planes ;)
 * 		Additionally they would like you to add an additional column to the output called net_flight_delay_cat.
 *		This column should one of five categories depending on the value of net_flight_delay.
 *		If net_flight_delay > 0 then '1-Godspeed'
 *		   net_flight_delay = 0 then '2-YOLO'
 *		   net_flight_delay > -10 then '3-Meh'
 *		   net_flight_delay > -25 then '4-Sh*t'
 *		   net_flight_delay > -50 then '5-Oh no'
 *		   else '6-WTF.
 *		Please provide the query below.
 */
SELECT dl.flight_date,
	   dl.tail_number,
	   SUM(dl.net_flight_delay) AS net_flight_delay,
	   CASE WHEN SUM(dl.net_flight_delay) > 0 THEN '1-Godspeed'
	   		WHEN SUM(dl.net_flight_delay) = 0 THEN '2-YOLO'
	   		WHEN SUM(dl.net_flight_delay) > -10 THEN '3-Meh'
	   		WHEN SUM(dl.net_flight_delay) > -25 THEN '4-Sh*t'
	   		WHEN SUM(dl.net_flight_delay) > -50 THEN '5-Oh no'
	   		ELSE '6-WTF'
	   END AS net_flight_delay_cat
FROM(
SELECT flight_date,
	   tail_number,
	   dep_delay,
	   arr_delay,
	   arr_delay-dep_delay AS net_flight_delay,
	   SUM(arr_delay-dep_delay) OVER (PARTITION BY tail_number ORDER BY flight_date, arr_delay) AS acc_net_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number IN ('N825AW', 'N206UW', 'N756AM', 'N9018E')
ORDER BY tail_number, flight_date) AS dl
GROUP BY 1,2
ORDER BY 2,1;

/* Q8.5 You've been doing an amazing job, American Airlines has one last request for you:
 * 		Please summarise the previous output so that the final output groups by the tail_number
 * 		and the dep_delay_cat and aggregates the number of flights in each category in a column
 * 		called total_flights and the average flight delay in the column avg_daily_flight_delay.
 * 		Which plane(s) managed to fly at godspeed?
 * 		Which plane(s) managed to yolo a precision landing?
 * 		How many flights ended up in the '6-WTF' category?
 */
SELECT sm.tail_number,
	   sm.net_flight_delay_cat,
	   COUNT(*) AS total_flights,
	   AVG(sm.net_flight_delay) AS avg_daily_flight_delay
FROM(
SELECT dl.flight_date,
	   dl.tail_number,
	   SUM(dl.net_flight_delay) AS net_flight_delay,
	   CASE WHEN SUM(dl.net_flight_delay) > 0 THEN '1-Godspeed'
	   		WHEN SUM(dl.net_flight_delay) = 0 THEN '2-YOLO'
	   		WHEN SUM(dl.net_flight_delay) > -10 THEN '3-Meh'
	   		WHEN SUM(dl.net_flight_delay) > -25 THEN '4-Sh*t'
	   		WHEN SUM(dl.net_flight_delay) > -50 THEN '5-Oh no'
	   		ELSE '6-WTF'
	   END AS net_flight_delay_cat
FROM(
SELECT flight_date,
	   tail_number,
	   dep_delay,
	   arr_delay,
	   arr_delay-dep_delay AS net_flight_delay,
	   SUM(arr_delay-dep_delay) OVER (PARTITION BY tail_number ORDER BY flight_date, arr_delay) AS acc_net_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number IN ('N825AW', 'N206UW', 'N756AM', 'N9018E')
ORDER BY tail_number, flight_date) AS dl
GROUP BY 1,2
ORDER BY 2,1) AS sm
GROUP BY 1,2
ORDER BY 1,2 DESC;

N756AM, N9018E;
N9018E;
3;

/* Q9. Final question: 
 * 	   Three SQL databases walk into a bar... then they leave. Why?
 * 	   They couldn't find a table. *badum ts*
 */

