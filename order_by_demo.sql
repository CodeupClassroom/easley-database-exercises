use employees;

# This is the default order-by, SQL orders by the primary key by default
select *
from employees
order by emp_no ASC;  # If we do not specify ASC/DESC, the default is ASC

select *
from employees
order by first_name ASC, last_name ASC, hire_date ASC;

select *
from employees
WHERE emp_no between 101010 and 202020
and last_name like '%q%'
order by first_name DESC, birth_date ASC;