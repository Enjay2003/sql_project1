# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_Project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

-- **SQL RETAIL SALES ANALYSIS- P1**

**Database Setup**
	**1) Database Creation:** The project starts by creating a database named p1_retail_db.
	**2) Table Creation:** A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```
Create database SQL_Project_1;
```


-- **CREATE TABLE**
```
Create Table Retail_Sales (
		transactions_id	INT PRIMARY KEY,
        sale_date DATE,	
        sale_time	TIME,
        customer_id	INT,
        gender	VARCHAR(10),
        age	INT,
        category VARCHAR(15),	
        quantity INT,	
        price_per_unit	FLOAT,
        cogs FLOAT,
        total_sale FLOAT
        );
 ```       

-- **DATA CLEANING**

```
Select * From Retail_Sales
Where 
	transactions_id is null
    or
    sale_date is null	
    or
    sale_time is null
	or
    customer_id	is null
    or
    gender is null	
    or
    age is null	
    or
    category is null	
    or 
    quantity is null		
    or
    price_per_unit is null		
    or
    cogs is null		
    or
	total_sale is null;
```

-- **DATA EXPLORATION**
	**1) Record Count:** Determine the total number of records in the dataset.
	**2)  Customer Count:** Find out how many unique customers are in the dataset.
	**3) Category Count:** Identify all unique product categories in the dataset.
	**4) Null Value Check:** Check for any null values in the dataset and delete records with missing data.

-- **Q1) Total Sales?**
```
Select Count(*) From retail_sales;
```

-- **Q2) How many Unique customers?**
```
Select Count(Distinct customer_id) 
From retail_sales;
```

-- **Q3) How many Categories?**
```
Select Count(Distinct category) 
From retail_sales;
```

-- **DATA ANALYSIS**

-- **Questions:**

-- Q1) Write a SQL query to find out total number of sales per each category.
-- Q2) Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- Q3) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
-- Q4) Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q5) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q6) Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q7) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q8) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
-- Q9) Write a SQL query to find the top 5 customers based on the highest total sales.
-- Q10) Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q11) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).


-- **Q1) Write a SQL query to find out total number of sales per each category.**
```
Select category, Count(category) 
From retail_sales 
Group by category;
```

-- **Q2) Write a SQL query to retrieve all columns for sales made on '2022-11-05'.**
```
Select *
From retail_sales
Where sale_date = '2022-11-05';
```

-- **Q3) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.**
```
Select *
From retail_sales
Where category = 'Clothing' 
	and quantity >= '4' 
    and month(sale_date) = 11
    and year(sale_date) = 2022;
```

-- **Q4) Write a SQL query to calculate the total sales (total_sale) for each category.**
```
Select category, sum(total_sale) as net_sales 
From retail_sales 
Group by category;
```

-- **Q5) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```
Select gender, round(avg(age),2) as average_age
From retail_sales
where category = 'Beauty'
Group by gender;
```

-- **Q6) Write a SQL query to find all transactions where the total_sale is greater than 1000.**
```
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

-- **Q7) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
```
Select category,
	gender,
    count(total_sale) as no_of_transactions
From retail_sales
Group by
category, gender
ORDER BY 1;
```

-- **Q8) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**
```
Select year,
		month,
        avg_sales
From (
	Select year(sale_date) as year, 
    month(sale_date) as month,
	avg(total_sale) as avg_sales,
    Rank() over(
			Partition by year(sale_date)
            Order by avg(total_sale) desc
		) as rnk
        From retail_sales
        Group by year(sale_date), month(sale_date)
	) as t;
```

-- **Q9) Write a SQL query to find the top 5 customers based on the highest total sales.**
```
Select 
	customer_id,
    sum(total_sale) as total_sales
From retail_sales
Group by customer_id
Order by total_sales desc
Limit 5;
```

-- **Q10) Write a SQL query to find the number of unique customers who purchased items from each category.**
```
Select category,
	count(Distinct customer_id) as no_of_unique_customers
From retail_sales
Group by 1;
```

-- **Q11) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).**
```
Select 
	Case
		When hour(sale_time) < 12 Then 'Morning'
        When hour(sale_time) between 12 and 17 Then 'Afternoon'
        Else 'Evening'
	End as shift,
Count(*) as total_orders
From retail_sales
Group by 1;
```

**Findings**
- **Customer Demographics:** The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions:** Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends:** Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights:** The analysis identifies the top-spending customers and the most popular product categories.

**Reports**
- **Sales Summary:** A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis:** Insights into sales trends across different months and shifts.
- **Customer Insights:** Reports on top customers and unique customer counts per category.

**Conclusion**
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
