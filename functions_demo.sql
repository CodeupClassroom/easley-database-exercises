# Functions Intro!

# Count is a function
select count(*)
from employees;

# Conctenation is how we combine string
select concat("con", "cat", "e", "nate");

# Concatenate adds strings together
select concat(first_name, " ", last_name) as full_name
from employees 
limit 10;

# the upper("hello") is the input to substre
select substr(upper("hello"), 4, 2);

# These string functions operate on single strings or entire columns of string values.
select replace(title, "Senior", "Lead")
from titles;

select curdate();

# Show all the salaries (current and prior)
select *
from salaries;

# Show all the *current* salaries
select *
from salaries
where to_date > curdate();

# Show us the average salary for current employees
select avg(salary)
from salaries
where to_date > curdate();

# What's the minimum salary
select min(salary) as minimum_current_salary
from salaries
where to_date > curdate();

# example of casting a string with a negative number to an integer
select cast("-123" as signed);

# example of casting a string with a negative number to an integer
# Unsigned means there's no sign (there's no negatives), non-negatives only
select cast("123" as unsigned);


# example of casting a number to a string
select cast(78210 as CHAR);


# Be 100% sure to always store phone numbers in strings, not number data types
# Be 100% sure to use DEMICAL data types for money (if we're counting cents)
