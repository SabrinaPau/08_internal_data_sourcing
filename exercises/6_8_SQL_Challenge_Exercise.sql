/*   As a Data Analyst, it is crucial that you can rely on the quality of your data at all times.
 *   The data in the actual_elapsed_time column in the flights table seems to be about the time from departure to arrival.
 *   Currently, this is only an assumption. Based on this assumption, do you feel confident in using this column in your 
 *   analysis and giving out business recommendations?
 *   If your answer is no, you're on a good path to becoming an analyst.
 *
 * 1 Using the data in the remaining columns in the flights table, can you think of a way to verify our assumption?
 *   Please provide the answer below.
 */
SELECT dep_time, arr_time, actual_elapsed_time,
		(arr_time - dep_time) AS true_elapsed_time
FROM flights f 
-- it's not the same!

/*   Don't worry if you couldn't figure this one out. To verify our assumption, we can calculate the difference between 
 *   departure and arrival time and compare the result to the values in the actual_elapsed_time column to check if they're equal.
 */

/* 2.1 The first step is to become familiar with the dep_time, arr_time and actual_elapsed_time columns.
 *     Based on the column names and what you already know from previous exercises about the information that is stored 
 *     in these three columns, what are your assumptions about the data types of the values?
 */
SELECT pg_typeof(dep_time) AS type_dep_time,
		pg_typeof(arr_time) AS type_arr_time,
		pg_typeof(actual_elapsed_time) AS type_actual_elapsed_time
FROM flights f;
-- all 3 are "double precision"

/* 2.2 Retrieve all unique values from these columns in three separate queries and order them in descending order.
 *     Did your assumptions turn out to be correct?
 * 	   Please provide the queries below.
 */
SELECT DISTINCT dep_time
FROM flights f 
ORDER BY 1 DESC;
-- seems to be time without :

SELECT DISTINCT arr_time
FROM flights f 
ORDER BY 1 DESC;
-- seems to be time without :

SELECT DISTINCT actual_elapsed_time
FROM flights f 
ORDER BY 1 DESC;
-- it seems one plane just flew for 16 mins

/* 3.1 Next, calculate the difference of dep_time and arr_time and call it flight_duration.
 * 	   Please provide the query below.
 */
SELECT dep_time, arr_time, actual_elapsed_time,
		(arr_time - dep_time) AS flight_duration
FROM flights f;

/* 3.2 Are the calculated flight duration values correct? If not, what's the problem and how can we solve it?
 *     Please provide the answer below.
 */
--they aren't correct, perhaps it's a UNIX-Code and we have to convert it to some kind of datetime-format

/* 4 In order to calculate correct flight duration values we need to convert dep_time, arr_time and actual_elapsed_time 
 *   into useful data types first.
 *   Change dep_time and arr_time into TIME variables, call them dep_time_f and arr_time_f. (Hint: 100% focus on the remainder)
 *   Change actual_elapsed_time into an INTERVAL variable, call it actual_elapsed_time_f.
 *   Query flight_date, origin, dest, dep_time, dep_time_f, arr_time, arr_time_f, actual_elapsed_time and actual_elapsed_time_f.
 *   Please provide the query below.
 */

--brainstorming:
SELECT dep_time,
		(dep_time::INT / 100) AS hour_part,
		(dep_time::INT % 100) AS minute_part
FROM flights f 

SELECT MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f
FROM flights f;

SELECT MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f
FROM flights f;

SELECT MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
FROM flights f;

----
SELECT	flight_date,
		origin,
		dest,
		dep_time,
		MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
		arr_time,
		MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
		actual_elapsed_time,
		MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f
FROM flights f;

/* 5.1 Querying the raw columns next to the ones we have transformed, makes it a lot easier to compare the result to the input.
 *     This allows for quick prototyping and debugging and helps to understand how functions work. 
 *     To optimize our query in terms of performance and readability, we can always remove unneccessary columns in the end. 
 *     Use the previous query and calculate the difference of arr_time_f and dep_time_f and call it flight_duration_f.
 * 	   Please provide the query below.
 */
SELECT	flight_date,
		origin,
		dest,
		dep_time,
		MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
		arr_time,
		MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
		actual_elapsed_time,
		MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
		(MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0))
			AS flight_duration_f
FROM flights f
WHERE dep_time IS NOT NULL AND cancelled = 0;
-- now actual_elapsed_time_f and flight_duration_f are NEARLY the same (differences because of the time zones?)

/* 5.2 Compare the calculated flight duration values in flight_duration_f with the values in the actual_elapsed_time_f column and 
 * 	   calculate the percentage of values that are equal in both columns.
 * 	   Please provide the query below.
 */

-- counting the number of same durations --- looooooooong version:
SELECT round((count(*)*100.0 / (SELECT count(*) FROM flights)), 2) AS percentage_equal_values
FROM (SELECT	flight_date,
				origin,
				dest,
				dep_time,
				MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
				arr_time,
				MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
				actual_elapsed_time,
				MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
				(MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0))
					AS flight_duration_f
		FROM flights f) AS flights_new
WHERE flights_new.flight_duration_f = flights_new.actual_elapsed_time_f AND dep_time IS NOT NULL; 
-- 178,706 / 361,428 = 0.4944

-- compact version:
SELECT round((count(*)*100.0 / (SELECT count(*) FROM flights)), 2) AS percentage_equal_values
FROM (SELECT	MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
				-- calculating arrival time - departure time
				(MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0))
					AS flight_duration_f
		FROM flights f) AS flights_new
WHERE flights_new.flight_duration_f = flights_new.actual_elapsed_time_f; 
-- 49,44 %

/* 5.3 Given the percentage of matching values, can you come up with possible explanations for why the rate is so low?
 *     Please provide the answer below.
 */
-- 49.44 % => perhaps because of the different time zones

/* 6.1 Differences due to time zones might be one reason for the low rate of matching values.
 *     To make sure the dep_time and arr_time values are all in the same time zone we need to know in which time zone they are.
 *     Take your query from exercise 5.1 and add the time zone values from the airports table.
 * 	   Make sure to transform them to INTERVAL and change their names to origin_tz and dest_tz.
 *     Please provide the query below.
 */
SELECT	flight_date,
		origin,
		dest,
		dep_time,
		MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
		MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE origin = a.faa)) AS origin_tz,
		arr_time,
		MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
		MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE dest = a.faa)) AS dest_tz,
		actual_elapsed_time,
		MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
		(MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0))
			AS flight_duration_f
FROM flights f
WHERE dep_time IS NOT NULL AND cancelled = 0
LIMIT 15;

/* 6.2 Use the time zone columns to convert dep_time_f and arr_time_f to UTC and call them dep_time_f_utc and arr_time_f_utc.
 * 	   Calculate the difference of both columns and call it flight_duration_f_utc.
 *     Please provide the query below.
 */
SELECT	flight_date,
		origin,
		dest,
		dep_time,
		MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0) AS dep_time_f,
		MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE origin = a.faa)) AS origin_tz,
		arr_time,
		MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) AS arr_time_f,
		MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE dest = a.faa)) AS dest_tz,
		actual_elapsed_time,
		MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
		(MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0) - MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0))
			AS flight_duration_f,
		((MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0)) - (MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE dest = a.faa))))
			- ((MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0)) - (MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE origin = a.faa))))
				AS flight_duration_f_utc
FROM flights f
WHERE dep_time IS NOT NULL AND cancelled = 0 AND flight_duration_f_utc IS NOT NULL
ORDER BY flight_duration_f_utc DESC 
LIMIT 15;

/* 6.3 Again, calculate the percentage of matching records using the new flight_duration_f_utc column.
 *     Try to round the result to two decimals.
 *     Explain the increase in matching records.
 *     Please provide the query and answer below.
 */

SELECT round((count(*)*100.0 / (SELECT count(*) FROM flights)), 2) AS percentage_equal_values
--SELECT count(*)  -- 172,971
FROM (SELECT
		MAKE_INTERVAL(mins => actual_elapsed_time::INT) AS actual_elapsed_time_f,
		-- (arr_time - a_tz) - (dep_time - d_tz) = arr_time - dep_time - a_tz + d_tz
		-- (arr_time + d_tz) - (dep_time + a_tz) = arr_time - dep_time - a_tz + d_tz (they did it twice wrong, but accidentally got the right result)
		((MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0)) - (MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE dest = a.faa))))
			- ((MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0)) - (MAKE_INTERVAL(hours => (SELECT tz::INT FROM airports a WHERE origin = a.faa))))
				AS flight_duration_f_utc
		FROM flights f) AS flights_new
WHERE flights_new.flight_duration_f_utc = flights_new.actual_elapsed_time_f;
-- 83,76 %


-------

/* Bonus Challenge
 *
 * 7.1 We managed to increase the rate of matching records to >80%, but it's still not at 100%.
 *     Could overnight flights be an issue?
 *     What is special about values in the flight_duration_f_utc column for overnight flights?
 *     Please provide the answer below.
 */
-- JEPP!! Steve can explain! :)
-- not only overnight flights are a problem, also flights that depart or arrive when its the next day (after midnight) in London (UTZ)

/* 7.2 Calculate the total number of flights that arrived after midnight UTC.
 *     Please provide the query below.
 */
/*
Pseudo-Code:
- calculate the UTZ-time of the arrival by (arr_time - tz) (we did before with the long code)
- when this time is after midnight in London => do something

*/



/* 7.3 Use your knowledge from 7.1 and 7.2 to increase the rate of matching records even further.
 *     Please provide the query below.
 */
