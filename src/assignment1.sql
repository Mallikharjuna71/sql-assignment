
--1create database ecommerce

create database ecommerce
use ecommerce

--2.Create 4 tables (gold_member_users, users, sales, product) under the above database(ecommerce)

create table gold_member_users(userid nvarchar(20), signup_date Date);

create table users(userid nvarchar(20), signup_date Date);

create table sales(userid nvarchar(20), created_date Date, product_id INT);

create table product(product_id INT, product_name varchar(15), price INT);

3--Insert the values above four tables

insert into gold_member_users values('John','2017-09-22'),('Mary','2017-04-21');

insert  into users values('John', '2014-09-02'),('Michel', '2015-01-15'),('Mary', '2014-04-11');

insert into sales values('John','04-19-2017',2),('Mary','12-18-2019',1),('Michel','07-20-2020',3),
						('John','10-23-2019',2),('John','03-19-2018',3),('Mary','12-20-2016',2),
						('John','11-09-2016',1),('John','05-20-2016',3),('Michel','09-24-2017',1),
						('John','03-11-2017',2),('John','03-11-2016',1),('Mary','11-10-2016',1),
						('Mary','12-07-2017',2);

insert into product values(1,'Mobile',980),(2,'Ipad',870),(3,'Laptop',330);

--4.Show all the tables in the same database(ecommerce)
SELECT * FROM ecommerce.INFORMATION_SCHEMA.TABLES;

--5.Count all the records of all four tables using single query
select
	(select count(*) from gold_member_users) as gold_member_users_count,
	(select count(*) from users)as users_count,
	(select count(*) from sales)as sales_count,
	(select count(*) from product)as product_count;

--6.What is the total amount each customer spent on ecommerce company
select u.userid, sum(p.price) as total_spendings
from users u 
inner join sales s on u.userid = s.userid 
inner join product p on p.product_id = s.product_id
group by u.userid


-- 7.Find the distinct dates of each customer visited the website: output should have 2 columns date and customer name

select distinct created_date,userid from sales group by userid, created_date;


--8.Find the first product purchased by each customer using 3 tables(users, sales, product)
select u.userid, p.product_name, min(s.created_date)
from users u 
inner join sales s on u.userid = s.userid 
inner join product p on p.product_id = s.product_id
group by u.userid, s.created_date, p.product_name
having s.created_date = (select min(created_date)
                        from sales
                        where sales.userid = u.userid)
order by u.userid;

--9.What is the most purchased item of each customer and how many times the customer has purchased it: 
--output should have 2 columns count of the items as item_count and customer name

select distinct u.userid, count(*) as item_count
from users u 
inner join sales s on u.userid = s.userid 
inner join product p on p.product_id = s.product_id
group by u.userid,p.product_id, p.product_name
having count(p.product_id) = (
								select max(purchases) 
								from (select count(product_id)as purchases
								from sales
								where u.userid = sales.userid
								group by sales.product_id)as pc
								)
order by u.userid;

--10.Find out the customer who is not the gold_member_user
select userid from users where userid not in (select userid from gold_member_users);

--11.What is the amount spent by each customer when he was the gold_member user
select u.userid, sum(p.price) as total_spendings
from gold_member_users u 
inner join sales s on u.userid = s.userid 
inner join product p on p.product_id = s.product_id
group by u.userid;


--12.Find the Customers names whose name starts with M
select userid from users where userid like 'M%';

--13.Find the Distinct customer Id of each customer
select distinct userid from users;

--14.Change the Column name from product table as price_value from price
EXEC sp_rename  'product.price', 'price_value', 'COLUMN';

--15.Change the Column value product_name � Ipad to Iphone from product table
update product set product_name = 'Iphone' where product_name = 'Ipad';

--16.Change the table name of gold_member_users to gold_membership_users
EXEC sp_rename  'gold_member_users', 'gold_membership_users';

--17.Create a new column as Status in the table crate above gold_membership_users the Status values should be 
-- Yes and No if the user is gold member, then status should be Yes else No.
ALTER TABLE gold_membership_users add status nvarchar(3) default 'No';

--18 Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention the 
--result when performed roll back
begin transaction;
delete from users where userid='John';
rollback
begin transaction;
delete from users where userid='Mary'
rollback

--19  Insert one more record as same (3,'Laptop',330) as product table
insert into product values(3,'Laptop',330);

--20. Write a query to find the duplicates in product table
select product_id
from product
group by product_id
having count(*) > 1; 








