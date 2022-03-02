/* PostgreSQL Commands
 * In this file you will find PostgreSQL commands that allow you to create, alter, insert into, update, delete and truncate tables.
 * Make sure to understand what each function takes as input and what output is returned.
 */

/* Create a table
 * IMPORTANT: Before you run the commands below make sure to change the table name to your initials.
 * = phi_wen for Philipp Wendt -> And_Emm for Andrew Emmet
 * CREATE TABLE: CREATE TABLE creates a new, initially empty table in the current database
 * Parameter: IF NOT EXISTS: Only create a new table if it does not already exist in the schema
 * Try running the first query twice and check the error message. Then run the second query.

 */
CREATE TABLE phi_wen (
	id INTEGER,
	first_name VARCHAR,
	last_name VARCHAR,
	date_of_birth DATE
);


CREATE TABLE IF NOT EXISTS phi_wen (
	id INTEGER,
	first_name VARCHAR,
	last_name VARCHAR,
	date_of_birth DATE
);


CREATE TABLE phi_wen2 AS
	SELECT *
	FROM phi_wen;

/* ALTER a table
 * Allows to add, drop or rename columns as well as renaming a table.
 * 1. Adding a column
 * Let's add a new column called city to our table.
 */
ALTER TABLE phi_wen
ADD COLUMN IF NOT EXISTS city DATE;

/* 2. DROP a column
 * We accidentally made our new city column of type DATE. Let's drop this column
 * and recreate it with the correct data type VARCHAR.
 */
ALTER TABLE phi_wen
DROP COLUMN IF EXISTS city;


ALTER TABLE phi_wen
ADD COLUMN IF NOT EXISTS cyti VARCHAR;

/* 3. RENAME a column
 * This time we assigned the right data type but we made a typo and need to rename our column.
 */
ALTER TABLE phi_wen
RENAME COLUMN cyti TO city;

/* 4. RENAME a table
 * Renames your table by adding '_renamed' to its name, then renames it back to its intital name.
 * Make sure to right-click the public schema and refresh to see the name change in the list of tables.
 */
ALTER TABLE phi_wen 
RENAME TO phi_wen_renamed;


ALTER TABLE phi_wen_renamed
RENAME TO phi_wen;

/* INSERT values INTO a table
 */
INSERT INTO phi_wen VALUES
(1, 'Philipp', 'Wendt', '1991-06-27', 'Hamburg'),
(2, 'Peter', 'Mueller', '1965-09-12', 'Hamburg');


SELECT *
FROM phi_wen
ORDER BY id;


SELECT *
FROM phi_wen2
ORDER BY id;


INSERT INTO phi_wen2
	SELECT *
	FROM phi_wen;


INSERT INTO phi_wen2(id, first_name, last_name, date_of_birth)
	SELECT id, first_name, last_name, date_of_birth
	FROM phi_wen;


ALTER TABLE phi_wen2
ADD COLUMN IF NOT EXISTS first_last_name VARCHAR;


INSERT INTO phi_wen2(first_last_name)
	SELECT CONCAT(first_name, '_', last_name)
	FROM phi_wen;


ALTER TABLE phi_wen2
ADD COLUMN IF NOT EXISTS city VARCHAR;

/* UPDATE columns
 * We set the city for 'Peter Mueller' to 'Hamburg' even though he is from Berlin.
 * Let'a change this by altering the city variable.
 */
SELECT *
FROM phi_wen
ORDER BY id;


UPDATE phi_wen
SET city = 'Berlin'
WHERE first_name = 'Peter'
  AND last_name = 'Mueller';
 

UPDATE phi_wen2 
SET first_last_name =  concat(first_name, '_', last_name) 
WHERE first_name = 'Peter';
										

UPDATE phi_wen2 
SET first_last_name = 	(SELECT concat(first_name, '_', last_name) 
						FROM phi_wen
						WHERE first_name = 'Philipp') -- in order to get just one row from the subquery
WHERE first_name = 'Philipp'
ORDER BY id;

/* DELETE rows
 * We only want people from Hamburg in our table, so lets delete all rows that have Berlin as the city variable. 
 */
DELETE FROM phi_wen
WHERE city = 'Berlin';

SELECT *
FROM phi_wen
ORDER BY id;

/* DROP a table
 * Our table only has one row and it does not provide any useful data for our existing flight data.
 * Lets delete the table.
 */
DROP TABLE IF EXISTS phi_wen,
					 phi_wen2;
