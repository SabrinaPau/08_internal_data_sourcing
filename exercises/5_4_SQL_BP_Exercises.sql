/* In this file you will find exercises that will
 * test your knowledge about SQL best practices.
 */

/* Q1. Which of the following techniques should you use to clearly convey your intent?
 */
[ ] Always use AS when aliasing
[ ] Use sequential aliases starting with t (t1, t2, t3,...)
[ ] Use JOIN instead of INNER JOIN, because it makes the script shorter
[ ] All of the above

/* Q2. Improve the query below so its intent is conveyed clearly.
 */
SELECT faa airport_code, lat latitude, lon longitude, alt altitude, tz timezone, dst daylight_savings_time
FROM airports x1
JOIN flights x2 ON x1.faa = x2.origin;

/* Q3. Which of the following tecniques should you use to increase the readability of your SQL queries?
 */
[ ] Use snake_case for column names and camelCase for table names
[ ] Use IN instead of many OR statements
[ ] Only capitalize aggregate functions and keep the rest lowercase
[ ] Use BETWEEN whenever possible
[ ] None of the above

/* Q4. Improve the readability of the SQL query below.
 */
select flight_date as flightDate,
	   dep_time as departureTime,
	   arr_time as arrivalTime,
	   count(*) as totalFlights
from flights f 
where origin in (select faa
				 from airports
				 where alt > 1000
				   and alt < 8000
				   and (country = 'Germany'
				    	or country = 'Netherlands'
				    	or country = 'Belgium'
				    	or country = 'United States'))
group by flightdate,
		 dep_time,
		 arr_time
order by count(*);

/* Q5. Which common mistakes should be avoided when writing SQL code?
 */
1.
2.
3.
4.