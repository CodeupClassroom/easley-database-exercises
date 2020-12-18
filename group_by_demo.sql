# How many salaries are there?
# 2,844,047
select count(*) from salaries;

#85,814 unique salaries
select count(distinct salary)
from salaries;

# Introducing Group By
# 85,814 unique salaries
# NOTICE: The count is the exact same as distinct salary
# NOTICE: in salary ascending/increasing order
select salary
from salaries
group by salary DESC;


# 279,408
select distinct concat(first_name, " ", last_name) as full_name
from employees;

# Compare to Group By - we could group by a function's result
select concat(first_name, ' ', last_name)
from employees
group by concat(first_name, ' ', last_name);


# Compare to Group By = and we can alias and group by an alias
# 279,408
select concat(first_name, ' ', last_name) as full_name
from employees
group by full_name DESC;



# Once we have a group by query... we have the option of using aggregate functions
# count, min, max, avg are aggregate functions
select concat(first_name, ' ', last_name) as full_name, count(*)
from employees
group by full_name DESC
order by count(*) DESC;




# When we GROUP BY (in SQL or Python or anywhere)
# we are changing the level of our "observation"
# What do I mean by that?
# On the employees table, each row is a single individual employee/person
# But when we group by full_name, we lose that layer of detail and
# We're re-defining the "observation" to be the concat(first_name, ' ', last_name)

# What is the new definiton of an observation/row?
select dept_no, count(*)
from dept_emp
group by dept_no;




# When we group by a column we're selecting by, it's like SELECT DISTINCT
# But, we can also use a count(*) as a new column to count duplicates


# Build up from select distinct
select distinct dept_no
from dept_emp;

# Same result but we can add aggregate functions as new columns
select dept_no, count(*)
from dept_emp
group by dept_no;


# Now, let's show # of employees who are currently employed..
select dept_no, count(*)
from dept_emp
where to_date > curdate()
group by dept_no;



# Show me all the Georgis with the same hire date
# We have 253 people named Georgi
select *
from employees
where first_name = 'Georgi';

# How many distinct hire dates are there for all the Georgis?
# 243 unique hire dates
select distinct hire_date
from employees
where first_name = "Georgi";


# Because the exercise setup changes our level of observation
# from "employees" to "employees with the same hire date"
# then we know that we'll group by the hire_date
# When we group by the hire date, we see 243 unique hire dates
select hire_date
from employees
where first_name = 'Georgi'
group by hire_date;

# Now let's get a count of the number of duplicates
select hire_date, count(*)
from employees
where first_name = 'Georgi'
group by hire_date
order by count(*) DESC;

# How many Georgis share a last name?
# 239 distinct last names for first_name = "Georgi"
select distinct last_name
from employees
where first_name = 'Georgi';

# How do I cound the duplicates?
select last_name, count(*)
from employees
where first_name = 'Georgi'
group by last_name
order by count(*) DESC;