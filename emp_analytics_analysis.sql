                --  SQL Practice Questions (Subquery + CTE)
                
-- =========================
-- 🔹 Basic Level
-- =========================

--  Find employees whose salary is greater than the average salary of all employees.
-- subquery
   select * from 
    employees
     where salary>(
                   select avg(salary)
                   from employees);
    
    -- CTE
    with greater_than_avg as (
    select avg(salary) avg_sal
     from employees)
     select * 
      from employees
       where salary>(select avg_sal
                     from  greater_than_avg);

--  Display employees who work in the same department as the highest-paid employee.
-- subquery
SELECT *
FROM employees
WHERE dept_id = (
                 SELECT dept_id
                 FROM employees
				WHERE salary = ( 
								SELECT MAX(salary) 
								FROM employees));


-- CTE
WITH highest_emp AS (
    SELECT dept_id
    FROM employees
    WHERE salary = (SELECT MAX(salary) FROM employees))
SELECT *
FROM employees
WHERE dept_id = (
                 SELECT dept_id 
                 FROM highest_emp);

                    
--  Find employees earning the minimum salary in the company.
-- subquery
select * 
 from employees
 where salary =(
                 select min(salary)
                  from employees);

-- CTE
with min_salary as (
select min(salary) as min_sal
 from employees)
select * 
 from employees
  where salary =(select min_sal
                  from min_salary);

--  Show employees hired after the company’s average hire date.
-- subquery
select *
 from employees
  where hire_date >(
                      select avg(hire_date)
                      from employees);

-- CTE
with avg_hire_date as (
select avg(hire_date) as avg_hire
from employees)
select *
 from employees
  where hire_date >(select avg_hire
                    from avg_hire_date);
 
--  List employees whose salary is above their department’s minimum salary.
-- subquery
select *
from employees e
 where  salary > (select min(salary) 
                 from employees
                 where dept_id=e.dept_id);
 
-- CTE
with min_sal_dept as (
select dept_id,min(salary) as min_sal
 from employees
 group by dept_id)
 select * 
  from employees e
   where salary >(select min_sal
                   from min_sal_dept
                   where dept_id=e.dept_id);
 
 
-- =========================
-- 🔹 Intermediate Level
-- ========================

-- Find employees earning more than their department’s average salary.
-- subquery
select * 
 from employees e
 where salary >(select avg(salary)
                from employees
                where dept_id=e.dept_id
                group by dept_id);

-- CTE
with dept_avg_sal as (
select dept_id,avg(salary) as avg_sal
 from employees
  group by dept_id)
select * 
 from employees e
  where salary>(select avg_sal
                 from dept_avg_sal
                 where dept_id=e.dept_id);

--  Display the second highest salary in the company.
-- subquery
select max(salary)
 from employees
  where salary < (
                  select max(salary)
                   from employees);

-- CTE
with sec_high_salary as (
select max(salary) as max_sal
from employees)
select max(salary)
 from employees
  where salary <(
                  select max_sal
                  from sec_high_salary);

-- Show departments where the average salary is greater than 60,000.
-- subquery
select dept_id,avg(salary) avg_salary
 from employees
 group by dept_id
 having avg_salary>60000;

-- CTE
with avg_sal as (
select dept_id, avg(salary) as avg_salary
 from employees
  group by dept_id)
select dept_id,avg_salary
from avg_sal
where avg_salary>60000;

--  Find employees who belong to departments having more than 3 employees.
-- subquery
SELECT *
FROM employees
WHERE dept_id IN (
                 SELECT dept_id
                 FROM employees
                 GROUP BY dept_id
                  HAVING COUNT(*) > 3);


-- CTE
WITH dept_count AS (
    SELECT dept_id, COUNT(*) AS total_emp
    FROM employees
    GROUP BY dept_id
    HAVING COUNT(*) > 3
)
SELECT *
FROM employees
WHERE dept_id IN (SELECT dept_id FROM dept_count);


-- Display employees whose salary is not equal to the maximum salary of their department.
-- subquery
select * 
 from employees e
where salary <>(
				select max(salary)
                from employees
                where dept_id=e.dept_id
                group by dept_id);

-- CTE
with max_sal as (
select dept_id,max(salary) as max_salary
from employees
 group by dept_id)
 select * 
  from employees e
  where salary<>(select max_salary
                from max_sal
                where dept_id=e.dept_id);

-- =========================
-- 🔹 Advanced Level
-- =========================

--  Find the highest-paid employee in each department.
-- subquery
select * 
 from employees e
 where salary = (select max(salary)
                from employees
                where dept_id=e.dept_id
                group by dept_id);

-- CTE
with high_paid_emp as (
select dept_id,max(salary) as high_paid
from employees
group by dept_id)
select * from employees e
where salary=(select high_paid
              from high_paid_emp
              where dept_id=e.dept_id);

--  Show the top 3 highest-paid employees in the company.
-- subquery 
SELECT *
FROM employees e1
WHERE 3 > (
    SELECT COUNT(DISTINCT salary)
    FROM employees e2
    WHERE e2.salary > e1.salary);

-- CTE
with salary_rank AS (
    select e1.*,
           (select COUNT(DISTINCT e2.salary)
            from employees e2
           where e2.salary > e1.salary) AS higher_count
    from employees e1
)
select *
from salary_rank
where higher_count < 3;

--  Display employees whose salary is between the department average and department maximum salary.
-- subquery
select * 
from employees e
where salary between (select avg(salary)
                       from employees
                       where dept_id=e.dept_id
                       group by dept_id)  
                                        and 
                                (select max(salary)
                                   from employees
                                     where dept_id=e.dept_id
                                           group by dept_id);

-- CTE
with 
salary_avg as (
select dept_id,avg(salary) as avg_sal
from employees
group by dept_id),
max_sal as (
select dept_id,max(salary) as max_salary
from employees
group by dept_id)
select * 
from employees e
where salary between 
				   (select avg_sal
                   from salary_avg
                   where dept_id=e.dept_id)
                             and
                         (select max_salary
                         from max_sal
                         where dept_id=e.dept_id);


--  Find departments where the total salary expense is greater than the company’s average department expense.
-- subquery
select * 
from departments
where dept_id in (
                  select dept_id
                  from employees e
                  group by dept_id
                  having sum(salary) >(select avg(total)
                                      from (select sum(salary) as total
                                             from employees
                                             group by dept_id)t));
        
  -- CTE
  with 
dept_total_sal as (
select dept_id,sum(salary) as total_sal
from employees e
group by dept_id),
avg_total as (
select avg(total) as avg_tol
from (select dept_id,sum(salary) as total
				from employees
				group by dept_id)t) 
select * 
from departments
where dept_id in (
                  select dept_id
                  from dept_total_sal d
                  where total_sal>(
                                   select avg_tol
                                   from avg_total
                                   where dept_id=d.dept_id));
  
--  Show employees who earn more than at least one employee in the Finance department.
select *
from employees
where salary > ANY (
    select salary
    from employees
    where dept_id = (
        select dept_id
        from departments
        where dept_name = 'Finance'
    )
);

-- CTE
WITH finance_salaries AS (
    select salary
    from employees
    where dept_id = (
        select dept_id
        from departments
        where dept_name = 'Finance'
    )
)
select *
from employees
where salary > ANY (select salary from finance_salaries);


--  Find employees whose salary is greater than all employees in the HR department.
select * 
from employees
where salary >(
               select max(salary)
               from employees
               where dept_id in (
                                 select dept_id
                                 from departments
                                 where dept_name='HR'));
               
-- CTE
with max_sal as (
select dept_id,max(salary) max_salary
from employees
group by dept_id),
hr_dept as (
select dept_id,dept_name
from departments)
select * 
from employees 
 where salary>(
                select max_salary
                from max_sal
                where dept_id in (
                                  select dept_id
                                  from hr_dept
                                  where dept_name='HR'));




