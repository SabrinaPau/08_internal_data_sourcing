/* This file is full of practical exercises that will help you in building up your advanced SQL skills.
 */


/* Q1.1 Which countries had any departures on the '2021-01-04'?
 *      Please provide the query and answer below.
 */ 



/* Q1.2 Which plane had the most departures?
 *      Please provide the query and answer below.
 */



/* Q1.3 Which country had the most departures?
 *      Please provide the query and answer below.
 */



/* Q1.4 To which city/cities does the airport with the second most arrivals belong?
 *      Please provide the query and answer below.
 */



/* Q2. How many rows are in your result set when you inner join the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you left join the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you right the flights and airports table on faa and origin column?
 *     How many rows are in your result set when you full join the flights and airports table on faa and origin column?
 *     Please explain why the number of rows are different.
 */



/* Q3.1 Filter the data to January 1, 2021 and count all rows for that day so that your result set has two columns: flight_date, total_flights.  
 *      Repeat this step, but this time only include data from January 2, 2021.
 *      Combine the two result sets using UNION.
 */



/* Q3.2 Rewrite the query above so that you get the same output, but this time you are not allowed to use UNION.
 */



/* Q3.3 Take your query from Q3.1 and replace the UNION operator with the INTERSECT operator.
 *      Explain your results.
 */



/* Q3.4 Take your query from Q3.1 and replace the UNION operator with the EXCEPT operator.
 *      Explain your results.
 */



/* Q4. What's the highest number of flights that have departed in a day from an airport above altitude 7800?
 *     You are NOT allowed to use INNER, LEFT, RIGHT, FULL or CROSS joins!
 *     Please provide the query and answer below.
 */



/* Q5.1 How many flights have departed and arrived in the United States?
 *      You are NOT allowed to use INNER, LEFT, RIGHT, FULL or CROSS joins!
 *      Please provide the query and answer below.
 */



/* Q5.2 [Hard] Take your query from above and calculate the percentage of flights that have departed 
 *      and arrived in the United States compared to all flights, rounded to one decimal.
 *      Please provide the query and answer below.
 */



 /* Q6. Which flight had the highest departure delay?
 *      How big was the delay?
 * 	    What was the plane's tail number?
 * 	    On which day and in which city?   
 * 	    Answer all questions with a single query.
 */



/* Q7. What's the flight connection that covers the shortest distance?
 * 	   Please provide a list with 5 columns: 
 *     - origin_airport = The full name of the origin airport
 * 	   - origin_country = The country of the origin airport
 * 	   - destination_airport = The full name of the destination airport
 * 	   - destination_country = The country of the destination airport
 * 	   - smallest_distance = The flight distance between origin_airport and destination_airport
 * 	   Remember: Only provide the flight connection with the shortest distance of all flights in the flights table.
 * 	   Please provide the query below.
 */



//* OPTIONAL: Advanced Aggregations using Window Functions
 * Q8.1 The airline American Airlines (AA) wants you to take a look at one of their planes: N825AW
 *      They want you to provide a list with 4 columns: flight_date, tail_number, arr_delay, acc_flight_delay.
 *      The 'acc_flight_delay' should calculate the running sum of the arr_delay from beginning to the end of the month
 *      The list should be sorted by the flight date starting with the earliest date
 *      Please provide the query below and answer the following question:
 *      How much delay time has the plane accumulated on its last day?
 */



/* Q8.2 After American Airlines looked at the output you gave them, they realised that the arrival delay
 *      is heavily influenced by the departure delay. If a plane already departed late then it has a high
 *      chance of arriving late. That's why they want you to add the column dep_delay to the list and calculate
 *      the net_flight_delay which is the difference of arr_delay and dep_delay.
 *      Change the acc_flight_delay to acc_net_fligt_delay and adjust the calculation accordingly.
 *      How big is the difference between the previously calculated arr_delay and the net_flight_delay?
 *      Please provide the query and answer below.
 */



/* Q8.3 American Airlines has one more request: Please summarise the previous output and provide
 *      them with a table that has flight_date, tail_number and the sum of net_flight_delay grouped
 *      by flight_date and tail_number.
 */



/* Q8.4 They love it! Good job! Since your work has been very helpful to them they want to expand the output to
 *      more planes that they own. Please add the following planes in your output: N825AW, N756AM, N9018E.
 *      Additionally they would like you to add an additional column to the output called net_flight_delay_cat.
 *      This column should one of three categories depending on the value of net_flight_delay.
 *      If net_flight_delay > 0 then '1-Slower'
 *      net_flight_delay = 0 then '2-As_expected'
 *      else '3-Faster'.
 *      Please provide the query below.
 */



/* Q8.5 You've been doing an amazing job, American Airlines has one last request for you:
 *      Please summarise the previous output so that the final output groups by the tail_number
 *      and the dep_delay_cat and aggregates the number of flights in each category in a column
 *      called total_flights and the average flight delay in the column avg_daily_flight_delay.
 */



/* Q9. Final question: 
 * 	   Three SQL databases walk into a bar... then they leave. Why?
 * 	   They couldn't find a table. *badum ts*
 */
