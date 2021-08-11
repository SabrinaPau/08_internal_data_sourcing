/* PostgreSQL Commands
 * In this file you will find PostgreSQL commands that allow you to create, alter, insert into, update, delete and truncate tables.
 * Make sure to understand what each function takes as input and what output is returned.
 */

/* Create a table
 * IMPORTANT: Before you run the commands below make sure to change the table name to your initials.
 * = public.phi_wen for Philipp Wendt -> public.And_Emm for Andrew Emmet
 * CREATE TABLE: CREATE TABLE creates a new, initially empty table in the current database
 * Parameter: IF NOT EXISTS: Only create a new table if it does not already exist in the schema
 * Try running the first query twice and check the error message. Then run the second query.

 */
CREATE TABLE public.phi_wen (
	id INTEGER,
	first_name VARCHAR,
	last_name VARCHAR,
	date_of_birth DATE
);

CREATE TABLE IF NOT EXISTS public.phi_wen (
	id INTEGER,
	first_name VARCHAR,
	last_name VARCHAR,
	date_of_birth DATE
);

CREATE TABLE public.phi_wen2 AS
	SELECT *
	FROM public.phi_wen;

/* ALTER a table
 * Allows to add, drop or rename columns as well as renaming a table.
 * 1. Adding a column
 * Let's add a new column called city to our table.
 */
ALTER TABLE public.phi_wen
ADD COLUMN IF NOT EXISTS city DATE;

/* 2. DROP a column
 * We accidentally made our new city column of type DATE. Let's drop this column
 * and recreate it with the correct data type VARCHAR.
 */
ALTER TABLE public.phi_wen
DROP COLUMN IF EXISTS city;

ALTER TABLE public.phi_wen
ADD COLUMN IF NOT EXISTS cyti VARCHAR;

/* 3. RENAME a column
 * This time we assigned the right data type but we made a typo and need to rename our column.
 */
ALTER TABLE public.phi_wen
RENAME COLUMN cyti TO city;

/* 4. RENAME a table
 * Renames your table by adding '_renamed' to its name, then renames it back to its intital name.
 * Make sure to right-click the public schema and refresh to see the name change in the list of tables.
 */
ALTER TABLE public.phi_wen 
RENAME TO phi_wen_renamed;

ALTER TABLE public.phi_wen_renamed
RENAME TO phi_wen;

/* INSERT values INTO a table
 */
INSERT INTO public.phi_wen VALUES
(1, 'Philipp', 'Wendt', '1991-06-27', 'Hamburg'),
(2, 'Peter', 'Mueller', '1965-09-12', 'Hamburg');

/* UPDATE columns
 * We set the city for 'Peter Mueller' to 'Hamburg' even though he is from Berlin.
 * Let'a change this by altering the city variable.
 */
UPDATE public.phi_wen
SET city = 'Berlin'
WHERE first_name = 'Peter'
  AND last_name = 'Mueller';

/* DELETE rows
 * We only want people from Hamburg in our table, so lets delete all rows that have Berlin as the city variable. 
 */
DELETE FROM public.phi_wen
WHERE city = 'Berlin';

/* DROP a table
 * Our table only has one row and it does not provide any useful data for our existing flight data.
 * Lets delete the table.
 */
DROP TABLE IF EXISTS public.phi_wen,
					 public.phi_wen2;


/* Exercises
 * IMPORTANT! When creating a new table add '_group' + group number at the end of the name. Example: _group1
 */

-- 1 Create an exact copy of the airports table (= same structure and same number of rows).

/* 2.1 Remember when we used a specific type of join and found out that we have flights in our flights table,
 *     but no matching airport in the airports table?
 * 	   Find out which airports are missing.
 */

-- 2.2 Append new rows to the airports table that include all information about the missing airports.

-- 3.1 Create an exact copy of the flights table (= same structure and same number of rows).

-- 3.2 In your copy, combine flight_date and dep_time to create a new column dep_timestamp_local.

-- 3.3 In your copy, combine flight_date and arr_time to create a new column arr_timestamp_local.

-- 3.4 In your copy, convert dep_delay to interval and replace the existing column.

-- 3.5 In your copy, convert arr_delay to interval and replace the existing column.

-- 3.6 In your copy, convert air_time to interval and replace the existing column.

-- 3.7 In your copy, add a new column 'compensation' which is 1 if the flight was cancelled or diverted and 0 otherwise.
				  
/* 4 Write the code that would delete your copies of the airports and flights table below. 
 *   Run it AFTER we have discussed the results in class.
 */
