/* In this file you will find exercises that will
 * test your knowledge about SQL best practices.
 */

//* Q1. Which of the following techniques should you use to clearly convey your intent?
 */
[x] Always use AS when aliasing
[ ] Use sequential aliases starting with t (t1, t2, t3,...)
[ ] Use JOIN instead of INNER JOIN, because it makes the script shorter
[ ] All of the above

/* Q2. Improve the query below so its intent is conveyed clearly.
 */
SELECT faa AS airport_code, 
	   lat AS latitude,
	   lon AS longitude,
	   alt AS altitude,
	   tz AS timezone,
	   dst AS daylight_savings_time
FROM airports a
JOIN flights f
  ON a.faa = f.origin;

/* Q3. Which of the following tecniques should you use to increase the readability of your SQL queries?
 */
[ ] Use snake_case for column names and camelCase for table names
[x] Use IN instead of many OR statements
[ ] Only capitalize aggregate functions and keep the rest lowercase
[x] Use BETWEEN whenever possible
[ ] None of the above

/* Q4. Improve the readability of the SQL query below.
 */
SELECT flight_date,
	   dep_time AS departure_time,
	   arr_time AS arrival_time,
	   COUNT(*) AS total_flights
FROM flights
WHERE origin IN (SELECT faa
				 FROM airports
				 WHERE alt BETWEEN 1000 AND 8000
				   AND country IN ('Germany', 
				   					'Netherlands', 
				   					'Belgium',
				   					'United States'))
GROUP BY flightdate,
		 dep_time,
		 arr_time
ORDER BY COUNT(*);

/* Q5. Which common mistakes should be avoided when writing SQL code?
 */
1. Writing an essay in my comments
2. Leaving old comments in my finished code
3. Writing redundant comments
4. Selecting everything