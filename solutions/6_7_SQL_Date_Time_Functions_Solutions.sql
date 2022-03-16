/* Date/Time Functions
 * In this file you will find Date/Time functions that are already hard coded into postgreSQL.
 * Make sure to understand what each function takes as input, what happens to the input and what output is returned.
 * Syntax: function(input type) -> return type: definition
 * dp = double precision
 * More info about Date/Time functions: https://www.postgresql.org/docs/current/functions-datetime.html
 */

/* Current Date/Time
 * PostgreSQL provides a number of functions that all return values based on the start time of the current transaction.
 * This means, that during the transaction, their values do not change.
 * 1. CURRENT_DATE -> date: Current date
 * 2. CURRENT_TIME -> time with time zone: Current time of day
 * 3. CURRENT_TIMESTAMP -> timestamp with time zone: Current date and time (start of current transaction)
 * 4. LOCALTIME -> time without time zone: Current time of day
 * 5. LOCALTIMESTAMP -> timestamp without time zone: Current date and time (start of current transaction);
 */

SELECT CURRENT_DATE AS curr_date_without_zone;
SELECT CURRENT_TIME AS curr_time_with_zone;
SELECT CURRENT_TIMESTAMP AS curr_timestamp_with_zone;

SELECT LOCALTIME AS local_time_no_zone;
SELECT LOCALTIMESTAMP AS local_time_no_zone;
 
/* PostgreSQL also provides functions that return the start time of the current statement, 
 * as well as the actual current time at the instant the function is called.
 * 6. TRANSACTION_TIMESTAMP() -> timestamp with time zone: Current date and time 
 * (start of current transaction) - equivalent to CURRENT_TIMESTAMP
 * 7. STATEMENT_TIMESTAMP() -> timestamp with time zone: Current date and time (start of current statement);
 * 8. CLOCK_TIMESTAMP() -> timestamp with time zone: Current date and time (changes during statement execution);
 * 9. TIMEOFDAY() -> text: Current date and time (like clock_timestamp, but as a text string)
 * 10. NOW() -> timestamp with time zone: Current date and time (start of current transaction) 
 * - equivalent to transaction_timestamp()
 */

SELECT TRANSACTION_TIMESTAMP() AS transaction_timestamp_with_zone;
SELECT STATEMENT_TIMESTAMP() AS statement_timestamp_with_zone;
SELECT CLOCK_TIMESTAMP() AS clock;
SELECT TIMEOFDAY() AS current_date_time_string;
SELECT NOW() AS current_date_time_with_zone;

/* Date/Time creation
 * 1. make_date(year int, month int, day int) -> date: Create date from year, month and day fields
 * 2. make_interval(years int DEFAULT 0, months int DEFAULT 0, weeks int DEFAULT 0, days int DEFAULT 0, 
 * hours int DEFAULT 0, mins int DEFAULT 0, secs double precision DEFAULT 0.0) -> interval: Create interval 
 * from years, months, weeks, days, hours, minutes and seconds fields
 * 3. make_time(hour int, min int, sec double precision) -> time: Create time from hour, minute and seconds fields
 * 4. make_timestamp(year int, month int, day int, hour int, min int, sec double precision) -> 
 * timestamp: Create timestamp from year, month, day, hour, minute and seconds fields
 * 5. make_timestamptz(year int, month int, day int, hour int, min int, sec double precision, 
 * [ timezone text ]) -> timestamp with time zone: Create timestamp with time zone from year, month, day, hour, 
 * minute and seconds fields; if timezone is not specified, the current time zone is used
 * 6. to_timestamp(double precision) -> timestamp with time zone: Convert Unix epoch 
 * (seconds since 1970-01-01 00:00:00+00) to timestamp
 */

SELECT MAKE_DATE(2021, 1, 1) AS new_date;

SELECT MAKE_INTERVAL(years => 10) AS ten_years_interval;
SELECT MAKE_INTERVAL(months => 10) AS ten_months_interval;
SELECT MAKE_INTERVAL(weeks => 10) AS ten_weeks_interval;
SELECT MAKE_INTERVAL(days => 10) AS ten_days_interval;
SELECT MAKE_INTERVAL(hours => 10) AS ten_hours_interval;
SELECT MAKE_INTERVAL(mins => 10) AS ten_minutes_interval;
SELECT MAKE_INTERVAL(secs => 10) AS ten_seconds_interval;

SELECT MAKE_TIME(10, 30, 0) AS ten_thirty;

SELECT MAKE_TIMESTAMP(2021, 1, 1, 10, 30, 0) AS new_timestamp;
SELECT MAKE_TIMESTAMPTZ(2021, 1, 1, 10, 30, 0) AS new_timestamp;

SELECT TO_TIMESTAMP(1609497000) AS from_unix_to_timestamp;

/* Date/Time extraction
 * 1. a) extract(field from timestamp) -> double precision: Get subfield
 * 	  b) extract(field from interval) -> double precision: Get subfield
 * 2. a) date_part(text, timestamp) -> double precision: Get subfield (equivalent to extract)
 *    b) date_part(text, interval) -> double precision: Get subfield (equivalent to extract)
 * A full list of accepted values for field/text can be found here: 
 * https://www.postgresql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-EXTRACT
 * Both functions are the same. The extract function complies with SQL standard, 
 * while date_part is as Postgres specific function.
 */

SELECT EXTRACT(DAY FROM TIMESTAMP '2021-01-01 10:30:00') AS extract_day;
SELECT EXTRACT(WEEK FROM TIMESTAMP '2021-01-01 10:30:00') AS extract_week;
SELECT EXTRACT(YEAR FROM TIMESTAMP '2021-01-01 10:30:00') AS extract_year;
SELECT EXTRACT(ISOYEAR FROM TIMESTAMP '2021-01-01 10:30:00') AS extract_isoyear;
SELECT EXTRACT(EPOCH FROM MAKE_TIMESTAMP(2021, 1, 1, 10, 30, 0)) AS from_timestamp_to_unix; -- Use this to convert to UNIX time

SELECT DATE_PART('day', TIMESTAMP '2021-01-01 10:30:00') AS extract_day;
SELECT DATE_PART('week', TIMESTAMP '2021-01-01 10:30:00') AS extract_week;
SELECT DATE_PART('year', TIMESTAMP '2021-01-01 10:30:00') AS extract_year;
SELECT DATE_PART('isoyear', TIMESTAMP '2021-01-01 10:30:00') AS extract_isoyear;

/* Date/Time truncation
 * a) date_trunc(text, timestamp) -> timestamp: Truncate to specified precision
 * b) date_trunc(text, timestamp with time zone, text) -> timestamp with time zone: 
 * Truncate to specified precision in the specified time zone
 * c) date_trunc(text, interval) -> interval: Truncate to specified precision
 * A full list of accepted values for text can be found here: 
 * https://www.postgresql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-TRUNC
 */

SELECT DATE_TRUNC('millennium', TIMESTAMP '2021-06-27 10:30:00') AS trunc_millennium;
SELECT DATE_TRUNC('decade', TIMESTAMP '2021-06-27 10:30:00') AS trunc_decade;
SELECT DATE_TRUNC('quarter', TIMESTAMP '2021-06-27 10:30:00') AS trunc_quarter;
SELECT DATE_TRUNC('week', TIMESTAMP '2021-06-27 10:30:00') AS trunc_week;
SELECT DATE_TRUNC('hour', TIMESTAMP '2021-06-27 10:30:00') AS trunc_hour;

/* Date/Time arithmetic operations
 * 1. date + integer -> date: Add a number of days to a date
 * 2. date + interval -> timestamp: Add an interval to a date
 * 3. date + time -> timestamp: Add a time-of-day to a date
 * 4. interval + interval -> interval: Add intervals
 * 5. timestamp + interval -> timestamp: Add an interval to a timestamp
 * 6. time + interval -> time: Add an interval to a time
 * 7. - interval -> interval: Negate an interval
 * 8. date - date -> integer: Subtract dates, producing the number of days elapsed
 * 9. date - integer -> date: Subtract a number of days from a date
 * 10. date - interval -> timestamp: Subtract an interval from a date
 * 11. time - time -> interval: Subtract times
 * 12. time - interval -> time: Subtract an interval from a time
 * 13. timestamp - interval -> timestamp: Subtract an interval from a timestamp
 * 14. interval - interval -> interval: Subtract intervals
 * 15. timestamp - timestamp -> interval: Subtract timestamps (converting 24-hour intervals into days
 * 16. interval * double precision -> interval: Multiply an interval by a scalar
 * 17. interval / double precision -> interval: Divide an interval by a scalar
 */

SELECT DATE '2021-01-01' + 7 AS add_days_to_date;
SELECT DATE '2021-01-01' + INTERVAL '7 hour' AS add_interval_to_date;
SELECT DATE '2021-01-01' + TIME '07:00' AS add_time_to_date;
SELECT INTERVAL '7 day' + INTERVAL '7 hour' AS add_intervals;
SELECT TIMESTAMP '2021-01-01 07:00' + INTERVAL '7 hour' AS add_interval_to_timestamp;
SELECT TIME '07:00' + INTERVAL '77 hour' AS add_interval_to_time;
SELECT - INTERVAL '7 hour' AS negative_interval;
SELECT DATE '2021-01-01' - DATE '2020-12-25' AS substract_dates;
SELECT DATE '2021-01-01' - 7 AS substract_integer;
SELECT DATE '2021-01-01' - INTERVAL '7 hour' AS substract_interval_from_date;
SELECT TIME '07:00' - TIME '07:00' AS substract_times;
SELECT TIME '07:00' - INTERVAL '7 minute' AS substract_interval_from_time;
SELECT TIMESTAMP '2021-01-01 07:00' - INTERVAL '7 hour' AS subtract_interval_from_timestamp;
SELECT INTERVAL '7 day 7 hour' - INTERVAL '7 hour' AS substract_intervals;
SELECT TIMESTAMP '2021-01-31 07:00' - TIMESTAMP '2021-01-01 07:00' AS subtract_timestamp_from_timestamp;
SELECT INTERVAL '7 second' * 130 AS multiply_interval_by_scalar;
SELECT INTERVAL '7 hour' / 60 AS divide_interval_by_scalar;

/* Date/Time overlap
 * a) (start1, end1) OVERLAPS (start2, end2) -> bool: This expression yields true 
 * when two time periods (defined by their endpoints) overlap, false when they do not overlap.
 * b) (start1, length1) OVERLAPS (start2, length2) -> bool: This expression yields true 
 * when two time periods (defined by their endpoints) overlap, false when they do not overlap.
 */

SELECT (DATE '2021-01-01', DATE '2021-01-31') OVERLAPS
       (DATE '2021-01-15', DATE '2021-02-15');
SELECT (DATE '2021-01-01', DATE '2021-01-31') OVERLAPS
       (DATE '2021-02-01', DATE '2021-02-28');

/* Exercises
 * Now it's time to put what you've learned into practice.
 * The following exercises need to be solved using the flights and airports table from the PostgreSQL database 
 * you've already worked with.
 * Challenge your understanding and try to come up with the correct solution.
 *
 *
 * 1. What's the current timestamp?
 *    Please provide the query below.
 */
    
SELECT CURRENT_TIMESTAMP;

/* 2. Return the current timestamp and truncate it to the current day.
 *    Please provide the query below.
 */   

SELECT DATE_TRUNC('day', CURRENT_TIMESTAMP);

/* 3. Convert the current timestamp to UNIX format and back in a single query.
 *    Please provide the query below.
 */      

SELECT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP);
SELECT TO_TIMESTAMP(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP));

/*  
 * 4 As a Data Analyst, it is crucial to be able to make sure that you can rely on the quality of your data.
 *   In the actual_elapsed_time column you have data with the calculated time from departure to arrival. 
 *   But are you really sure that you can rely on its quality in order to do business recommendations?  
 *   Since we have the data on departure and arrival time, we can do our own calculations and compare the results.
 */

/*  
 * 4.1 But first, let's take a closer look at the data and get an overall view.
 * 	   Since computational power comes at some costs and is shared by many people inside a company,
 *     retrieve only that much data you really need. So, let's take a look at the first 100 rows of the flights table.
 * 	   Please provide the query below.
 */

SELECT * 
FROM flights_all fa 
LIMIT 100;

/*  
 * 4.2 And now, let's take a closer look at some particular relevant columns and make sure we fully understand these values.
 * 	   What do the values in arr_time, dep_time really and actual_elapsed_time mean?
 * 	   Retrieve all unique values from these columns(in three queries) and order them in an descending order.
 *     Remember, retrieve as much data you need - not more and not less.
 * 	   Please provide the query below.
 */

SELECT DISTINCT arr_time
FROM flights_all fa
ORDER BY 1 DESC;

SELECT DISTINCT dep_time
FROM flights_all fa
ORDER BY 1 DESC;

SELECT DISTINCT actual_elapsed_time 
FROM flights_all fa
ORDER BY 1 DESC;

/*  
 * 4.3 What do the values in these three columns mean?
 *     Please provide the answer below.    
 */

-- arr_time: interval value e.g. 12.34 ==> 12:34:00
-- dep_time: interval value e.g. 12.34 ==> 12:34:00
-- actual_elapsed_time: amount of minutes e.g. 125 ==> 2 hours and 5 minutes

/*  
 * 5   Finally. Let's start with the actual task. In the next steps, you are going to calculate the flight time 
 *     and match it with the actual_elapsed_time column values.
 * 	   ==> The main objective is to get as close as possible to a match rate of 100%.
 */

 /*
 * 5.1 Query the following columns from the flights table: flight_date, origin, dest, dep_time, arr_time and air_time.
 *     Convert dep_time, arr_time into TIME variables: dep_time_f and arr_time_f 
 *     Convert air_time into an INTERVAL variable: air_time_f
 *     Calculate the difference of dep_time_f and arr_time_f in a new column called travel_time_f.
 *     Please provide the query below.
 */

SELECT flight_date,
	   origin,
	   dest,
	   dep_time,
	   MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       arr_time,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time::INT) AS air_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS travel_time_f
FROM flights AS f;

/* 5.2 Compare the travel time with the air_time column.
 * 	   How many values are matching? Provide the number in percentage.
 *     Please provide the query and answer below.
 */

SELECT ROUND((SUM((actual_elapsed_time_f=travel_time_f)::INT) * 1.0/COUNT(*) * 100),2) AS match_percent
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS travel_time_f
FROM flights_all AS f) f;
==> 49.44%;

/* 5.3 Try to explain the results of 5.2.
 *     Please provide the answer below.
 */

-- Time zone differences
-- air_time is more granular and only looks at liftoff and landing but not moving to lane etc.
-- Bad data quality

/* 5.4 Join the airports table and add the time zone columns to your existing table.
 * 	   Before you add them, transform them to INTERVAL and change their names to origin_tz and dest_tz.
 *     Please provide the query below.
 */

SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       actual_elapsed_time,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS travel_time_f
FROM flights_all fa
LEFT JOIN airports AS a
	   ON fa.origin=a.faa
LEFT JOIN airports AS a2
	   ON fa.dest=a2.faa;
	  
/* 5.5 Next, convert the departure and arrival time to UTC and store them in dep_time_f_utc and arr_time_f_utc.
 * 	   Calculate the difference of the new columns and store it in a new column travel_time_f_utc.
 *     Please provide the query below.
 */
	  
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
       travel_time_f,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS travel_time_f_utc
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       actual_elapsed_time,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS travel_time_f
FROM flights_all fa
LEFT JOIN airports AS a
	   ON fa.origin=a.faa
LEFT JOIN airports AS a2
	   ON fa.dest=a2.faa) f;

/* 5.6 What's the percentage of matching records now?
 *     Explain the result.
 *     Please provide the query and answer below.
 */
	    
SELECT ROUND((SUM((actual_elapsed_time_f=travel_time_f_utc)::INT) * 1.0/COUNT(*) * 100),2) AS match_percent 
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
       travel_time_f,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS travel_time_f_utc
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       actual_elapsed_time,
       MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS travel_time_f
FROM flights_all fa
LEFT JOIN airports AS a
	   ON fa.origin=a.faa
LEFT JOIN airports AS a2
	   ON fa.dest=a2.faa) f) ff;
	  
====> 83.76%;

-- we got the new matches due to the harmonization of time values with different timezones
	  
/* Extra Credit: 5.7 Until now, we achieved a match rate of nearly 84%
 * 					 1. Do you have any ideas how to increase the match rate any further?
 *  				 2. Create a query and confirm your ideas.  
 */
	  
/* Extra Credit: 6 Add two columns to your table
 * 				 dep_timestamp_utc: a timestamp that shows the date and time of the departure in UTC time zone
 *     			 arr_timestamp_utc: a timestamp that shows the date and time of the arrival in UTC time zone
 *     			 How many flights arrived after midnight UTC?
 *     			 Please provide the query and answer below.
 */

SELECT COUNT(*)
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
       dep_time_f_utc,
       arr_time_f_utc,
       MAKE_TIMESTAMP(DATE_PART('year', flight_date)::INT,
					  DATE_PART('month', flight_date)::INT,
					  DATE_PART('day', flight_date)::INT,
					  DATE_PART('hour', dep_time_f_utc)::INT,
					  DATE_PART('minute', dep_time_f_utc)::INT,
					  0) AS dep_timestamp_utc,
	   MAKE_TIMESTAMP(DATE_PART('year', flight_date)::INT,
					  DATE_PART('month', flight_date)::INT,
					  CASE WHEN travel_time_f_utc < INTERVAL '0'
					  	   THEN DATE_PART('day', flight_date + INTERVAL '1 day')::INT
					  	   ELSE DATE_PART('day', flight_date)::INT
					  END,
					  DATE_PART('hour', arr_time_f_utc)::INT,
					  DATE_PART('minute', arr_time_f_utc)::INT,
					  0) AS arr_timestamp_utc,
	   air_time,
	   air_time_f
       travel_time_f,
       travel_time_f_utc
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
       air_time,
       air_time_f,
       travel_time_f,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS travel_time_f_utc
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time::INT) AS air_time_f,
       MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS travel_time_f
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa) f) ff) fff
WHERE DATE_PART('day', arr_timestamp_utc) > DATE_PART('day', dep_timestamp_utc);

==> 52596;
