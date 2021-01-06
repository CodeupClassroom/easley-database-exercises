-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
-- (55 current employees have the same hire date as employee 101010)

-- Get the hire date of employee 101010.

SELECT
	hire_date
FROM employees
WHERE emp_no = 101010;

-- Use the above query as a scaler subquery. (returns exactly one column value from one row)

SELECT
	first_name,
	last_name,
	hire_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	AND dept_emp.to_date > CURDATE()
WHERE hire_date = (SELECT
                       hire_date
                   FROM employees
                   WHERE emp_no = 101010
                    );

-- 2. Find all the titles ever held by all current employees with the first name Aamod. 

/*
Assistant Engineer
Engineer
Senior Engineer
Senior Staff
Staff
Technique Leader
*/

-- Create my subquery to find current employees with the name Aamod. (168 current employees named Aamad.)

SELECT
	first_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND to_date > CURDATE()
WHERE first_name = 'Aamod';


-- Use my subquery in the WHERE clause of my query to find any titles ever held by current employees with the first name Aamod. (6 titles every held by a current employee named Aamad.)

SELECT
	title
FROM employees AS e
JOIN titles AS t USING(emp_no)
WHERE first_name IN (
                        SELECT
                            first_name
                        FROM employees AS e
                        JOIN salaries AS s ON e.emp_no = s.emp_no
                        AND to_date > CURDATE()
                        WHERE first_name = 'Aamod'
                      )
GROUP BY title;



-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. (59_900 employees are not current employees in the employees table.)

-- My subquery -> All employee numbers of employees currently getting a salary. 

SELECT
	emp_no
FROM salaries 
WHERE to_date > CURDATE();

-- Count of employees in the employees table whose employee numbers are not getting a salary.

SELECT
	COUNT(emp_no) AS number_of_exemployees
FROM employees
WHERE emp_no NOT IN (
					SELECT
                        emp_no
                    FROM salaries 
                    WHERE to_date > CURDATE()
					);

-- 4. Find all the current department managers that are female. List their names in a comment in your code.

/*
Isamu Legleitner
Karsten Sigstam
Leon DasSarma
Hilary Kambil
*/

-- My subquery -> Employee numbers of all department managers.

SELECT
	emp_no
FROM dept_manager
WHERE to_date > CURDATE();

-- Use my subquery in my WHERE clause to limit names to those with employee numbers in the list of manager employee numbers. Add a condition for female.

SELECT
	CONCAT(first_name, ' ', last_name) AS female_managers
FROM employees
WHERE emp_no IN (
				SELECT
					emp_no
				FROM dept_manager
				WHERE to_date > CURDATE()
				)
AND gender = 'F';


-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary. 

-- 154_543 employees currently have a higher salary than the historical average salary.

-- My subquery -> Get the historical average salary. (63810.7448)

SELECT
	AVG(salary) AS historical_average_salary
FROM salaries;

-- Use my subquery

SELECT
	e.emp_no,
	first_name,
	last_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND to_date > CURDATE()
WHERE salary > (
				SELECT
					AVG(salary) AS historical_average_salary
				FROM salaries
				);


-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- My subquery -> Get 1 stddev of max salary. (140910.04066365326)
SELECT
	(MAX(salary) - STDDEV(salary)) AS salary_within_one_stddev_of_max
FROM salaries
WHERE to_date > CURDATE();

-- Use my subquery in the WHERE clause to get the 83.

SELECT
	COUNT(salary) AS salaries_within_1_stddev
FROM salaries 
WHERE to_date > CURDATE()
AND salary > (
				SELECT
					(MAX(salary) - STDDEV(salary))
				FROM salaries
				WHERE to_date > CURDATE()
				);
			  
-- Use my query from above now as a subquery!
		 
SELECT 
	CONCAT(
		(SELECT
			COUNT(salary)
		FROM salaries 
		WHERE to_date > CURDATE()
		AND salary > (
					  SELECT
						(MAX(salary) - STDDEV(salary))
					  FROM salaries
					  WHERE to_date > CURDATE())
		) 
/ 
		(
		 SELECT COUNT(*)
		 FROM salaries
		 WHERE to_date > CURDATE()) * 100, '%') AS percent_of_salaries_within_1_stddev_of_max;

