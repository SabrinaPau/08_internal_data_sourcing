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

SELECT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP); -- this step is just for your understanding
SELECT TO_TIMESTAMP(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP));

/* 4. Retrieve the day from the current timestamp in a single query.
 *    Please provide the query below.
 */

SELECT DATE_PART('day', (SELECT CURRENT_TIMESTAMP)) AS extract_day;

/* 5. Retrieve the current timestamp value 24 hours before.
 *    Please provide the query below.
 */

SELECT (SELECT CURRENT_TIMESTAMP) - INTERVAL '24 hours'  AS day_before;
