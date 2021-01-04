



In the employees database:
- What's the relationship between the employees table and the salaries table?
    - The salaries table has an emp_no column that references the emp_no on employees table.
    - We can see this in Sequel Pro underneath the "relationships" menu
    - We can also see this relationship in the "table info" for salaries table
    - and if we did "SHOW CREATE TABLE salaries", we'd get the same info as "table info" view
    - In SQL, we call this a "one to many" relationship. Because one single employee (identified by one single emp_no) has multiple salary records associated w/ them.
- Consider that the titles table has an identical relationship as with the salaries table to employees table.
    - One employee has many titles (over time). So one emp_no has (potentially) multiple rows on the titles table associated w/ them
    - "one to many relationship" as well.. 

- What's the relationship between employees and departments?
    - It's not direct. They don't share any keys in common
    - While there's no direct relationship between these 2 tables, exploration yields insight
    - When we explored the dept_emp, we saw that it had two foreign keys, one to point to a dept_no and another to point to an emp_no
    - This kind of relationship is called a "many to many" relationship.
        - Signs you have a many to many relationship:
            - You have 2 unrelated tables and a 3rd table that contains all the keys that relate those two tables
            - In English, we can ask: 
                - Can one employee belong to multiple departments over time?
                - Can one department have multiple employees?
- There's another relationship between employees and departments.. 
    - That association is the associative table called dept_manager
    - Dept manger associates department numbers w/ the emp_no of the individual managing that department.
    - Can one department have multiple managers? Yes, over time.. 
    - Can one individual manage multiple departments? Yes.
