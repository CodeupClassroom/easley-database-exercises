
/* Exercise 3
Find out how the current average pay in each department compares to the overall, historical average pay. 
In order to make the comparison easier, you should use the Z-score for salaries. 
In terms of salary, what is the best department right now to work for? The worst? 
z_score  = (avg(x) - x) / std(x) */

use ryan;

-- Produce the query to get current avg and current stddev
-- 72,012 is the average
-- 17,309 is the standard deviation
select avg(salary) as avg_salary, std(salary) as std_salary
from employees.salaries	
where employees.salaries.to_date > curdate()

-- Create a table to hold the results
create table current_aggregates as (
    select avg(salary) as avg_salary, std(salary) as std_salary
    from employees.salaries	
    where employees.salaries.to_date > curdate()
);

select * from current_aggregates;

create table current_info as (
	select dept_name, avg(salary) as department_current_average
	from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	where employees.dept_emp.to_date > curdate()
	and employees.salaries.to_date > curdate()
	group by dept_name
);

select * from current_info;

alter table current_info add current_company_avg float(10,2);
alter table current_info add current_company_std float(10,2);
alter table current_info add current_company_zscore float(10,2);

select * from current_info;

update current_info set current_company_avg = (select avg_salary from current_aggregates);
update current_info set current_company_std = (select std_salary from current_aggregates);

select * from current_info;

update current_info 
set current_company_zscore = (department_current_average - current_company_avg) / current_company_std;

select * from current_info;

-- Now, let's calculate historic stuff!

-- Historic average and standard deviation
-- 63,810 historic average salary
-- 16,904 historic standard deviation
create table historic_aggregates as (
	select avg(salary) as avg_salary, std(salary) as std_salary
	from employees.salaries	
);

create table historic_info as (
	select dept_name, avg(salary) as department_historic_average
	from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	group by dept_name
);

alter table historic_info add historic_company_avg float(10,2);
alter table historic_info add historic_company_std float(10,2);
alter table historic_info add historic_company_zscore float(10,2);

update historic_info set historic_company_avg = (select avg_salary from historic_aggregates);
update historic_info set historic_company_std = (select std_salary from historic_aggregates);

update historic_info 
set historic_company_zscore = (department_historic_average - historic_company_avg) / historic_company_std;


select dept_name, historic_company_zscore, current_company_zscore
from historic_info
join current_info using(dept_name);