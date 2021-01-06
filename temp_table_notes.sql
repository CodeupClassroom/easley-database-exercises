# When Doing Temp Tables
# 3 Steps to Success w/ Temp Tables
# Step 1: Use your own database as a scratchpad
# Step 2: Write the query you need to, using the database_name.table_name after your FROM or with your JOINS
# Step 3: Wrap your query from above in CREATE TEMPORARY TABLE table_name AS ();

# Start by using your own database (so you can write/edit/delete/whatever)

# Step 1- use your own DB
# use easley_****;
use ryan;

# Step 2 - write whatever query you need, being 100% sure to use database_name.table_name syntax
select *
from employees.employees # database_name.table_name
join employees.salaries using(emp_no) # database_name.table_name
where to_date > curdate()


# Step 3 - wrap the query in a CREATE TEMPORARY TABLE table_name AS ();
# Let's make a temp table of current employees w/ their salary
create temporary table emp_salary as (
	select *
	from employees.employees # database_name.table_name
	join employees.salaries using(emp_no) # database_name.table_name
	where to_date > curdate()
);

select *
from emp_salary;

# After we have a temp table, we can get get to work:
# Querying from it
# Altering data (if we need to)

# Stakeholder says: 
# What would our total salary spend be if everybody gets a 5% raise?
# Technically we don't need a temp table to solve this, so this is a simple example :)
update emp_salary
set salary = salary + salary * .05;

select * from emp_salary;

select sum(salary) from emp_salary;


select *
from emp_salary
where first_name = "Mary"
and salary > 60000;

