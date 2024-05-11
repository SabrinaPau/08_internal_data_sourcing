/* PostgreSQL Commands
 * In this file you will find PostgreSQL commands that allow you to create, alter, insert into, update, delete and truncate tables.
 * Make sure to understand what each function takes as input and what output is returned.
 */

/* Create a table
 * IMPORTANT: Before you run the commands below make sure to change the table name to your initials.
 * = sab_pau for Philipp Wendt -> And_Emm for Andrew Emmet
 * CREATE TABLE: CREATE TABLE creates a new, initially empty table in the current database
 * Parameter: IF NOT EXISTS: Only create a new table if it does not already exist in the schema
 * Try running the first query twice and check the error message. Then run the second query.

 */
CREATE TABLE sab_pau (
	id INTEGER,
	first_name VARCHAR,
	last_name VARCHAR,
	date_of_birth DATE
);


CREATE TABLE IF NOT EXISTS sab_pau (
	id INTEGER,
	first_name VARCHAR,
	last_name VARCHAR,
	date_of_birth DATE
);


CREATE TABLE sab_pau2 AS
	SELECT *
	FROM sab_pau;

/* ALTER a table
 * Allows to add, drop or rename columns as well as renaming a table.
 * 1. Adding a column
 * Let's add a new column called city to our table.
 */
ALTER TABLE sab_pau
ADD COLUMN IF NOT EXISTS city DATE;

/* 2. DROP a column
 * We accidentally made our new city column of type DATE. Let's drop this column
 * and recreate it with the correct data type VARCHAR.
 */
ALTER TABLE sab_pau
DROP COLUMN IF EXISTS city;

--ALTER TABLE sab_pau
--ALTER COLUMN city TYPE varchar;


ALTER TABLE sab_pau
ADD COLUMN IF NOT EXISTS cyti VARCHAR;

/* 3. RENAME a column
 * This time we assigned the right data type but we made a typo and need to rename our column.
 */
ALTER TABLE sab_pau
RENAME COLUMN cyti TO city;

/* 4. RENAME a table
 * Renames your table by adding '_renamed' to its name, then renames it back to its intital name.
 * Make sure to right-click the public schema and refresh to see the name change in the list of tables.
 */
ALTER TABLE sab_pau 
RENAME TO sab_pau_renamed;


ALTER TABLE sab_pau_renamed
RENAME TO sab_pau;

/* INSERT values INTO a table
 */
INSERT INTO sab_pau VALUES
(1, 'Philipp', 'Wendt', '1991-06-27', 'Hamburg'),
(2, 'Peter', 'Mueller', '1965-09-12', 'Hamburg'),
(3, 'Anneliese', 'Brown', NULL, NULL);


SELECT *
FROM sab_pau
ORDER BY id;


SELECT *
FROM sab_pau2
ORDER BY id;


INSERT INTO sab_pau2
	SELECT *
	FROM sab_pau;


INSERT INTO sab_pau2(id, first_name, last_name, date_of_birth)
	SELECT id, first_name, last_name, date_of_birth
	FROM sab_pau;


ALTER TABLE sab_pau2
ADD COLUMN IF NOT EXISTS first_last_name VARCHAR;


INSERT INTO sab_pau2(first_last_name)
	SELECT CONCAT(first_name, '_', last_name)
	FROM sab_pau;


ALTER TABLE sab_pau2
ADD COLUMN IF NOT EXISTS city VARCHAR;

/* UPDATE columns
 * We set the city for 'Peter Mueller' to 'Hamburg' even though he is from Berlin.
 * Let'a change this by altering the city variable.
 */
SELECT *
FROM sab_pau
ORDER BY id;


UPDATE sab_pau
SET city = 'Berlin'
WHERE first_name = 'Peter'
  AND last_name = 'Mueller';
 

UPDATE sab_pau2 
SET first_last_name =  concat(first_name, '_', last_name) 
WHERE first_name = 'Peter';
										

UPDATE sab_pau2 
SET first_last_name = 	(SELECT concat(first_name, '_', last_name) 
						FROM sab_pau
						WHERE first_name = 'Anneliese') -- in order to get just one row from the subquery
WHERE first_name = 'Anneliese';
--ORDER BY id;

/* DELETE rows
 * We only want people from Hamburg in our table, so lets delete all rows that have Berlin as the city variable. 
 */
DELETE FROM sab_pau
WHERE city = 'Berlin';

SELECT *
FROM sab_pau
ORDER BY id;

TRUNCATE sab_pau2;		-- doesn't DROP the TABLE, just deletes the entries

/* DROP a table
 * Our table only has one row and it does not provide any useful data for our existing flight data.
 * Lets delete the table.
 */
DROP TABLE IF EXISTS sab_pau,
					 sab_pau2;
