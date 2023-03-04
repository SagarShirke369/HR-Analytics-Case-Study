use employees


/* Q1: Total number of employees */
select count(ID) as 'Total Employees'
from employee;


/* Q2: Gender ratios */
SELECT 
    COUNT(CASE
        WHEN gender = 'M' THEN 1
    END) AS 'Total Male Employees',
    COUNT(CASE
        WHEN gender = 'F' THEN 1
    END) AS 'Total Female Employees',
    COUNT(*) AS 'Total Employees'
FROM
    employee;


/* Q3: How many managers are there currently in the company? */
select employee.ID, employee.first_name, title.title, department.dept_name as 'dept_managers '
FROM employee
JOIN title ON employee.ID = title.employeeID 
JOIN department_employee ON title.employeeID = department_employee.employeeID
JOIN department ON department_employee.departmentID = department.dept_ID;


/* Q4: Number of employees in each department */
select department.dept_name, count( department_employee.employeeID) as 'Number of employees'
from department_employee
inner join department
on department_employee.departmentID = department.dept_ID
group by dept_name;


select departmentID as Departments, count(employeeID) as 'Number of employees'
from department_employee
group by departmentID;


select employee.ID, employee.first_name, title.title, department.dept_name as 'dept_managers '
FROM employee
JOIN title ON employee.ID = title.employeeID 
JOIN department_employee ON title.employeeID = department_employee.employeeID
JOIN department ON department_employee.departmentID = department.dept_ID;


/* Q5: Gender ratios in each department */
SELECT department.dept_name as Department, 
       sum(CASE WHEN employee.gender = 'M' THEN 1 ELSE 0 END) AS total_male_employees,
       sum(CASE WHEN employee.gender = 'F' THEN 1 ELSE 0 END) AS total_female_employees
FROM department
JOIN department_employee ON department.dept_ID = department_employee.departmentID
JOIN employee ON department_employee.employeeID = employee.ID
group by dept_name;


/* Q6: Number of employees with each title */
select title.title, count(employee. ID)
from employee
join title
on employee.ID = title.employeeID
group by title; 


/* Q7: Salary amount statistics */
select min(amount), max(amount), avg(amount), stddev(amount)
from salary;


/* Q8: Gender ratios in each title */
select title.title,
	   sum(case when employee.gender= 'M' then 1 else 0 end ) as 'total male employee',
	   sum(case when employee.gender= 'F' then 1 else 0 end) as 'total female employee'
from title
join employee
on title.employeeID = employee.ID
group by title;


/* Q9: See all the employment profile ordered by employee ID, including salary, department and title changes */
select employee.ID, employee.first_name as Name, title.title as Designation, department.dept_name as Department, employee.hire_date as DOJ, salary.amount as Salary
from employee
 JOIN title ON employee.ID = title.employeeID
 JOIN salary ON title.employeeID = salary.employeeID
 JOIN department_employee ON salary.employeeID = department_employee.employeeID
 JOIN department ON department_employee.departmentID = department.dept_ID
 order by ID;


/* Q10: What is the full name of the employee with the highest salary? */
select employee.ID, concat(employee.first_name, ' ' , employee.last_name) as 'Name', salary.amount as 'salary'
from employee
join salary
on employee.ID = salary.employeeID
order by salary desc;


/* Q11: Which title has the least number of current employees? */
SELECT 
  title,
  COUNT(*) AS total_count
FROM title
GROUP BY 1
ORDER BY 2
LIMIT 5;


/* Q12: Which title has the highest average salary for male employees? */
SELECT title.title as Designation, employee.first_name as Emp_Name, salary.amount as Salary
FROM employee
JOIN title ON employee.ID = title.employeeID
JOIN salary ON title.employeeID = salary.employeeID
WHERE gender = 'M'
GROUP BY Designation
ORDER BY Salary desc;


/* Q13: Which title has the highest average salary for female employees? */
SELECT title.title as Designation, employee.first_name as Emp_Name, salary.amount as Salary
FROM employee
JOIN title ON employee.ID = title.employeeID
JOIN salary ON title.employeeID = salary.employeeID
WHERE gender = 'F'
GROUP BY Designation
ORDER BY Salary desc;


/* Q14: Which department has the most female employees? */
select department.dept_name as 'Department', count(employee.gender) as 'Number of Female Employee'
from employee
join department_employee on employee.ID = department_employee.employeeID
join department on department_employee.departmentID = department.dept_ID
where gender = 'F'
group by dept_name
order by 'Number of Female Employee' desc
Limit 1;


/* Q15: What is the largest difference between minimum and maximum salary values for all current employees? */
with min_max_salary AS (
SELECT MIN(amount) AS minimum_salary, MAX(amount) AS maximum_salary
FROM salary)
SELECT maximum_salary - minimum_salary AS range_value
FROM min_max_salary;


/* Q16: Fetch the first 2 employee from each department to join employee  */
SELECT *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (partition by dept_name order by employee.ID) AS rn
  FROM employee
  JOIN department_employee ON employee.ID = department_employee.employeeID
  JOIN department ON department_employee.departmentID = department.dept_ID 
) AS x
WHERE x.rn <= 2;



/* Q17: Fetch the top4 employee in each department earning the maximum salary using rank function */
with my_cte as(
select employee.first_name, department.dept_name, salary.amount
from employee
JOIN salary ON employee.ID = salary.employeeID 
JOIN department_employee ON salary.employeeID = department_employee.employeeID
JOIN department ON department_employee.departmentID = department.dept_ID)
select * from(
select my_cte.*,
rank() over (partition by dept_name order by amount desc)
as rnk
from my_cte)x
where x.rnk < 5;


/* Q18: Fetch the top3 employee in each department earning the maximum salary using dense_rank function */
with my_cte as(
select employee.first_name, department.dept_name, salary.amount
from employee
JOIN salary ON employee.ID = salary.employeeID 
JOIN department_employee ON salary.employeeID = department_employee.employeeID
JOIN department ON department_employee.departmentID = department.dept_ID)
select * from(
select my_cte.*,
dense_rank() over (partition by dept_name order by amount desc)
as dense_rnk
from my_cte)x
where x.dense_rnk < 5;


/* Q19: Fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee */
WITH my_cte AS (
  SELECT 
    employee.ID, 
    employee.first_name, 
    department.dept_name, 
    salary.amount
  FROM 
    employee
    JOIN salary ON employee.ID = salary.employeeID 
    JOIN department_employee ON salary.employeeID = department_employee.employeeID
    JOIN department ON department_employee.departmentID = department.dept_ID
)
SELECT 
  my_cte.*,
  LAG(amount, 1, 0) OVER (PARTITION BY dept_name ORDER BY amount) AS prev_employee_salary
FROM 
  my_cte;


WITH my_cte AS (
  SELECT 
    employee.ID, 
    employee.first_name, 
    department.dept_name, 
    salary.amount
  FROM 
    employee
    JOIN salary ON employee.ID = salary.employeeID 
    JOIN department_employee ON salary.employeeID = department_employee.employeeID
    JOIN department ON department_employee.departmentID = department.dept_ID
)
SELECT 
  my_cte.*,
  lead(amount, 1, 0) OVER (PARTITION BY dept_name ORDER BY amount) AS Next_employee_salary
FROM 
  my_cte;
  

/* Q20: New employee join in year 2020 to 2022 */
SELECT ID, first_name
FROM employee
WHERE YEAR(hire_date) = 2020;


SELECT YEAR(hire_date) AS year, COUNT(first_name) AS count_of_employee
FROM employee
WHERE YEAR(hire_date) IN (2020, 2021, 2022)
GROUP BY YEAR(hire_date);




