--2. Write a query to find for each date the number of different products sold and their names. 
--Column names: (sell_date, product) 
use ecommerce
create table product_details(
	sell_date date,
	product nvarchar(20)
	);


-- insert values into the table
insert into product_details (sell_date, product) values
				('2020-05-30', 'Headphones'),
				('2020-06-01', 'Pencil'), 
				('2020-06-02', 'Mask'),
				('2020-05-30', 'Basketball'),
				('2020-06-01', 'Book'),
				('2020-06-02', ' Mask '),
				('2020-05-30', 'T-Shirt');


--Query to find for each date the number of different products sold and their names
select
    sell_date,
    string_agg(product, ', ') AS product_names
from
    product_details
group by
    sell_date;
