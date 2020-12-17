USE employees;

# format is column operator value
# like first_name = 'Georgi'
select *
from employees
where first_name = 'Georgi';

select *
from salaries
where salary < 50000;

select *
from employees
where emp_no between 20000 and 20050;

select *
from employees
where hire_date between '1991-01-01' and '1992-01-01';

# Show me everybody except all the Georgis
select * 
from employees
where first_name != 'Georgi';


# Compare the following two queries. Pay attention to the column name in the output.
select concat(first_name, " ", last_name) 
from employees;

select concat(first_name, " ", last_name) as full_name
from employees;

# The following two queries run identically. The new line characters don not impact performance.
select * from employees where first_name = 'Georgi';

select * 
from employees
where first_name = 'Georgi';

# Notice that we can add logical operators like or/and between the column = value part of the WHERE clause.
select *
from employees
where first_name = 'Georgi'
or first_name = 'Mary';

# How to sort (we  will cover this more deeply very soon)
select *
from employees
where first_name = 'Georgi'
or first_name = 'Mary'
order by first_name;