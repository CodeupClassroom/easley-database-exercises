-- 1. Copy the order by exercise and save it as functions_exercises.sql.

USE employees;

-- 2. Write a query to to find all current employees whose last name starts AND ends with 'E'. Use CONCAT() to combine their first and last name together as a single column named full_name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%E';

-- 3. Convert the names produced in your last query to all uppercase.

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%E';

-- This worst just as well.

SELECT CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%E';


-- 4. For your query of employees born on Christmas AND hired in the 90s, use DATEDIFF() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()).

SELECT emp_no,
	   first_name,
	   last_name,
	   DATEDIFF(CURDATE(), hire_date) AS days_employed
FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%';

-- We can add more columns if we like, too. How about years employed?

SELECT emp_no,
	   first_name,
	   last_name,
	   DATEDIFF(CURDATE(), hire_date) AS days_employed,
	   ROUND((DATEDIFF(CURDATE(), hire_date) / 365 )) AS years_employed
FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%';

-- 5. Find the smallest and largest salary from the salaries table. I'll check out salaries first.
DESCRIBE salaries;

SELECT MIN(salary) AS smallest_employee_salary,
	   MAX(salary) AS largest__employee_salary
FROM salaries;

-- 6. Use your knowledge of built in SQL functions to generate a username for all employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.

SELECT LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
	   first_name,
	   last_name,
	   birth_date
FROM employees;

/* Below is an example of what the first 10 rows will look like:


gface_0953	Georgi	   Facello	       1953-09-02
bsimm_0664	Bezalel    Simmel	       1964-06-02
pbamf_1259	Parto      Bamford	       1959-12-03
ckobl_0554	Chirstian  Koblick         1954-05-01
kmali_0155	Kyoichi    Maliniak	       1955-01-21
apreu_0453	Anneke	   Preusig	       1953-04-20
tziel_0557	Tzvetan    Zielinski	   1957-05-23
skall_0258	Saniya	   Kalloufi	       1958-02-19
speac_0452	Sumant	   Peac	           1952-04-19
dpive_0663	Duangkaew  Piveteau        1963-06-01
*/
