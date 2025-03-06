Create Database Retail_Sales_Analysis;

create table Retail_Sales
	(
		transactions_id	INT PRIMARY KEY,
        sale_date DATE,
        sale_time TIME,
        customer_id	INT,
        gender	VARCHAR(15),
        age	INT,
        category VARCHAR(20),	
        quantity INT,
        price_per_unit FLOAT,	
        cogs FLOAT,
        total_sale float
	);
    
Select * from retail_sales;

-- Since data is clean we start with Data Exploration & Simple Analysis

-- DATA EXPLORATION

-- Q1) What are the total sales?
-- Ans) To find total number of sales:

Select count(*) as total_sale from retail_sales;

-- Q2) What are the different categories?
-- Ans) 

Select Distinct category from retail_sales;

-- Q3) Write a SQL query to retrieve no. of rows for sales made on '2022-12-16'.
-- Ans) 
Select * from retail_sales where sale_date = '2022-12-16';

-- Q4) Write a SQL query to retrieve total sales for categories.
-- Ans)
SELECT category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales GROUP BY 1;

-- Q5) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Ans)
Select Avg(Age) as avg_age from retail_sales where category = 'Beauty';

-- Q6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Ans)
Select category,
	   gender,
	count(transactions_id) as number_of_sales
	from retail_sales 
    Group by category,
			 gender
    order by 1;

-- Q7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Ans)

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as 'rank'
FROM retail_sales
GROUP BY 1, 2
) as t1;







