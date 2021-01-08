-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
-- (Use CASE statements or IF() function to explore information in the employees database)

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.   (300_024 records returned without duplicate departments for any employee)

USE employees;

-- Explore the tables to make sure that my observations are what I think they are here.

-- 331_603 rows because some employees have been in more than one department.

SELECT
	*
FROM dept_emp;

-- 331_603 rows because some employees have been in more than one department.

SELECT
	*
FROM employees_with_departments;

-- 300_024 rows because each row represents only on employee and is present only one time.

SELECT
	*
FROM employees;

-- All employee numbers, managers included, are in the dept_emp table and the employees_with_departments table.

SELECT
	emp_no
FROM dept_manager
WHERE emp_no NOT IN (SELECT
						emp_no
					FROM dept_emp);

-- All employee numbers in employees_with_departments are in dept_emp.

SELECT
	emp_no
FROM employees_with_departments
WHERE emp_no NOT IN (SELECT
						emp_no
					FROM dept_emp);
					
-- All employee numbers, including managers, are in employees. 3000_024 rows

SELECT
	emp_no
FROM dept_manager 
WHERE emp_no NOT IN (SELECT
				emp_no
			  FROM employees);

##################################################

-- This is Easy!!!

SELECT
	emp_no,
	dept_no,
	from_date,
	to_date,
	IF(to_date = '9999-01-01', 1, 0) AS is_current_employee
FROM dept_emp;

-- Subquery to get the most recent departments for each employee.

SELECT 
	emp_no,
	MAX(to_date) AS max_date
FROM dept_emp
GROUP BY emp_no;

-- Wait...my observations are not employees; they are emp_no and dept_no. I have to do more...

-- Use my subquery to get rid of the duplicate entries for employees older departments. BUT this is not the employees hire_date.

SELECT
	dept_emp.emp_no,
	dept_no,
	to_date,
	from_date,
	IF(to_date = '9999-01-01', 1, 0) AS is_current_employee
FROM dept_emp
JOIN (SELECT 
		emp_no,
		MAX(to_date) AS max_date
	FROM dept_emp
	GROUP BY emp_no) AS last_dept
ON dept_emp.emp_no = last_dept.emp_no
	AND dept_emp.to_date = last_dept.max_date;

-- If I want the actual hire_date, I have to JOIN employees and bring that in. Otherwise, from_date only applies to the current or last department for that employee.

SELECT
	dept_emp.emp_no,
	dept_no,
	to_date,
	from_date,
	hire_date,
	IF(to_date = '9999-01-01', 1, 0) AS is_current_employee,
	IF(hire_date = from_date, 1, 0) AS only_one_dept
FROM dept_emp
JOIN (SELECT 
		emp_no,
		MAX(to_date) AS max_date
	FROM dept_emp
	GROUP BY emp_no) AS last_dept
ON dept_emp.emp_no = last_dept.emp_no
	AND dept_emp.to_date = last_dept.max_date
JOIN employees AS e ON e.emp_no = dept_emp.emp_no;



-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	CONCAT(first_name, ' ', last_name) AS employee_name,
	CASE
		WHEN LEFT(last_name, 1) IN('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
		WHEN LEFT(last_name, 1) IN('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
		ELSE 'R-Z'
	END AS alpha_group
FROM employees;

--3. How many employees (current or previous) were born in each decade?

-- Oldest birth dates in 1952, 19605 the most recent.

SELECT
	* 
FROM employees
ORDER BY birth_date DESC
LIMIT 5;

-- Create and count the decade bins.

SELECT
	CASE
		WHEN birth_date LIKE '195%' THEN '50s'
		WHEN birth_date LIKE '196%' THEN '60s'
		ELSE 'YOUNG'
	END AS decade,
	COUNT(*)
FROM employees
GROUP BY decade;

-- Bonus: What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT
	CASE
		WHEN dept_name IN('Research', 'Development') THEN 'R&D'
		WHEN dept_name IN('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN('Production', 'Quality Management') THEN 'QM'
		WHEN dept_name IN('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS department_group,
	ROUND(AVG(salary), 2) AS average_salary
FROM salaries AS s
JOIN employees_with_departments AS ewd ON s.emp_no = ewd.emp_no
	AND s.to_date > CURDATE()
GROUP BY department_group;