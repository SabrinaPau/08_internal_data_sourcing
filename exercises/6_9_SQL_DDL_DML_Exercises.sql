/* Exercises
 * IMPORTANT! When creating a new table add '_group' + group number at the end of the name. Example: _group1
 */

-- 1 Create an exact copy of the airports table (= same structure and same number of rows).

CREATE TABLE airports_group_4 AS
	SELECT *
	FROM airports;

SELECT *
FROM flights f
LIMIT 20;

/* 2.1 Remember when we used a specific type of join and found out that we have flights in our flights table,
 *     but no matching airport in the airports table?
 * 	   Find out which airports are missing.
 */
SELECT count(*)
FROM airports_group_4 a4
-- 6072
SELECT count(DISTINCT origin)
FROM flights f;
-- 357

SELECT origin AS missing_airports_informations
FROM flights f
UNION			-- FROM the counts it seems NOT TO be necessary, but TO be sure..
SELECT dest
FROM flights f
EXCEPT			-- TO find the airports IN the airports_table that have NO DATA IN there but ONLY IN the flights_table
SELECT faa
FROM airports_group_4 a4;

-- 2.2 Append new rows to the airports table that include all information about the missing airports.

INSERT INTO airports_group_4 (faa)
	SELECT missing_airports_informations
	FROM (SELECT origin AS missing_airports_informations
			FROM flights f
			UNION
			SELECT dest
			FROM flights f
			EXCEPT
			SELECT faa
			FROM airports_group_4 a4
			) AS missing_codes;

SELECT count(*)
FROM airports_group_4 ag;
--6074

SELECT *
FROM airports_group_4 ag 
WHERE name IS NULL;

-- 3.1 Create an exact copy of the flights table (= same structure and same number of rows).

CREATE TABLE flights_group_4 AS
	SELECT *
	FROM flights;

SELECT *
FROM flights_group_4;

-- 3.2 In your copy, combine flight_date and dep_time to create a new column dep_timestamp_local.

ALTER TABLE flights_group_4 
ADD COLUMN IF NOT EXISTS dep_timestamp_local TIMESTAMP;


UPDATE flights_group_4 
SET dep_timestamp_local = flight_date + MAKE_TIME((dep_time::INT / 100), (dep_time::INT % 100), 0);


-- 3.3 In your copy, combine flight_date and arr_time to create a new column arr_timestamp_local.

ALTER TABLE flights_group_4 
ADD COLUMN IF NOT EXISTS arr_timestamp_local TIMESTAMP;

UPDATE flights_group_4 
SET arr_timestamp_local = flight_date + MAKE_TIME((arr_time::INT / 100), (arr_time::INT % 100), 0);

-- 3.4 In your copy, convert dep_delay to interval and replace the existing column.

ALTER TABLE flights_group_4 
ALTER COLUMN dep_delay TYPE INTERVAL USING dep_delay * INTERVAL '1 minute'

-- 3.5 In your copy, convert arr_delay to interval and replace the existing column.

ALTER TABLE flights_group6
ALTER COLUMN arr_delay TYPE INTERVAL USING arr_delay * INTERVAL '1 minute';

-- 3.6 In your copy, convert air_time to interval and replace the existing column.

ALTER TABLE flights_group6
ALTER COLUMN air_time TYPE INTERVAL USING air_time * INTERVAL '1 minute';

-- 3.7 In your copy, add a new column 'compensation' which is 1 if the flight was cancelled or diverted and 0 otherwise.

ALTER TABLE flights_group_4 
ADD COLUMN IF NOT EXISTS compensation INT;

UPDATE flights_group_4 
SET compensation = CASE WHEN cancelled = 1 OR
							diverted = 1
							THEN 1
							ELSE 0
						END;

-- check if the code is correct
SELECT cancelled, diverted, compensation
FROM flights_group_4 fg 
WHERE cancelled != compensation AND diverted != compensation;

/* 4 Write the code that would delete your copies of the airports and flights table below. 
 *   Run it AFTER we have discussed the results in class.
 */

DROP TABLE IF EXISTS airports_group_4,
					 flights_group_4;