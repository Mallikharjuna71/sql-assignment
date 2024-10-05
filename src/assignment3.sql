use ecommerce;

create table dept_tbl(id_deptname nvarchar(20),emp_name nvarchar(15),salary int);


-- insert given records from the table 
insert into dept_tbl (id_deptname,emp_name,salary) values
						('1111-MATH', 'RAHUL', 10000),
						('1111-MATH', 'RAKESH', 20000),
						('2222-SCIENCE', 'AKASH', 10000),
						('2222-SCIENCE', 'ANDREW', 10000),
						('3333-CHEM', 'ANKIT', 25000),
						('3333-CHEM', 'SONIKA', 12000),
						('4444-BIO', 'HITESH', 2300),
						('44-BIO', 'AKSHAY', 10000);

--total salary for each department
select
    right(id_deptname, len(id_deptname) - charindex('-', id_deptname)) as dept_name,
    sum(salary) as total_salary
from dept_tbl
group by right(id_deptname, len(id_deptname) - charindex('-', id_deptname));
