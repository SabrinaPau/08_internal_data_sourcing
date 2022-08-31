/* 
 *   Try to get as far as you can in this challenge, but don't worry if you can't achieve all objectives.
 */
 
/*   As a Data Analyst, it is crucial that you can rely on the quality of your data at all times.
 *   The data in the actual_elapsed_time column in the flights table seems to be about the time from departure to arrival. 
 *   At the moment you can't verify that this is true. So, do you feel confident in using this column in your analysis and give business recommendations?  
 *   Your answer should be no. Fortunately, we have data about departure and arrival time, which allows us to do to our own calculation of the flight duration.
 *   We can then compare our flight duration with the values in the actual_elapsed_time column and see whether the values are matching.
 */
/*  
 * 1.1 First, let's get a first glimpse of our dataset.
 * 	   Since computational power comes at a cost and is often shared by many people inside a company,
 *     retrieve only as much data as you really need. Retrieve the first 100 rows of the flights table.
 * 	   Please provide the query below.
 */

/*  
 * 1.2 Next, let's take a closer look at some specific columns and make sure we fully understand their meaning.
 * 	   What do the values in arr_time, dep_time and actual_elapsed_time really mean?
 * 	   Retrieve all unique values from these columns in three separate queries and order them in descending order.
 *     Remember, retrieve as much data as you need - not more and not less.
 * 	   Please provide the queries below.
 */

/*  
 * 1.3 What do the values in these three columns mean?
 *     Please provide the answer below.    
 */



/*     Now that we understand our data, let's start with the actual task. 
 *     First, calculate the flight duration based on dep_time and arr_time.
 *     Then, compare your flight duration values with with the actual_elapsed_time column values and calculate the percentage of matching values.
 */
 
 /*
 * 2.1 Query the following columns from the flights table: flight_date, origin, dest, dep_time, arr_time and actual_elapsed_time.
 *     Convert dep_time, arr_time into TIME variables: dep_time_f and arr_time_f 
 *     Convert actual_elapsed_time into an INTERVAL variable: actual_elapsed_time_f
 *     Calculate the difference of dep_time_f and arr_time_f in a new column called travel_time_f.
 *     Please provide the query below.
 */



/* 2.2 Compare the travel_time_f column with the actual_elapsed_time_f column.
 * 	   How many values are matching? Provide the number in percentage.
 *     Please provide the query and answer below.
 */



/* 2.3 Try to explain the results of 2.2.
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

	  

/* Extra Credit: 2.7 Add two columns to your table
 * 				   	 dep_timestamp_utc: a timestamp that shows the date and time of the departure in UTC time zone
 *     			   	 arr_timestamp_utc: a timestamp that shows the date and time of the arrival in UTC time zone
 *     			   	 How many flights arrived after midnight UTC?
 *     			   	 Please provide the query and answer below.
 */



/* Extra Credit: 2.8 Until now, we achieved a match rate of nearly 84%
 * 					 1. Do you have any ideas how to increase the match rate any further?
 *  				 2. Create a query and confirm your ideas.  
 */

