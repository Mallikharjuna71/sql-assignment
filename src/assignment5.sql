use ecommerce

--1.create a table named sales_data with columns: product_id, sale_date, and quantity_sold.
create table sales_data (product_id int,sale_date date,quantity_sold int );

--2.insert some sample data into the table:
insert into sales_data(product_id, sale_date, quantity_sold)
			values
			(1, '2022-01-01', 20),
			(2, '2022-01-01', 15),
			(1, '2022-01-02', 10),
			(2, '2022-01-02', 25),
			(1, '2022-01-03', 30),
			(2, '2022-01-03', 18),
			(1, '2022-01-04', 12),
			(2, '2022-01-04', 22);

--3.assign rank by partition based on product_id and in each product id find the lowest sold quantity

select *, 
		rank() over (partition by product_id order by quantity_sold)as rank,
		min(quantity_sold) over (partition by product_id)as min_sold

from sales_data

--4) Retrieve the quantity_sold value from a previous row and compare the quantity_sold.
select
    product_id,
    sale_date,
    quantity_sold,
    lag(quantity_sold) over (order by product_id, sale_date) as prev_quantity
from
	sales_data;


--5) Partition based on product_id and return the first and last values in ordered set.
/*
with RankedSales as (
    select 
        product_id,
        sale_date,
        quantity_sold,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY sale_date ASC) AS FirstRow,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY sale_date DESC) AS LastRow
    from 
        sales_data
)

select 
    product_id,
    MAX(CASE WHEN FirstRow = 1 THEN sale_date END) AS first_sale_date,
    MAX(CASE WHEN LastRow = 1 THEN sale_date END) AS last_sale_date,
    MAX(CASE WHEN FirstRow = 1 THEN quantity_sold END) AS first_sale_amount,
    MAX(CASE WHEN LastRow = 1 THEN quantity_sold END) AS last_sale_amount
from 
    RankedSales
group by 
    product_id
order by 
    product_id;

*/

select
    product_id,
	sale_date,
    FIRST_VALUE(quantity_sold) OVER (PARTITION BY product_id ORDER BY sale_date) AS first_quantity,
    LAST_VALUE(quantity_sold) OVER (PARTITION BY product_id ORDER BY sale_date) AS last_quantity
from
    sales_data;
