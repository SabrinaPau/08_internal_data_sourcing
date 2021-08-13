/* Mathematical Functions
 * In this file you will find mathematical functions that are already hard coded into postgreSQL.
 * Make sure to understand what each function takes as input, what happens to the input and what output is returned.
 * Syntax: function(input type) -> return type: definition
 * dp = double precision
 * More info about numeric types: https://www.postgresql.org/docs/current/datatype-numeric.html
 */

/* Division
 * 1. a / b -> same as input: division (integer division truncates the result)
 * 2. div(y numeric, x numeric) -> numeric: integer quotient of y/x
 */
SELECT 5.0/2.0 AS five_divided_two;
SELECT DIV(5.0,2.0) AS five_divided_two_func;

/* Modulo
 * 1. % -> same as input: modulo (remainder)
 * 2. mod(y, x) -> same as argument types: remainder of y/x
 */
SELECT 5.0 % 2.4 AS five_modulo_two_four;
SELECT MOD(5.0,2.4) AS five_modulo_two_four_func;

/* Exponentiation
 * 1. ^ -> numerical: exponentiation (associates left to right)
 * 2. power(a dp, b dp) -> dp: a raised to the power of b
 */
SELECT 2.5^2 AS two_five_raised_two;
SELECT POWER(2.5,2) AS two_five_raised_two_func;

/* Square root
 * 1. |/ dp -> same as input: square root
 * 2. sqrt(dp or numeric) -> same as input: square root
 */
SELECT |/ 5 AS square_root_five;
SELECT SQRT(5) AS square_root_five_func;

/* Absolute value
 * 1. @ dp -> same as input: absolute value
 * 2. abs(x) -> same as input: absolute value
 */
SELECT @ -2.5 AS absolute_neg_two_five;
SELECT ABS(-2.5) AS absolute_neg_two_five_func;

/* Factorial
 * 1. bigint ! -> numerical: absolute value (deprecated, use factorial() instead)
 * 2. factorial(bigint) -> numerical: absolute value
 */
SELECT 5! AS factorial_five; -- don't use in the future!
SELECT FACTORIAL(5) AS factorial_five_func;

/* Sign
 * sign(dp or numeric) -> same as input: sign of the argument (-1, 0, +1)
 */
SELECT SIGN(5) AS sign_pos_five;
SELECT SIGN(0) AS sign_zero;
SELECT SIGN(-5) AS sign_neg_five;

/* Random
 * random() -> dp: random value in the range 0.0 <= x < 1.0
 */
SELECT RANDOM() AS random_number;

/* Decimal rounding
 * round(dp or numeric) -> same as input: round to nearest integer
 * ceil(dp or numeric) or ceiling(dp or numeric) -> same as input: nearest integer greater than or equal to argument
 * floor(dp or numeric) -> same as input: nearest integer less than or equal to argument
 * trunc(dp or numeric) -> same as input: truncate toward zero
 */
SELECT ROUND(5.129) AS round_pos_number;
SELECT ROUND(5.129, 2) AS round_pos_number;

SELECT ROUND(5.1) AS round_pos_number;
SELECT ROUND(5.9) AS round_pos_number;
SELECT CEIL(5.1) AS ceil_pos_number;
SELECT CEIL(5.9) AS ceil_pos_number;
SELECT FLOOR(5.1) AS floor_pos_number;
SELECT FLOOR(5.9) AS floor_pos_number;
SELECT TRUNC(5.1) AS trunc_pos_number;
SELECT TRUNC(5.9) AS trunc_pos_number;

SELECT ROUND(-5.1) AS round_neg_number;
SELECT ROUND(-5.9) AS round_neg_number;
SELECT CEIL(-5.1) AS ceil_neg_number;
SELECT CEIL(-5.9) AS ceil_neg_number;
SELECT FLOOR(-5.1) AS floor_neg_number;
SELECT FLOOR(-5.9) AS floor_neg_number;
SELECT TRUNC(-5.1) AS trunc_neg_number;
SELECT TRUNC(-5.9) AS trunc_neg_number;

/* Exercises
 * Now it's time to put what you've learned into practice.
 * I highly recommend not to cheat by copying and running the SQL statements.
 * Challenge your understanding and try to come up with the correct solution.
 * 
 * 1. What's the output of the following SQL statement?
 * 	  SELECT 1 / 2;
 *    Please provide the answer below.
 */


/* 2. What's the output of the following SQL statement?
 *    SELECT 1 / 2.0;
 *    Please provide the answer below.
 */

/* 3. What's the output of the following SQL statement?
 *    SELECT DIV(1.0 / 2.0);
 *    Please provide the answer below.
 */

/* 4. What's the output of the following SQL statement?
 *    SELECT 2^2^2;
 *    Please provide the answer below.
 */

/* 5. What's the output of the following SQL statement?
 *    SELECT POWER(2, 2, 2);
 *    Please provide the answer below.
 */

/* 6. What's the output of the following SQL statement?
 *    SELECT 5 % 6;
 *    Please provide the answer below.
 */

/* 7. What's the output of the following SQL statement?
 *    SELECT MOD(5.0,6.0);
 *    Please provide the answer below.
 */

/* 8. What's the output of the following SQL statement?
 *    SELECT SQRT(FACTORIAL(SIGN(@SIGN(-5))::INT));
 *    Please provide the answer below.
 */


/* 9. What's the output of the following SQL statement?
 * 	  SELECT @(2.5 / (CEIL(RANDOM())*-5));
 * 	  Please provide the answer below.
 */

/* 10. What's the output of the following SQL statement?
 *     SELECT |/(MOD(CAST(SIGN(-1337.66) + POWER(3, 3) - (FACTORIAL(3) % 5) AS INT), 20) + 4);
 * 	   Please provide the answer below.
 */

