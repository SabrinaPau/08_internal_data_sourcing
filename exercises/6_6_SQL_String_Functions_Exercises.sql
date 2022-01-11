/* String Functions
 * In this file you will find string functions that are already hard coded into postgreSQL.
 * Make sure to understand what each function takes as input, what happens to the input and what output is returned.
 * Syntax: function(input type) -> return type: definition
 * More info about string functions: https://www.postgresql.org/docs/current/functions-string.html
 */

/* I. String exploration
 * String length
 * 1. char_length(string) or character_length(string) -> int: Number of characters in string
 * 2. a) length(string): Number of characters in string
 * 	  b) length(string bytea, encoding name ): Number of characters in string in the given encoding. The string must be valid in this encoding.
 */
SELECT CHAR_LENGTH('neuefische') AS string_length;
SELECT LENGTH('neuefische') AS string_length;
SELECT LENGTH('neuefische', 'UTF-8') AS string_length;

/* String position
 * 1. position(substring in string) -> int: Location of specified substring
 * 2. strpos(string, substring) -> int: Location of specified substring (same as position(substring in string), but note the reversed argument order)
 */
SELECT POSITION('fische' IN 'neuefische') AS string_position;
SELECT STRPOS('neuefische', 'fische') AS string_position;

/* String filtering
 * starts_with(string, prefix) -> bool: Returns true if string starts with prefix.
 */
SELECT STARTS_WITH('neuefische', 'neu') AS string_position;

/* II. String combination
 * String repetition
 * repeat(string text, number int) -> text: Repeat string the specified number of times
 */
SELECT REPEAT('neu', 5) AS string_repetition;

/* String concatenation
 * 1. string || string -> text: String concatenation
 * 2. concat(str "any" [, str "any" [, ...] ]) -> text: Concatenate the text representations of all the arguments. NULL arguments are ignored.
 * 3. concat_ws(sep text, str "any" [, str "any" [, ...] ]) -> text: Concatenate all but the first argument with separators. The first argument is used as the separator string. NULL arguments are ignored.
 * 4. format(formatstr text [, formatarg "any" [, ...] ]) -> text: Format arguments according to a format string.
 */
SELECT 'neue' || 'fische ' || 2021 AS string_concat;
SELECT CONCAT('neue', 'fische ', NULL, 2021) AS string_concat;
SELECT CONCAT_WS(' ', 'neue', 'fische', 2021) AS string_concat_ws;
SELECT FORMAT('The best course is %s, at %s!', 'Data Analytics', 'neuefische') AS string_format;

/* String padding
 * 1. lpad(string text, length int [, fill text]): Fill up the 'string' to length 'length' by prepending the characters 'fill' (a space by default). If the 'string' is already longer than 'length' then it is truncated (on the right).
 * 2. rpad(string text, length int [, fill text]): Fill up the 'string' to length 'length' by appending the characters 'fill' (a space by default). If the 'string' is already longer than 'length' then it is truncated (on the left).
 */
SELECT LPAD('llo', 7, 'He') AS string_left_fill;
SELECT RPAD('He', 8, 'llo') AS string_right_fill;

/* III. String cleaning & replacing
 * String reversing
 * reverse(str) -> text: Return reversed string.
 */
SELECT REVERSE('1202 ehcsifeuen') AS string_reversed;

/* String letter case
 * 1. lower(string) -> text: Convert string to lower case
 * 2. upper(string) -> text: Convert string to upper case
 * 3. initcap(string) -> text: Convert the first letter of each word to upper case and the rest to lower case. Words are sequences of alphanumeric characters separated by non-alphanumeric characters.
 */
SELECT LOWER('NEUEFISCHE') string_lower;
SELECT UPPER('neuefische') string_upper;
SELECT INITCAP('we LOVE nEUefISCHe') string_initcap;

/* String trimming
 * 1. trim([leading | trailing | both] [characters] from string) -> text: Remove the longest string containing only characters from characters (a space by default) from the start, end, or both ends (both is the default) of string
 * 2. ltrim(string text [, characters text]) -> text: Remove the longest string containing only characters from characters (a space by default) from the start of string
 * 3. rtrim(string text [, characters text]) -> text: Remove the longest string containing only characters from characters (a space by default) from the end of string
 * 4. btrim(string text [, characters text]) -> text: Remove the longest string consisting only of characters in characters (a space by default) from the start and end of string
 */
SELECT TRIM(LEADING '.,;' FROM '.;!.neuefische.!;.') AS string_left_trim;
SELECT LTRIM('.;!.neuefische.!;.', '.,;') AS string_left_trim_alt;

SELECT TRIM(TRAILING '.,;' FROM '.;!.neuefische.!;.') AS string_right_trim;
SELECT RTRIM('.;!.neuefische.!;.', '.,;') AS string_right_trim_alt;

SELECT TRIM(BOTH '.,;' FROM '.;!.neuefische.!;.') AS string_both_trim;
SELECT BTRIM('.;!.neuefische.!;.', '.,;') AS string_both_trim_alt;

/* String replacing
 * 1. overlay(string placing string from int [for int]) -> text: Replace substring
 * 2. replace(string text, from text, to text) -> text: Replace all occurrences in string of substring from with substring to
 * 3. regexp_replace(string text, pattern text, replacement text [, flags text]) -> text: Replace substring(s) matching a POSIX regular expression.
 */
SELECT OVERLAY('nXXXXXXXXe' PLACING 'eu' FROM 2) AS string_overlay;
SELECT OVERLAY('nXXXXXXXXe' PLACING 'eu' FROM 2 FOR 8) AS string_overlay;
SELECT OVERLAY('nXXXXXXXXe' PLACING 'euefisch' FROM 2) AS string_overlay;

SELECT REPLACE('neuefische', 'e', '') AS string_replace;
SELECT REGEXP_REPLACE('neuefische', 'f.', 'frö') AS string_regexp_replace;
SELECT REGEXP_REPLACE('fische neue','(.*) (.*)', '\2\1') AS string_regexp_replace;

/* IV. String extraction
 * Extraction by index
 * 1. left(str text, n int) -> text: Return first n characters in the string. When n is negative, return all but last |n| characters.
 * 2. right(str text, n int) -> text: Return last n characters in the string. When n is negative, return all but first |n| characters.
 * 3. substring(string [from int] [for int]) -> text: Extract substring
 */
SELECT LEFT('neuefische', 4) AS string_from_left;
SELECT LEFT('neuefische', -6) AS string_from_left;
SELECT RIGHT('neuefische', 6) AS string_from_right;
SELECT RIGHT('neuefische', -4) AS string_from_right;
SELECT SUBSTRING('neuefische' FROM 5 FOR 5) AS string_substring;

/* Extraction by pattern
 * 1. a) substring(string from pattern) -> text: Extract substring matching POSIX regular expression.
 * 	  b) substring(string from pattern for escape) -> text: Extract substring matching SQL regular expression.
 * 2. regexp_match(string text, pattern text [, flags text]) -> text[]: Return captured substring(s) resulting from the first match of a POSIX regular expression to the string.
 * 3. regexp_matches(string text, pattern text [, flags text]) -> set of text[]: Return captured substring(s) resulting from matching a POSIX regular expression to the string.
 */
SELECT SUBSTRING('neuefische' FROM '......$') AS string_substring;
SELECT SUBSTRING('neuefische' FROM '%#"f_sch#"_' FOR '#') AS string_substring;
SELECT REGEXP_MATCH('neuefische',  '(neue)(fische)') AS string_regexp;
SELECT REGEXP_MATCHES('neueneuefische',  'n..', 'g') AS string_regexp;

/* Extraction by splitting
 * split_part(string text, delimiter text, field int) -> text: Split string on delimiter and return the given field (counting from one)
 */
SELECT SPLIT_PART('neue-fische-2021', '-', 3) AS string_split;

/* Exercises
 * Now it's time to put what you've learned into practice.
 * The following exercises need to be solved using the airports table from the PostgreSQL database you've already worked with.
 * Challenge your understanding and try to come up with the correct solution.
 * 
 * 1. How many letters does the airport with the longest name have?
 *	  Which airport is it and where is it located?
 *    Please provide the query and answer below.
 */

/* 2. The names of how many airports start with the letter 'X'?
 *    Please provide the query and answer below.
 */

/* 3. How many airports have the leteer 'X' as the second letter in their airport code?
 *    Please provide the query and answer below.
 */

/* 4. Combine the 'faa' and 'name' column in the airports table so that your output looks as follows: 'faa - name'.
 *    Please provide the query below.
 */

/* 5. How many airports have a palindrome as their airport code?
 *    Please provide the query and answer below.
 */

/* 6. Return all unique country and cities combinations showing country name in upper case and city name in lowercase.
 *    Please provide the query below.
 */

/* 7. In how many airports does the first letter of the city match the first letter of the airport name?
 *    Please provide the query and answer below.
 */

/* 8. How many airport names contain the name of the city in which they are located?
 * 	  Bonus: What's the percentage compared to all airports in the list?
 *    Please provide the query and answer below.
 */

/* 9. Perform all of the following steps in ONE query:
 *    1. Query the 'lat' and 'lon' column with only one decimal using string functions
 *    2. Merge the two columns into a new column having the structure: lat;lon
 * 	  3. Split the column into two columns called lat and lon again
 *    Please provide the query and answer below.
 */

/* 10. Return a list of unique country names from the airports table that have 'land' in their name but NOT 'Island'.
 *	   Take this list and replace the string 'land' with 'sea'
 *	   Which of the newly created country names do you find the funniest?
 *     Please provide the query and answer below.
 */

