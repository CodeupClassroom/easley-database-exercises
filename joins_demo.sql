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
