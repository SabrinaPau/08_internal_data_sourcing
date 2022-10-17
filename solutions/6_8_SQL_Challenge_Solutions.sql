/*   As a Data Analyst, it is crucial that you can rely on the quality of your data at all times.
 *   The data in the actual_elapsed_time column in the flights table seems to be about the time from departure to arrival.
 *   Currently, this is only an assumption. Based on this assumption, do you feel confident in using this column in your 
 *   analysis and giving out business recommendations?
 *   If your answer is no, you're on a good path to becoming an analyst.
 *
 * 1.Using the data in the remaining columns in the flights table, can you think of a way to verify our assumption?
 *   Please provide the answer below.
 */

-- Yes, we can calculate the difference between departure and arrival time and compare it to the values in the 
-- actual_elapsed_time column to check if they're equal.

/*   Don't worry if you couldn't figure this one out. To verify our assumption, we can calculate the difference between 
 *   departure and arrival time and compare the result to the values in the actual_elapsed_time column to check if they're equal.
 */

/* 2.1 The first step is to become familiar with the dep_time, arr_time and actual_elapsed_time columns.
 *     Based on the column names and what you already know from previous exercises about the information that is stored 
 *     in these three columns, what are your assumptions about the data types of the values?
 */

-- arr_time: TIME value in the format XX:XX e.g. 11:30
-- dep_time: TIME value in the format XX:XX e.g. 11:30
-- actual_elapsed_time: Either in seconds, minutes or hours; stored as INT or INTERVAL in the format XX:XX:XX e.g. 00:10:00


/* 2.2 Retrieve all unique values from these columns in three separate queries and order them in descending order.
 *     Did your assumptions turn out to be correct?
 * 	   Please provide the queries below.
 */

SELECT DISTINCT arr_time
FROM flights f
ORDER BY arr_time DESC;
-- arr_time is stored as a hundred or thousand number

SELECT DISTINCT dep_time
FROM flights f
ORDER BY dep_time DESC;
-- dep_time is stored as a hundred or thousand number

SELECT DISTINCT actual_elapsed_time 
FROM flights f
ORDER BY actual_elapsed_time DESC;
-- actual_elapsed_time is stored in minutes as INT/FLOAT

/* 3.1 Next, calculate the difference of dep_time and arr_time and call it flight_duration.
 * 	   Please provide the query below.
 */

SELECT arr_time - dep_time AS flight_duration
FROM flights;

/* 3.2 Are the calculated flight duration values correct? If not, what's the problem and how can we solve it?
 *     Please provide the answer below.
 */

-- No, the values are not correct. dep_time and arr_time are not in time formats and the difference is not in minutes.

/* 4 In order to calculate correct flight duration values we need to convert dep_time, arr_time and actual_elapsed_time 
 *   into useful data types first.
 *   Change dep_time and arr_time into TIME variables, call them dep_time_f and arr_time_f. (Hint: 100% focus on the remainder)
 *   Change actual_elapsed_time into an INTERVAL variable, call it actual_elapsed_time_f.
 *   Query flight_date, origin, dest, dep_time, dep_time_f, arr_time, arr_time_f, actual_elapsed_time and actual_elapsed_time_f.
 *   Please provide the query below.
 */

SELECT flight_date,
       origin,
       dest,
       dep_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       arr_time,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       actual_elapsed_time,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
FROM flights;

/* 5.1 Querying the raw columns next to the ones we have transformed, makes it a lot easier to compare the result to the input.
 *     This allows for quick prototyping and debugging and helps to understand how functions work. 
 *     To optimize our query in terms of performance and readability, we can always remove unneccessary columns in the end. 
 *     Use the previous query and calculate the difference of arr_time_f and dep_time_f and call it flight_duration_f.
 * 	   Please provide the query below.
 */
 
/*     NOTE: From now on we will provide you with a
 *     - long solution: easy to debug -> includes additional columns that are not necessary to solve the exercise
 *     - short solution: optimised for performance and readability -> without any unecessary columns
 *       as well as alternative solutions using one or multiple subqueries and detailed explanations where necessary.
 */
-- long solution using one subquery
SELECT arr_time_f - dep_time_f AS flight_duration_f
FROM (
      SELECT flight_date,
             origin,
             dest,
             dep_time,
             MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             arr_time,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
             actual_elapsed_time,
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
      FROM flights
	 ) AS f;

-- short solution using one subquery
SELECT arr_time_f - dep_time_f AS flight_duration_f
FROM (
      SELECT MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
      FROM flights) AS f;

-- short solution without using a subquery
SELECT MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
	   MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS flight_duration_f,
	   MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
FROM flights;

/* 5.2 Compare the calculated flight duration values in flight_duration_f with the values in the actual_elapsed_time_f column and 
 * 	   calculate the percentage of values that are equal in both columns.
 * 	   Please provide the query below.
 */

/* Explanation of the solution: 
 * The output of comparing two numbers, actual_elapsed_time_f and flight_duration_f, results in TRUE/FALSE of type BOOLEAN
 * Casting a BOOLEAN into an INTEGER turns TRUE=1 and FALSE=0, summing up the values gives the total number of equal values
 * In order to calculate the percentage, we can simply divide it by the total number of flights using COUNT(*)
 * Remember: In SQL, dividing two INTEGERS results in an INTEGER. Therefore we need to cast one value into a float using * 1.0.
 */
-- long solution using a subquery
SELECT SUM((actual_elapsed_time_f = (arr_time_f - dep_time_f))::INT) * 1.0 / COUNT(*) * 100 AS match_percent
FROM (
      SELECT flight_date,
             origin,
             dest,
             dep_time,
             MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             arr_time,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
             actual_elapsed_time,
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
      FROM flights
	 ) AS f;

-- short solution using a subquery
SELECT SUM((actual_elapsed_time_f = (arr_time_f - dep_time_f))::INT) * 1.0 / COUNT(*) * 100 AS match_percent
FROM (
      SELECT MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
      FROM flights
	 ) AS f;

-- short solution without using a subquery (low readability)
SELECT SUM (
            (
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) =
             (
              MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0)
             )
            )::INT
           ) * 1.0 / COUNT(*) * 100 AS match_percent
FROM flights;
/* 5.3 Given the percentage of matching values, can you come up with possible explanations for why the rate is so low?
 *     Please provide the answer below.
 */

-- Time zone differences
-- Overnight flights
-- Bad data quality

/* 6.1 Differences due to time zones might be one reason for the low rate of matching values.
 *     To make sure the dep_time and arr_time values are all in the same time zone we need to know in which time zone they are.
 *     Take your query from exercise 5.1 and add the time zone values from the airports table.
 * 	   Make sure to transform them to INTERVAL and change their names to origin_tz and dest_tz.
 *     Please provide the query below.
 */
-- long solution
SELECT flight_date,
       origin,
       dest,
       MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
       MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
       dep_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       arr_time,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       actual_elapsed_time,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS flight_duration_f
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa;

-- short solution
SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
       MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS flight_duration_f
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa;

/* 6.2 Use the time zone columns to convert dep_time_f and arr_time_f to UTC and call them dep_time_f_utc and arr_time_f_utc.
 * 	   Calculate the difference of both columns and call it flight_duration_f_utc.
 *     Please provide the query below.
 */
-- long solution using one subquery
SELECT flight_date,
       origin,
       dest,
       origin_tz,
       dest_tz,
       dep_time,
       arr_time,
       dep_time_f,
       arr_time_f,
       dep_time_f - origin_tz AS dep_time_f_utc,
       arr_time_f - dest_tz AS arr_time_f_utc,
       actual_elapsed_time,
       actual_elapsed_time_f,
       flight_duration_f,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
FROM (
      SELECT flight_date,
             origin,
             dest,
             MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
             MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
             dep_time,
             arr_time,
             MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
             actual_elapsed_time,
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS flight_duration_f
      FROM flights f
      LEFT JOIN airports AS a
	         ON f.origin=a.faa
	  LEFT JOIN airports AS a2
	         ON f.dest=a2.faa
	 ) AS f;

-- short solution using one subquery
SELECT dep_time_f - origin_tz AS dep_time_f_utc,
       arr_time_f - dest_tz AS arr_time_f_utc,
       actual_elapsed_time_f,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
FROM (
      SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
             MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
             MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
             MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
      FROM flights f
      LEFT JOIN airports AS a
	         ON f.origin=a.faa
	  LEFT JOIN airports AS a2
	         ON f.dest=a2.faa
	 ) AS f;

-- short solution without using a subquery (low readability)
SELECT MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) - MAKE_INTERVAL(hours => a.tz::INT) AS dep_time_f_utc,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_INTERVAL(hours => a2.tz::INT) AS arr_time_f_utc,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       (MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_INTERVAL(hours => a2.tz::INT)) - (MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) - MAKE_INTERVAL(hours => a.tz::INT)) AS flight_duration_f_utc
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa;

/* 6.3 Again, calculate the percentage of matching records using the new flight_duration_f_utc column.
 *     Try to round the result to two decimals.
 *     Explain the increase in matching records.
 *     Please provide the query and answer below.
 */
-- long solution using two subqueries
SELECT ROUND((SUM((actual_elapsed_time_f = flight_duration_f_utc)::INT) * 1.0 / COUNT(*) * 100),2) AS match_percent  
FROM (
	  SELECT flight_date,
	         origin,
	         dest,
	         origin_tz,
	         dest_tz,
	         dep_time,
	         arr_time,
	         dep_time_f,
	         arr_time_f,
	         dep_time_f - origin_tz AS dep_time_f_utc,
	         arr_time_f - dest_tz AS arr_time_f_utc,
	         actual_elapsed_time,
	         actual_elapsed_time_f,
	         flight_duration_f,
	         (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
	  FROM (
	        SELECT flight_date,
	               origin,
	               dest,
	               MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
	               MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
	               dep_time,
	               arr_time,
	               MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
	               MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
	               actual_elapsed_time,
	               MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
	               MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS flight_duration_f
	        FROM flights f
	        LEFT JOIN airports AS a
	               ON f.origin=a.faa
	        LEFT JOIN airports AS a2
	               ON f.dest=a2.faa
		   ) AS f
	 ) AS ff;

-- short solution using two subqeries
SELECT ROUND((SUM((actual_elapsed_time_f = flight_duration_f_utc)::INT) * 1.0/COUNT(*) * 100),2) AS match_percent  
FROM (
	  SELECT actual_elapsed_time_f,
	         (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
	  FROM (
	        SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
	               MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
	               MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
	               MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
	               MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
	        FROM flights f
	        LEFT JOIN airports AS a
	               ON f.origin=a.faa
	        LEFT JOIN airports AS a2
	               ON f.dest=a2.faa
	       ) AS f
	 ) AS ff;

-- short solution using one subquery (low readability)
SELECT ROUND((SUM((actual_elapsed_time_f = flight_duration_f_utc)::INT) * 1.0/COUNT(*) * 100),2) AS match_percent
FROM (
      SELECT MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
             (MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_INTERVAL(hours => a2.tz::INT)) - (MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) - MAKE_INTERVAL(hours => a.tz::INT)) AS flight_duration_f_utc
      FROM flights f
      LEFT JOIN airports AS a
             ON f.origin=a.faa
      LEFT JOIN airports AS a2
	         ON f.dest=a2.faa
	 ) AS f;

-- short solution without using a subquery (low readability)
SELECT ROUND((SUM((MAKE_INTERVAL(mins => actual_elapsed_time::INT) = 
                   (MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_INTERVAL(hours => a2.tz::INT)) - 
                   (MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) - MAKE_INTERVAL(hours => a.tz::INT))
                  )::INT
                 ) * 1.0/COUNT(*) * 100
             )
            ,2) AS match_percent
FROM flights f
LEFT JOIN airports AS a
       ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa;

/* Bonus Challenge
 *
 * 7.1 We managed to increase the rate of matching records to >80%, but it's still not at 100%.
 *     Could overnight flights be an issue?
 *     What is special about values in the flight_duration_f_utc column for overnight flights?
 *     Please provide the answer below.
 */

-- Answer: The flight_duration_f_utc is negative for overnight flights
SELECT dep_time_f - origin_tz AS dep_time_f_utc,
	   arr_time_f - dest_tz AS arr_time_f_utc,
	   actual_elapsed_time_f,
	   (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
FROM (
	  SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
	         MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
	         MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
	         MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
	         MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
	  FROM flights f
	  LEFT JOIN airports AS a
	         ON f.origin=a.faa
	  LEFT JOIN airports AS a2
	         ON f.dest=a2.faa
	 ) AS f
ORDER BY flight_duration_f_utc;

/* 7.2 Calculate the total number of flights that arrived after midnight UTC.
 *     Please provide the query below.
 */
-- solution using two subqueries
SELECT COUNT(*)
FROM (
      SELECT (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
      FROM (
            SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
                   MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
                   MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
                   MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f
            FROM flights f
            LEFT JOIN airports AS a
                   ON f.origin=a.faa
            LEFT JOIN airports AS a2
                   ON f.dest=a2.faa
	       ) AS f
	  ) AS ff
WHERE flight_duration_f_utc < INTERVAL '0';

-- solution using one subquery
SELECT COUNT(*)
FROM (
      SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
             MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
             MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
             MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f
      FROM flights f
      LEFT JOIN airports AS a
             ON f.origin=a.faa
      LEFT JOIN airports AS a2
             ON f.dest=a2.faa
	 ) AS f
WHERE ((arr_time_f - dest_tz) - (dep_time_f - origin_tz)) < INTERVAL '0';

/* 7.3 Use your knowledge from 7.1 and 7.2 to increase the rate of matching records even further.
 *     Please provide the query below.
 */
-- solution using three subqueries
SELECT ROUND((SUM((actual_elapsed_time_f = flight_duration_f_utc)::INT) * 1.0/COUNT(*) * 100),2) AS match_percent
FROM (
	  SELECT CASE WHEN flight_duration_f_utc < INTERVAL '0'
                  THEN flight_duration_f_utc + INTERVAL '24 hours'
                  ELSE flight_duration_f_utc
             END AS flight_duration_f_utc,
             actual_elapsed_time_f
      FROM (
            SELECT actual_elapsed_time_f,
                   (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS flight_duration_f_utc
	        FROM (
	              SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
	                     MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
	                     MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
	                     MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
	                     MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
	              FROM flights f
	              LEFT JOIN airports AS a
	                     ON f.origin=a.faa
	              LEFT JOIN airports AS a2
	                     ON f.dest=a2.faa
	             ) AS f
	       ) AS ff
     ) AS fff;

-- solution using two subqueries
SELECT ROUND((SUM((actual_elapsed_time_f = flight_duration_f_utc)::INT) * 1.0/COUNT(*) * 100),2) AS match_percent
FROM (
	  SELECT CASE WHEN (arr_time_f - dest_tz) - (dep_time_f - origin_tz) < INTERVAL '0'
                  THEN (arr_time_f - dest_tz) - (dep_time_f - origin_tz) + INTERVAL '24 hours'
                  ELSE (arr_time_f - dest_tz) - (dep_time_f - origin_tz)
             END AS flight_duration_f_utc,
             actual_elapsed_time_f
      FROM (
	        SELECT MAKE_INTERVAL(hours => a.tz::INT) AS origin_tz,
	               MAKE_INTERVAL(hours => a2.tz::INT) AS dest_tz,
	               MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
	               MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
	               MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
	        FROM flights f
	        LEFT JOIN airports AS a
	               ON f.origin=a.faa
	        LEFT JOIN airports AS a2
	               ON f.dest=a2.faa
	       ) AS f
	 ) AS ff;