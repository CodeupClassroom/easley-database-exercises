# db_name.table_name.column
# SQL does its best to determine the context of a column, what table/db it lives in
select employees.employees.first_name, last_name
from employees;

select *
from employees
join titles ON employees.emp_no = titles.emp_no;

# How many titles has each employee had?
select employees.emp_no, count(*)
from employees
join titles ON titles.emp_no = employees.emp_no
group by emp_no;

# Sometimes the primary key on table A and the foreign key on table B have the same name
# Like emp_no on employees is primary key and emp_no is foreign key on salaries, titles, etc...
# Othertimes, the primary key on table A is id and the foreign key on table B is a_id
# Specific example: id on the author table relates to author_id on the quotes table. 

# If we have a foreign key and a primary key that have an identical name, we can do the following:
use employees;

# This query is quite close the query beneath it
select *
from employees
join titles using(emp_no); # using(column_name)


# note the duplicated emp_no column using the following:
select *
from employees
join titles ON titles.emp_no = employees.emp_no; # using(column_name)


use quotes_db;
show tables;

# Join author and quote
select *
from authors
join quotes on quotes.author_id = authors.id;


select * 
from roles;

select *
from users;

# Default JOIN type is the inner Join
# The inner join finds records from Table A that correspond to a key on Table B
# Inner Joins return no nulls (by default) 
# INNER JOIN is a logical AND statement
# INNER JOIN is the intersection of table A and table B
select *
from users
join roles on users.role_id = roles.id;


# LEFT JOIN keeps any records from table A that have nulls to table B
select *
from users # By putting USERS in the From and choosing LEFT means we get all the users, whether or not they have arole.
left join roles on roles.id = users.role_id; 

# RIGHT JOIN keeps any records from table B that have nulls on table A
select *
from users
right join roles on roles.id = users.role_id;

# So you can do accomplish a left join by swapping the order of the tables and doing a right join
# Write a query that shows the current salary for all current employees
select *
from employees
join salaries on salaries.emp_no = employees.emp_no
where salaries.to_date > curdate();

# Show all the current employees and the department name where they work
# employee info is on employees table
# department name is on the departments table
# dept_emp shows us which employees worked at which dept for a date range.
select first_name, last_name, dept_name, to_date
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where dept_emp.to_date > curdate();

# Number of joins is the number of tables - 1 (generally)
# A one to many relationship has 2 tables, means 2 joins
# A many-to-many relationship talks to 3 tables, meaning 2 joins


# Write a query that returns the employee name, their current department name, and their current salary
# We will need to join 4 tables together: employees to get names, dept_emp table to get where they work, departments table to get the dept_name, salaries table to get their $
select first_name, 
	last_name, 
	salary, 
	departments.dept_name, 
	dept_emp.to_date as "department_to_date", 
	salaries.to_date as "salaries_to_date"
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join salaries on salaries.emp_no = employees.emp_no
where dept_emp.to_date > curdate()
AND salaries.to_date > curdate();