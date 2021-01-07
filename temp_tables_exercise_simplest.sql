use ryan;

-- Obtain the average histortic salary and the historic standard deviation of salary
-- Write the numbers down:
-- 63,810 historic average salary
-- 16,904 historic standard deviation
select avg(salary) as avg_salary, std(salary) as std_salary
from employees.salaries	;

create temporary table current_info as (
	select dept_name, avg(salary) as department_current_average
	from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	where employees.dept_emp.to_date > curdate()
	and employees.salaries.to_date > curdate()
	group by dept_name
);

-- Create columns to hold the average salary, std, and the zscore
alter table current_info add average float(10,2);
alter table current_info add standard_deviation float(10,2);
alter table current_info add zscore float(10,2);

update current_info set average = 63810;
update current_info set standard_deviation = 16904;

-- z_score  = (avg(x) - x) / std(x) */
update current_info 
set zscore = (department_current_average - historic_avg) / historic_std;

select * from current_info
order by zscore desc;