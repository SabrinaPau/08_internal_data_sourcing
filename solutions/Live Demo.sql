/*  Manage Complexity: from flight_date retrieve the weekday as a word and the number of the weekday separated by ':'
* e.g. 'Tuesday:2' 
* ! all in one column and without any blankspaces
*/  

SELECT TRIM(TRAILING to_char(flight_date, 'Day')), ':' ,EXTRACT (DOW FROM flight_date)
FROM flights f ;

SELECT concat(TRIM(TRAILING to_char(flight_date, 'Day')), ':' ,EXTRACT (DOW FROM flight_date))  AS whatever
FROM flights;





