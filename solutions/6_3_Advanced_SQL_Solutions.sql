/* This file is full of practical exercises that will help you in building up your advanced SQL skills.
 */

/* Q1.1 Which countries had any departures on the '2021-01-04'?
 *      Please provide the query and answer below.
 */ 

SELECT DISTINCT a.country 
FROM airports a 
INNER JOIN flights f 
ON a.faa = f.origin 
WHERE flight_date = '2021-01-04';


/* Q1.2 Which plane had the most departures?
 *      Please provide the query and answer below.
 */

SELECT tail_number,
	   COUNT(*) AS number_departures
FROM flights f 
WHERE tail_number IS NOT NULL
AND cancelled != 1
GROUP BY tail_number
ORDER BY COUNT(*) DESC 
LIMIT 1;


/* Q1.3 Which country had the most departures?
 *      Please provide the query and answer below.
 */

SELECT country,
       COUNT(*) AS total_departures
FROM airports a
INNER JOIN flights f
		ON a.faa = f.origin
WHERE cancelled <> 1
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 1;


/* Q1.4 To which city/cities does the airport with the second most arrivals belong?
 *      Please provide the query and answer below.
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

--> differences in the number of airport codes between flights (origin) and airports (faa)

/* N.B.: if no primary key between tables are available or enough to join two tables, we can add as many keys as necessary in the JOIN.
Example: if we did not have a code to join the airports and flights tables, but only the city name. 
We could run into issues e.g. Paris, France and Paris, Texas in the USA.
Therefore, in that case, we could use 2 keys to distinguish the two.
The requirement would be that both airports and flights table contain a field "city" and a field "country"
See the example below:
/*/

SELECT COUNT(*)
FROM flights f
FULL JOIN airports a
	   ON f.origin_city = a.city 
	   AND f.origin_country = a.country;


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

--> UNION combines the distinct results of two or more SELECT statements


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

--> INTERSECT returns all distinct rows that are in the results of both SELECT statements


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

--> EXCEPT returns all distinct rows that are in the result of the first but not in the result of the second SELECT statement


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
ORDER BY COUNT(*) DESC
LIMIT 1;


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

--> The multiplication with 1.00 is one way to convert an integer to a numeric data type.


 /* Q6. Which flight had the highest departure delay?
 *      How big was the delay?
 * 	    What was the plane's tail number?
 * 	    On which day and in which city?   
 * 	    Answer all questions with a single query.
 */

SELECT f.flight_date,
	   f.flight_number,
	   f.dep_delay,
	   f.tail_number,
	   a.city
FROM flights f
INNER JOIN airports a
ON a.faa = f.origin
WHERE f.dep_delay = (SELECT MAX(f.dep_delay)
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
 * 		Please provide the query below and answer the following question:
 * 		How much delay time has the plane accumulated on its last day?
 */

SELECT flight_date,
	   tail_number,
	   arr_delay,
	   SUM(arr_delay) OVER (ORDER BY flight_date, arr_delay) AS acc_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number='N825AW'
ORDER BY flight_date;


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
	  SUM(dl.net_flight_delay) AS net_flight_delay,
	  dl.acc_net_flight_delay
FROM(
SELECT flight_date,
	  tail_number,
	  dep_delay,
	  arr_delay,
	  arr_delay-dep_delay AS net_flight_delay,
	  SUM(arr_delay-dep_delay) OVER (ORDER BY flight_date, tail_number) AS acc_net_flight_delay
FROM flights
WHERE airline = 'AA'
ORDER BY flight_date ASC) AS dl
GROUP BY 1,2,4
ORDER BY 1,2;


/* Q8.4 They love it! Good job! Since your work has been very helpful to them they want to expand the output to
 * 		more planes that they own. Please add the following planes in your output: N825AW, N756AM, N9018E.
 * 		Additionally they would like you to add an additional column to the output called net_flight_delay_cat.
 *		This column should one of three categories depending on the value of net_flight_delay.
 *		If net_flight_delay > 0 then '1-Slower'
 *		   net_flight_delay = 0 then '2-As_expected'
 *		   else '3-Faster'.
 *		Please provide the query below.
 */

SELECT flight_date,
	   tail_number,
	   SUM(dl.net_flight_delay) AS net_flight_delay,
	   CASE WHEN SUM(dl.net_flight_delay) > 0 THEN '1-Slower'
	   		WHEN SUM(dl.net_flight_delay) = 0 THEN '2-As_expected'
	   		ELSE '3-Faster'
	   END AS net_flight_delay_cat
FROM(
SELECT flight_date,
	   tail_number,
	   arr_delay-dep_delay AS net_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number IN ('N825AW', 'N756AM', 'N9018E')
ORDER BY tail_number, flight_date) AS dl
GROUP BY 1,2
ORDER BY 1,2;


/* Q8.5 You've been doing an amazing job, American Airlines has one last request for you:
 * 		Please summarise the previous output so that the final output groups by the tail_number
 * 		and the dep_delay_cat and aggregates the number of flights in each category in a column
 * 		called total_flights and the average flight delay in the column avg_daily_flight_delay.
 */

SELECT flight_date,
	   tail_number,
	   COUNT(*) AS total_flights,
	   SUM(dl.net_flight_delay) AS net_flight_delay,
	   AVG(dl.net_flight_delay) AS net_flight_delay,
	   CASE WHEN SUM(dl.net_flight_delay) > 0 THEN '1-Slower'
	   		WHEN SUM(dl.net_flight_delay) = 0 THEN '2-As_expected'
	   		ELSE '3-Faster'
	   END AS net_flight_delay_cat
FROM(
SELECT flight_date,
	   tail_number,
	   arr_delay-dep_delay AS net_flight_delay
FROM flights
WHERE airline = 'AA'
  AND tail_number IN ('N825AW', 'N756AM', 'N9018E')
ORDER BY tail_number, flight_date) AS dl
GROUP BY 1,2
ORDER BY 1,2;


/* Q9. Final question: 
 * 	   Three SQL databases walk into a bar... then they leave. Why?
 * 	   They couldn't find a table. *badum ts*
 */