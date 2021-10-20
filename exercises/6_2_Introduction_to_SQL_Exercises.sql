/* This file is full of practical exercises that will help you in building up your SQL skills.
 */

/* Q1. Select the first 20 rows of columns that have
 * 	   - the full date of the flight,
 * 	   - the airport code of the origin airport
 * 	   - the airport code of the destination airport
 * 	   - whether the flight was cancelled or not
 * 	   from the flights table.
 */


/* Q2. Select the first 20 rows of all columns in the flights table.
 */


/* Q3.1 What is the total number of rows in the flights table?
 * 		Please provide the query and answer below.
 */


/* Q3.2 What is the total number of unique airlines in the flights table?
 * 		Please provide the query and answer below.
 */


/* Q4. How many airports does Germany have?
 *     Please provide the query and answer below.
 */


/* Q5. How many airport codes start with the letter 'A'?
 *     Please provide the query and answer below.
 */


/* Q6. How many airports are above 500 and below 1500 altitude?
 *     Please provide the query and answer below.
 */


/* Q7. How many flights had a departure delay smaller or equal to 0?
 *     Please provide the query and answer below.
 */


/* Q8. What was the average departure delay of all flights on January 1, 2021.
 *     Please provide the query and answer below.
 */


/* Q9.1 How many flights have a missing value (NULL value) as their departure time?
 *      Please provide the query and answer below.
 */


/* Q9.2 Out of all flights how many flights were cancelled? 
 *      Is this number equal to the number of flights that have a NULL value as their departure time above?
 *      Please provide the query and answer below.
 */


/* Q9.3 What conclusion can you derive from Q9.2? Try to come up with possible explanations.
 */


/* Q10. What's the total number of airports from BENELUX countries?
 *      Please provide the query and answer below.
 */


/* Q11. What's the total number of airports from BENELUX countries that are below 0 altitude?
 *      Please provide the query and answer below.
 */


/* Q12. What's the total number of flights on January 1, 2021 that have a departure time of NULL or were cancelled?
 *      Please provide the query and answer below.
 */


/* Q13. What's the name of the airport that is shown in the first row when sorting by airport code descending?
 *      Please provide the query and answer below.
 */


/* Q14. Select the country, city and name of all airports. Filter them to only include airports from Hamburg and Berlin.
 * 	    Sort city in ascending and name in descending order.
 * 		What's the name of the airport that is listed last?
 *      Please provide the query and answer below.
 */


/* Q15. Which airport has the lowest altitude?
 *      Please provide the query and answer below.
 */


/* Q16. Which airport would have the lowest altitude if we transformed all positive altitudes into negative altitudes and vice versa?
 *      Please provide the query and answer below.
 */


/* Q17. Give each column selected in the query below a more descriptive name using aliasing.
 * 		If you're not sure what the column means, check out this documentation: https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf
 */
SELECT faa,
	   lat,
	   lon,
	   alt,
	   tz,
	   dst
FROM airports;

/* Q18.1 Which country has the highest number of airports?
 *       Please provide the query and answer below.
 */


/* Q18.2 Which city has the highest number of airports?
 *       Please provide the query and answer below.
 */


/* Q19. Which plane has flown the most flights? Provide the plane number and the airline it belongs to?
 *      Please provide the query and answer below.
 */


/* Q20. How many planes have flown just a single flight?
 * 		Please provide the query and answer below.
 */

