----------------------------------------------------
-- PROJECT : HR EMPLOYEE DATA ANALYSIS
-- AUTHOR  : RAKSHANA SUBRAMANIAN
-- TOOL    : ORACLE SQL
-- DATE    : MAY 2026
-----------------------------------------------------

-- Question 1 - Total number of employees
Select count(*) from HR_employees;

-- Question 2 - Employees per department
Select count(*) as total_employees ,department from HR_employees group by department;

-- Question 3 - Employees left the company
Select count(*) as Employees_resigned from HR_employees where Attrition = 'Yes';

-- Question 4 - Top 5 Highest paid employees
Select EmployeeNumber, MonthlyIncome from(select EmployeeNumber, MonthlyIncome from HR_employees ORDER by MonthlyIncome desc)where rownum<=5;

-- Question 5 - Average salary of employees in each department
select department, Avg(MonthlyIncome) from HR_employees group by department;

-- Question 6 - highest and lowest salary in entire company
select min(MonthlyIncome) as Lowest_salary , max(MonthlyIncome)as Highest_salary from HR_employees;

-- Question 7 - departments have more than 100 employees
select department, count(employeeNumber) from HR_employees group by department Having count(employeeNumber)>100;

--Question 8 - employees works as Manager
select Jobrole,count(employeenumber) from HR_employees where jobrole like '%Manager%' group by jobrole;

-- Question 9 - employees aged between 30 and 40
select emp_age,employeenumber from HR_employees where emp_age between 30 and 40;

-- Question 10 - Categorize salaries
select employeenumber, MonthlyIncome, Case when MonthlyIncome>15000 then 'High' when MonthlyIncome between 8000 and 15000 then 'Medium' else 'Low' End as Employee_category from HR_employees;

-- Question 11 - Employees who earn more than average salary of the company
select EmployeeNumber,MonthlyIncome from HR_employees where MonthlyIncome>(select avg(MonthlyIncome) from HR_employees);

-- Question 12 - Find Attrition rate by department - How many left vs total in each department
select department,count(Attrition) as Total from HR_employees where Attrition = 'Yes' group by department;

-- Question 13 - Rank employees by salary
select EmployeeNumber,department,MonthlyIncome,Rank() over(partition by department order by MonthlyIncome desc) as Rank from HR_Employees;

-- Question 14 - Find years at company for each employee
select EmployeeNumber,Nvl(Yearsatcompany,0) as Total_years from HR_employees;

-- Question 15 - Show department, Total employees, average salary, total attrition together in one query
select department,count(employeeNumber) as Total_employees ,round(avg(MonthlyIncome),2) as Average_salary,sum(case when Attrition ='Yes' then 1 else 0 end) as Total_attrition from HR_employees group by department;

-- Question 16 - Show gender wise employee count
select gender,count(employeenumber) from HR_employees group by gender;

--Question 17 - Average age by department
select department,round(avg(emp_age),2) as Average_age from HR_employees group by department;

--Question 18 - Department with highest attrition
select department,count(attrition) from HR_employees where attrition = 'Yes' group by department order by count(attrition) desc fetch first 1 row only;

-- Creating department table for join practice
create table department_info(dept_id number primary key,dept_name varchar2(30), dept_loaction varchar2(20));

-- Inserting data
Insert into department_info(dept_id,dept_name,dept_loaction) values(1,'Sales','Chennai');
Insert into department_info(dept_id,dept_name,dept_loaction) values(2,'Research&development','Bangalore');

set define off; -- This tells oracle to ignore symbol
update department_info set dept_name= 'Research & Development' where dept_id=2;
commit;

Insert into department_info(dept_id,dept_name,dept_loaction) values(3,'Human Resources','Mumbai');
Insert into department_info(dept_id,dept_name,dept_loaction) values(4,'Finance','Delhi');

-- Question 19 - employees with department location
select e.employeenumber,e.department,d.dept_loaction from HR_employees e inner join department_info d on e.department=d.dept_name order by department asc;
 
-- Question 20 - Show all departments including those with no employees
select e.employeenumber,e.department,d.dept_loaction from HR_employees e left join department_info d on e.department=d.dept_name;

-- creating a view
create view High_salary_employees as select employeenumber,department,MonthlyIncome from HR_employees where Monthlyincome>10000;

select * from High_salary_employees;
