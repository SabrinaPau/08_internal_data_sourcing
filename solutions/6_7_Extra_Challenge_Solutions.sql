/* 
* Try to get as far as you can in this challenge, but don't worry if you can't achieve all objectives.
*/
/*  
 * 1 As a Data Analyst, it is crucial to be able to make sure that you can rely on the quality of your data.
 *   In the actual_elapsed_time column you have data with the calculated time from departure to arrival. 
 *   But are you really sure that you can rely on its quality in order to do business recommendations?  
 *   Since we have the data on departure and arrival time, we can do our own calculations and compare the results.
 */

/*  
 * 1.1 But first, let's take a closer look at the data and get an overall view.
 * 	   Since computational power comes at some costs and is shared by many people inside a company,
 *     retrieve only that much data you really need. So, let's take a look at the first 100 rows of the flights table.
 * 	   Please provide the query below.
 */

SELECT * 
FROM flights_all fa 
LIMIT 100;

/*  
 * 1.2 And now, let's take a closer look at some particular relevant columns and make sure we fully understand these values.
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
 * 1.3 What do the values in these three columns mean?
 *     Please provide the answer below.    
 */

-- arr_time: interval value e.g. 12.34 ==> 12:34:00
-- dep_time: interval value e.g. 12.34 ==> 12:34:00
-- actual_elapsed_time: amount of minutes e.g. 125 ==> 2 hours and 5 minutes

/*  
 * 2   Finally. Let's start with the actual task. In the next steps, you are going to calculate the flight time 
 *     and match it with the actual_elapsed_time column values.
 * 	   ==> The main objective is to get as close as possible to a match rate of 100%.
 */

 /*
 * 2.1 Query the following columns from the flights table: flight_date, origin, dest, dep_time, arr_time and air_time.
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

/* 2.2 Compare the travel time with the air_time column.
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

/* 2.3 Try to explain the results of 5.2.
 *     Please provide the answer below.
 */

-- Time zone differences
-- air_time is more granular and only looks at liftoff and landing but not moving to lane etc.
-- Bad data quality

/* 2.4 Join the airports table and add the time zone columns to your existing table.
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
	  
/* 2.5 Next, convert the departure and arrival time to UTC and store them in dep_time_f_utc and arr_time_f_utc.
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

/* 2.6 What's the percentage of matching records now?
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
	  
/* Extra Credit: 2.7 Until now, we achieved a match rate of nearly 84%
 * 					 1. Do you have any ideas how to increase the match rate any further?
 *  				 2. Create a query and confirm your ideas.  
 */
	  
/* Extra Credit: 3 Add two columns to your table
 * 				   dep_timestamp_utc: a timestamp that shows the date and time of the departure in UTC time zone
 *     			   arr_timestamp_utc: a timestamp that shows the date and time of the arrival in UTC time zone
 *     			   How many flights arrived after midnight UTC?
 *     			   Please provide the query and answer below.
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
