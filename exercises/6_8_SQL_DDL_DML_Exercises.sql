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
