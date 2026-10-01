-- Q1.
create database company_sql_test;
use company_sql_test;

-- Q2.
create table departments(department_id int primary key, department_name varchar(50) not null, department_location varchar(50) not null);

create table employees(employee_id int primary key, employee_name varchar(100) not null, department_id int, salary double, 
hire_date date, foreign key(department_id) references departments(department_id));

insert into departments(department_id, department_name, department_location)
values
(1,'HR','Pune'),
(2,'IT','Mumbai'),
(3,'Testing','Delhi'),
(4,'Finance','Pune'),
(5,'Sales','Kolkata');

insert into employees(employee_id, employee_name, department_id, salary, hire_date)
values
(1,'Sakshi',2, 50000, '2024-10-15'),
(2,'Saurabh',2, 60000, '2024-11-11'),
(3,'Vedika',1, 45000, '2024-08-15'),
(4,'Sneha',2, 50000, '2024-05-20'),
(5,'Saras',5, 40000, '2024-01-05'),
(6,'Siddhi',5, 35000, '2025-12-13'),
(7,'Aishwarya',5, 55000, '2025-03-17'),
(8,'Sunidhi',4, 42000, '2025-06-22'),
(9,'Akash',4, 44000, '2026-08-16'),
(10,'Nikhil',1, 60000, '2026-07-09');

-- Q3.
alter table employees add column email varchar(50) not null;
update employees set email="sakshi@gmail.com" where employee_id=1;
update employees set email="saurabh@gmail.com" where employee_id=2;
update employees set email="vedika@gmail.com" where employee_id=3;
update employees set email="sneha@gmail.com" where employee_id=4;
update employees set email="saras@gmail.com" where employee_id=5;
update employees set email="siddhi@gmail.com" where employee_id=6;
update employees set email="aishwarya@gmail.com" where employee_id=7;
update employees set email="sunidhi@gmail.com" where employee_id=8;
update employees set email="akash@gmail.com" where employee_id=9;
update employees set email="nikhil@gmail.com" where employee_id=10;
select * from employees;

-- Q4.
alter table employees add column status varchar(30) default "Active";
update employees set status="Terminated" where employee_id=9;

-- Q5. 
select * from employees where salary between 50000 and 90000 order by salary desc;

-- Q6. 
select * from employees where employee_name like'A%' or employee_name like '%r%';

-- Q7.
select d.department_name, count(e.employee_id) as total_employees
from departments d left join employees e on d.department_id=e.department_id group by d.department_id, d.department_name;

-- Q8.
select d.department_name, AVG(e.salary) AS average_salary from departments d join employees e on d.department_id=e.department_id
group by d.department_id, d.department_name having AVG(e.salary) > 70000;

-- Q9.
select e.employee_name, d.department_name, d.department_location, e.salary from departments d inner join employees e 
on d.department_id=e.department_id;

-- Q10.
select * from employees where salary > (select AVG(salary) from employees);

-- Q11.
select * from employees e1 where e1.salary > (select AVG(e2.salary) from employees e2 where e2.department_id=e1.department_id);

-- Q12.
select d.department_id, d.department_name from departments d where exists (select 1 from employees e where e.department_id=d.department_id);
select d.department_id, d.department_name from departments d where not exists (select 1 from employees e where e.department_id=d.department_id);

-- Q13.
select employee_id, employee_name, department_id, salary, DENSE_RANK() over(partition by department_id order by salary desc)
as salary_dense_rank from employees;

-- Q14.
select employee_id, employee_name, department_id, salary, rank_pos from(select employee_id, employee_name, department_id, salary,
dense_rank() over(partition by department_id order by salary desc) as rank_pos from employees) t where rank_pos <=2;
