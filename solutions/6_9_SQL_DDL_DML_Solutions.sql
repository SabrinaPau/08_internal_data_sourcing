/* Exercises
 * IMPORTANT! When creating a new table add '_group' + group number at the end of the name. Example: _group1
 */

-- 1 Create an exact copy of the airports table (= same structure and same number of rows).
CREATE TABLE IF NOT EXISTS airports_copy AS
TABLE airports;

/* 2.1 Remember when we used a specific type of join and found out that we have flights in our flights table,
 *     but no matching airport in the airports table?
 * 	   Find out which airports are missing.
 */
SELECT DISTINCT dest AS destination_airport
FROM flights
WHERE dest NOT IN (SELECT faa
			       FROM airports);
'XWA';
'EAR';

-- 2.2 Append new rows to the airports table that include all information about the missing airports.
INSERT INTO airports_copy VALUES
	('XWA', 'Williston Basin International Airport', 48.258387, -103.748797, 2353, -5, 'A', 'Williston', 'United States'),
	('EAR', 'Kearney Regional Airport', 40.72700119, -99.00679779, 2131, -5, 'A', 'Kearney', 'United States');

-- 3.1 Create an exact copy of the flights table (= same structure and same number of rows).
CREATE TABLE IF NOT EXISTS flights_copy AS
TABLE flights;

-- 3.2 In your copy, combine flight_date and dep_time to create a new column of datatype TIMESTAMP and call it dep_timestamp_local.
ALTER TABLE flights_copy
ADD COLUMN IF NOT EXISTS dep_timestamp_local TIMESTAMP;

UPDATE flights_copy 
SET dep_timestamp_local = MAKE_TIMESTAMP(DATE_PART('year', flight_date)::INT,
					 					 DATE_PART('month', flight_date)::INT,
					 					 DATE_PART('day', flight_date)::INT,
					 					 DATE_PART('hour', MAKE_TIME((dep_time::INT / 100)::INT, (dep_time::INT % 100)::INT, 0))::INT,
					 					 DATE_PART('minute', MAKE_TIME((dep_time::INT / 100)::INT, (dep_time::INT % 100)::INT, 0))::INT,
					 					 0);

-- 3.3 In your copy, combine flight_date and arr_time to create a new column of datatype TIMESTAMP and call it arr_timestamp_local.
ALTER TABLE flights_copy
ADD COLUMN IF NOT EXISTS arr_timestamp_local TIMESTAMP;

UPDATE flights_copy 
SET arr_timestamp_local = MAKE_TIMESTAMP(DATE_PART('year', flight_date)::INT,
					 					 DATE_PART('month', flight_date)::INT,
					 					 DATE_PART('day', flight_date)::INT,
					 					 DATE_PART('hour', MAKE_TIME((arr_time::INT / 100)::INT, (arr_time::INT % 100)::INT, 0))::INT,
					 					 DATE_PART('minute', MAKE_TIME((arr_time::INT / 100)::INT, (arr_time::INT % 100)::INT, 0))::INT,
					 					 0);

-- 3.4 In your copy, convert dep_delay to interval and replace the existing column.			 										 					
ALTER TABLE flights_copy
ADD COLUMN IF NOT EXISTS dep_delay_new INTERVAL;

UPDATE flights_copy 
SET dep_delay_new = MAKE_INTERVAL(mins => dep_delay::INT);

ALTER TABLE flights_copy
DROP COLUMN dep_delay;

ALTER TABLE flights_copy
RENAME COLUMN dep_delay_new TO dep_delay;

-- 3.5 In your copy, convert arr_delay to interval and replace the existing column.
ALTER TABLE flights_copy
ADD COLUMN IF NOT EXISTS arr_delay_new INTERVAL;

UPDATE flights_copy 
SET arr_delay_new = MAKE_INTERVAL(mins => arr_delay);

ALTER TABLE flights_copy
DROP COLUMN arr_delay;

ALTER TABLE flights_copy
RENAME COLUMN arr_delay_new TO arr_delay;

-- 3.6 In your copy, convert air_time to interval and replace the existing column.
-- Alternative way to do it in one statement

ALTER TABLE flights_copy
ALTER COLUMN air_time SET DATA TYPE interval
USING MAKE_INTERVAL(mins => air_time::INT);	
-- https://www.postgresql.org/docs/14/sql-altertable.html

-- 3.7 In your copy, add a new column 'compensation' which is 1 if the flight was cancelled or diverted and 0 otherwise.
ALTER TABLE flights_copy
ADD COLUMN IF NOT EXISTS compensation INT;

UPDATE flights_copy 
SET compensation = CASE WHEN cancelled = 1 OR diverted = 1
					    THEN 1
					    ELSE 0
				   END;
				  
/* 4 Write the code that would delete your copies of the airports and flights table below. 
 *   Run it AFTER we have discussed the results in class.
 */
DROP TABLE IF EXISTS airports_copy,
					 flights_copy;
