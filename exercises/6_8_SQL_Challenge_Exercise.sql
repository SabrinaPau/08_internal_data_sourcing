/*   As a Data Analyst, it is crucial that you can rely on the quality of your data at all times.
 *   The data in the actual_elapsed_time column in the flights table seems to be about the time from departure to arrival.
 *   Currently, this is only an assumption. Based on this assumption, do you feel confident in using this column in your 
 *   analysis and giving out business recommendations?
 *   If your answer is no, you're on a good path to becoming an analyst.
 *
 * 1. Using the data in the remaining columns in the flights table, can you think of a way to verify our assumption?
 *    Please provide the answer below.
 */

/*   Don't worry if you couldn't figure this one out. To verify our assumption, we can calculate the difference between 
 *   departure and arrival time and compare the result to the values in the actual_elapsed_time column to check if they're equal.
 */

/* 2.1 The first step is to become familiar with the dep_time, arr_time and actual_elapsed_time columns.
 *     Based on the column names and what you already know from previous exercises about the information that is stored 
 *     in these three columns, what are your assumptions about the data type of the values?
 */

/* 2.2 Retrieve all unique values from these columns in three separate queries and order them in descending order.
 *     Did your assumptions turn out to be correct?
 * 	   Please provide the queries below.
 */

/* 3.1 Next, calculate the difference of dep_time and arr_time and call it flight_duration.
 * 	   Please provide the query below.
 */

/* 3.2 Are the calculated flight duration values correct? If not, what's the problem and how can we solve it?
 *     Please provide the answer below.
 */

/* 4 In order to calculate correct flight duration values we need to convert dep_time, arr_time and actual_elapsed_time 
 *   into useful data types first.
 *   Change dep_time and arr_time into TIME variables, call them dep_time_f and arr_time_f. (Hint: 100% focus on the remainder)
 *   Change actual_elapsed_time into an INTERVAL variable, call it actual_elapsed_time_f.
 *   Query flight_date, origin, dest, dep_time, dep_time_f, arr_time, arr_time_f, actual_elapsed_time and actual_elapsed_time_f.
 *   Please provide the query below.
 */

/* 5.1 Again, calculate the difference, this time using dep_time_f and arr_time_f, as flight duration and call it travel_time_f.
 * 	   Please provide the query below.
 */

/* 5.2 Compare the calculated flight duration values in travel_time_f with the values in the actual_elapsed_time_f column and 
 * 	   calculate the percentage of values that are equal in both columns.
 * 	   Please provide the query below.
 */

/* 5.3 Given the percentage of matching values, can you come up with possible explanations for why the rate is so low?
 *     Please provide the answer below.
 */

/* 6.1 Differences due to time zones might be one reason for the low rate of matching values.
 *     To make sure the dep_time and arr_time values are all in the same time zone we need to know in which time zone they are.
 *     Take your query from exercise 5.1 and add the time zone values from the airports table.
 * 	   Make sure to transform them to INTERVAL and change their names to origin_tz and dest_tz.
 *     Please provide the query below.
 */

/* 6.2 Use the time zone columns to convert dep_time_f and arr_time_f to UTC and call them dep_time_f_utc and arr_time_f_utc.
 * 	   Calculate the difference of both columns and call it travel_time_f_utc.
 *     Please provide the query below.
 */

/* 6.3 Again, calculate the percentage of matching records using the new travel_time_f_utc column
 *     Explain the increase in matching records.
 *     Please provide the query and answer below.
 */

/* Bonus Challenge
 *
 * 7.1 We managed to increase the rate of matching records, but it's still not at 100%.
 *     Could overnight flights be an issue?
 *     What's special about values in the travel_time_f_utc column for overnight flights?
 *     Please provide the answer below.
 */

/* 7.2 Calculate the total number of flights that arrived after midnight UTC.
 *     Hint: I think it's time to go and buy some stamps.
 *     Please provide the query below.
 */

/* 7.3 Use your knowledge from 7.1 and 7.2 to increase the rate of matching records even further.
 *     Please provide the query below.
 */
