/* Date/Time Functions
 * In this file you will find Date/Time functions that are already hard coded into postgreSQL.
 * Make sure to understand what each function takes as input, what happens to the input and what output is returned.
 * Syntax: function(input type) -> return type: definition
 * dp = double precision
 * More info about Date/Time functions: https://www.postgresql.org/docs/current/functions-datetime.html
 */

/* Current Date/Time
 * PostgreSQL provides a number of functions that all retrun values based on the start time of the current transaction.
 * This means, that during the transaction, their values do not change.
 * 1. CURRENT_DATE -> date: Current date
 * 2. CURRENT_TIME -> time with time zone: Current time of day
 * 3. CURRENT_TIMESTAMP -> timestamp with time zone: Current date and time (start of current transaction)
 * 4. LOCALTIME -> time without time zone: Current time of day
 * 5. LOCALTIMESTAMP -> timestamp without time zone: Current date and time (start of current transaction);
 */
SELECT CURRENT_DATE AS curr_date_with_zone;
SELECT CURRENT_TIME AS curr_time_with_zone;
SELECT CURRENT_TIMESTAMP AS curr_timestamp_with_zone;

SELECT LOCALTIME AS local_time_no_zone;
SELECT LOCALTIMESTAMP AS local_time_no_zone;
 
/* PostgreSQL also provides functions that return the start time of the current statement, as well as the actual current time at the instant the function is called.
 * 6. TRANSACTION_TIMESTAMP() -> timestamp with time zone: Current date and time (start of current transaction) - equivalent to CURRENT_TIMESTAMP
 * 7. STATEMENT_TIMESTAMP() -> timestamp with time zone: Current date and time (start of current statement);
 * 8. CLOCK_TIMESTAMP() -> timestamp with time zone: Current date and time (changes during statement execution);
 * 9. TIMEOFDAY() -> text: Current date and time (like clock_timestamp, but as a text string)
 * 10. NOW() -> timestamp with time zone: Current date and time (start of current transaction) - equivalent to transaction_timestamp()
 */
SELECT TRANSACTION_TIMESTAMP() AS transaction_timestamp_with_zone;
SELECT STATEMENT_TIMESTAMP() AS statement_timestamp_with_zone;
SELECT CLOCK_TIMESTAMP() AS clock;
SELECT TIMEOFDAY() AS current_date_time_string;
SELECT NOW() AS current_date_time_with_zone;


/* Date/Time creation
 * 1. make_date(year int, month int, day int) -> date: Create date from year, month and day fields
 * 2. make_interval(years int DEFAULT 0, months int DEFAULT 0, weeks int DEFAULT 0, days int DEFAULT 0, hours int DEFAULT 0, mins int DEFAULT 0, secs double precision DEFAULT 0.0) -> interval: Create interval from years, months, weeks, days, hours, minutes and seconds fields
 * 3. make_time(hour int, min int, sec double precision) -> time: Create time from hour, minute and seconds fields
 * 4. make_timestamp(year int, month int, day int, hour int, min int, sec double precision) -> timestamp: Create timestamp from year, month, day, hour, minute and seconds fields
 * 5. make_timestamptz(year int, month int, day int, hour int, min int, sec double precision, [ timezone text ]) -> timestamp with time zone: Create timestamp with time zone from year, month, day, hour, minute and seconds fields; if timezone is not specified, the current time zone is used
 * 6. to_timestamp(double precision) -> timestamp with time zone: Convert Unix epoch (seconds since 1970-01-01 00:00:00+00) to timestamp
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
 * A full list of accepted values for field/text can be found here: https://www.postgresql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-EXTRACT
 * Both functions are the same. The extract function complies with SQL standard, while date_part is as Postgres specific function.
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
 * b) date_trunc(text, timestamp with time zone, text) -> timestamp with time zone: Truncate to specified precision in the specified time zone
 * c) date_trunc(text, interval) -> interval: Truncate to specified precision
 * A full list of accepted values for text can be found here: https://www.postgresql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-TRUNC
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
 * a) (start1, end1) OVERLAPS (start2, end2) -> bool: This expression yields true when two time periods (defined by their endpoints) overlap, false when they do not overlap.
 * b) (start1, length1) OVERLAPS (start2, length2) -> bool: This expression yields true when two time periods (defined by their endpoints) overlap, false when they do not overlap.
 */
SELECT (DATE '2021-01-01', DATE '2021-01-31') OVERLAPS
       (DATE '2021-01-15', DATE '2021-02-15');
SELECT (DATE '2021-01-01', DATE '2021-01-31') OVERLAPS
       (DATE '2021-02-01', DATE '2021-02-28');


/* Exercises
 * Now it's time to put what you've learned into practice.
 * The following exercises need to be solved using the flights and airports table from the PostgreSQL database you've already worked with.
 * Challenge your understanding and try to come up with the correct solution.
 *
 * 1. What's the current timestamp?
 * 	  Please provide the query below.
 */
SELECT CURRENT_TIMESTAMP;

/* 2. Return the current timestamp and truncate it to the current day.
 *    Please provide the query below.
 */      
SELECT DATE_TRUNC('day', CURRENT_TIMESTAMP);

/* 3. Return the current timestamp into UNIX format. Then convert it back to timestamp.
 *    Please provide the query below.
 */      
SELECT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP);
SELECT TO_TIMESTAMP(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP));

/*  
 * 4.1 Query the following columns from the flights table: flight_date, origin, dest, dep_time, arr_time and air_time.
 *     Convert dep_time, arr_time into TIME variables: dep_time_f and arr_time_f 
 *     Convert air_time into an INTERVAL variable: air_time_f
 *     I want to know the travel time per flight which is the difference of dep_time_f and arr_time_f. Store the values in a new column called travel_time
 *     Please provide the query below.
 */
SELECT flight_date,
	   origin,
	   dest,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS dep_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time) AS air_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) - MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS travel_time
FROM flights AS f;

/* 4.2 Now we have manually calculated the travel time. But the flights table already has a column called air_time.
 * 	   Are the two columns matching? If not, what's the percentage of matching records?
 *     Please provide the query and answer below.
 */
SELECT (SUM((air_time_f=travel_time)::INT) * 1.0/COUNT(*) * 100)
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS dep_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time) AS air_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) - MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS travel_time
FROM flights AS f) f
;

0.02%;

/* 4.3 Strange, only a very low number of records have matching travel and air times.
 * 	   What could be the reasons for that?
 *     Please provide the answer below.
 */
-- Time zone differences
-- air_time is more granular and only looks at liftoff and landing but not moving to lane etc.
-- Bad data quality


/* 4.4 Let's see if the time zones of the origin and destination airports have anything to do with the differences in travel and air time.
 * 	   Join the airports table and add the time zone columns to your existing table.
 * 	   Before adding them, transform them to INTERVAL and change their names to origin_tz and dest_tz.
 *     Please provide the query below.
 */
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS dep_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time) AS air_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) - MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS travel_time
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa;

/* 4.5 Now that whe have the time zone data, 
 * 	   1. convert the departure and arrival time to UTC and call the two new columns dep_time_f_utc and arr_time_f_utc
 * 	   2. Calculate travel_time_utc using the time zone adjusted values.
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
       air_time,
       air_time_f,
       travel_time,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS travel_time_utc
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS dep_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time) AS air_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) - MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS travel_time
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa) f;

/* 4.6 Now we can compare the adjusted travel time in UTC and the air time values to check whether the time zones were causing the differences.
 * 	   What's the percentage of matching records now?
 *     Please provide the query below and answer below.
 */
SELECT (SUM((air_time_f=travel_time_utc)::INT) * 1.0/COUNT(*) * 100)
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
       travel_time,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS travel_time_utc
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS dep_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time) AS air_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) - MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS travel_time
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa) f) ff;

0%;

/* 4.7 Lastly, please add two columns to your table
 * 	   1. dep_timestamp_utc: this column is a timestamp that shows the date and time of the departure in UTC time zone
 *     2. arr_timestamp_utc: this column is a timestamp that shows the date and time of the arrival in UTC time zone
 *     and answer the following question: How many flights arrived after midnight UTC?
 *     Please provide the query and answer below.
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
					  CASE WHEN travel_time_utc < INTERVAL '0'
					  	   THEN DATE_PART('day', flight_date + INTERVAL '1 day')::INT
					  	   ELSE DATE_PART('day', flight_date)::INT
					  END,
					  DATE_PART('hour', arr_time_f_utc)::INT,
					  DATE_PART('minute', arr_time_f_utc)::INT,
					  0) AS arr_timestamp_utc,
	   air_time,
	   air_time_f
       travel_time,
       travel_time_utc
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
       travel_time,
       (arr_time_f - dest_tz) - (dep_time_f - origin_tz) AS travel_time_utc
FROM (
SELECT flight_date,
	   origin,
	   dest,
	   MAKE_INTERVAL(mins => (a.tz*60)::INT) AS origin_tz,
	   MAKE_INTERVAL(mins => (a2.tz*60)::INT) AS dest_tz,
	   dep_time,
       arr_time,
       MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS dep_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) AS arr_time_f,
       air_time,
       MAKE_INTERVAL(mins => air_time) AS air_time_f,
       MAKE_TIME((arr_time / 100)::INT, (arr_time % 100)::INT, 0) - MAKE_TIME((dep_time / 100)::INT, (dep_time % 100)::INT, 0) AS travel_time
FROM flights f
LEFT JOIN airports AS a
	   ON f.origin=a.faa
LEFT JOIN airports AS a2
	   ON f.dest=a2.faa) f) ff) fff
WHERE DATE_PART('day', arr_timestamp_utc) > DATE_PART('day', dep_timestamp_utc);

76641;
