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


/*  
 * 1.2 And now, let's take a closer look at some particular relevant columns and make sure we fully understand these values.
 * 	   What do the values in arr_time, dep_time and actual_elapsed_time really mean?
 * 	   Retrieve all unique values from these columns(in three queries) and order them in descending order.
 *     Remember, retrieve as much data as you need - not more and not less.
 * 	   Please provide the query below.
 */

/*  
 * 1.3 What do the values in these three columns mean?
 *     Please provide the answer below.    
 */


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


/* 2.2 Compare the travel time with the air_time column.
 * 	   How many values are matching? Provide the number in percentage.
 *     Please provide the query and answer below.
 */


/* 2.3 Try to explain the results of 5.2.
 *     Please provide the answer below.
 */


/* 2.4 Join the airports table and add the time zone columns to your existing table.
 * 	   Before you add them, transform them to INTERVAL and change their names to origin_tz and dest_tz.
 *     Please provide the query below.
 */

	  
/* 2.5 Next, convert the departure and arrival time to UTC and store them in dep_time_f_utc and arr_time_f_utc.
 * 	   Calculate the difference of the new columns and store it in a new column travel_time_f_utc.
 *     Please provide the query below.
 */
	  

/* 2.6 What's the percentage of matching records now?
 *     Explain the result.
 *     Please provide the query and answer below.
 */
 
	  
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