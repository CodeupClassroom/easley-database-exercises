
# Limit is a clause that follows the rest of the query you have built
# Simple query? Put limit at the end.
# Complex query? Put limit at the end.
select *
from employees LIMIT 10;

# show salaries between the range
# order by salary
# Show the first 100
select *
from salaries
where salary between 67000 and 71000
order by salary ASC
LIMIT 100;

# Take the above query and show the last 100..
# reverse our order by
# add the limit
select *
from salaries
where salary between 67000 and 71000
order by salary DESC
LIMIT 100;


# Let us take a look at the first 10 employees (ordered by emp_no)
# If we show 10 employees per page.. This is the first page of results.
# This shows emp_no 10001 through 10010.
select *
from employees
limit 10 offset 0; # "offset 0" is the default

# Let us get the same results, but the "second page"
# Where the results are the next ten rows.
# This shows emp_no 10011 through 10020.
select *
from employees
limit 10 offset 10; # offset 10, limit 10 shows "page 2" of the results

# Page 3 of the results of what we did above
select *
from employees
limit 10 offset 20;

