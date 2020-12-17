use employees;

# We want to look up Georgi but we don not remember the spelling of the last part of their name
select *
from employees
where first_name LIKE 'geor%';


select *
from employees
where first_name LIKE '%z%';

# Show us everybody who was hired today, no matter the year
select *
from employees
where hire_date like '%-12-17';


# AND, OR, NOT are our logical operators
# AND operations limit results 
# In real life if you are allergic to X and Y and Z... 
# OR operations expand results
# For lunch, I amm good with pizza or pasta or thai or indian or ...
# ANDs limit/filter our possibilies/results
SELECT *
from employees
where hire_date like '%-12-17'
and birth_date like '%-12-17';

# Compare the above query to the following using OR
# ORs expand our possibilities
SELECT *
from employees
where hire_date like '%-12-17'
OR birth_date like '%-12-17';


# We can also use the NOT operator
select *
from employees
where hire_date not like '%-12-17';

# We can combine and, or, not together... 
# parentheses help us determine the order of operations
# Give me everybody who has a work anniversary or a birthday today (no matter the year)
# but NOT folks who today is both their work anniversary and birthday
select *
from employees
where 
	(hire_date like '%-12-17'
	or 
	birth_date like '%-12-17')	
AND NOT 
	(hire_date like '%-12-17'
	AND 
	birth_date like '%-12-17');
	

# Show the above query but with people whose first name starts with a "b" and their last name starts with a "b".
select *
from employees
where 
	(hire_date like '%-12-17'
	or 
	birth_date like '%-12-17')	
AND NOT 
	(hire_date like '%-12-17'
	AND 
	birth_date like '%-12-17')
AND first_name like 'B%'
AND last_name like 'B%';
	
	

 # Let us cover the IN operator
 # show me the employees that have emp_no of 101010 or 202020 or 12345
 select *
 from employees
 where emp_no IN (101010, 202020, 12345);


 select *
 from employees
 where emp_no = 101010
 or emp_no = 202020 or emp_no = 12345;
 
 # Another example of "IN" operator
 # Select anybody who is in this list of names: [Georgi, Mary, Jane, Bob]
 select *
 from employees
 where first_name IN ('Georgi', 'Mary', 'Jane', 'Bob');
 

# If we want to only show the number of results, not the results themselves
select count(*)
from employees
where first_name IN ('Georgi', 'Mary', 'Jane', 'Bob');
 
 
# Another example of "NOT IN" operator
# Show me everybody who is NOT Georgi, Mary, Jane, or Bob who also has a birthday today.
 # Select anybody who is in this list of names: [Georgi, Mary, Jane, Bob]
 select *
 from employees
 where first_name NOT IN ('Georgi', 'Mary', 'Jane', 'Bob')
 AND birth_date like '%-12-17'


# Examples of using IS NULL and IS NOT NULL together.
select *
from properties_2017
WHERE fireplacecnt IS NOT NULL
AND airconditioningtypeid IS NOT NULL;

select *
from properties_2017
where taxamount < 4000
AND fireplacecnt IS NOT NULL       # needs to have a count for the fireplace value..
AND airconditioningtypeid IS NULL  # ok with missing air conditioning values
LIMIT 10;