create database if not exists Walmart;
create table sales( 
invoice_id varchar(35) not null primary key,
branch varchar (6) not null,
city varchar (35) not null,
customer_type varchar (35) not null,
gender varchar(15) not null,
product_line varchar(50) not null,
unit_price decimal (5,2) not null,
quantity int not null,
VAT float (6,4) not null,
total decimal (12,4) not null,
date datetime not null,
time TIME not null,
payment_method varchar (20) not null,
cogs decimal (5,2) not null,
gross_margin_pct float (11,9) not null,
gross_income decimal (9,4) not null,
ratings float (2,1) not null

);

-- -----DESCRIBE AND SELECT ALL-----------------
describe sales;
select * from sales;



-- ---------------------------------------------------------------------------------------------------------------------
-- -------------------------------------FEATURE ENGINEERING-------------------------------------------------------------


-- TIME OF THE DAY
SELECT 
 time ,
( case 
when 'time' between "00:00:00" and "12:00:00" then "morning"
when 'time' between "12:01:00" and "16:00:00" then "afternoon" 
ELSE "evening"
end
)as time_of_the_date
from sales;



-- --------------------------------------------------------------------------------------------------------------------------------------------

alter table sales
 add column time_of_day varchar(20);
update sales
set time_of_day =(case 
when 'time' between "01:00:00" and "12:00:00" then "morning"
when 'time' between "12:01:00" and "16:00:00" then "afternoon" 
else "evening"
end
);

-- --DAY NAME 
select date,
dayname(date) as day_name
FROM SALES;

alter table sales
 add column day_name varchar (20);
 update sales
 set day_name= dayname(date);
 
 -- --------MONTH NAME--------------------------------------------------------------
 SELECT date,
 monthname(date)
 from sales;
 
 alter table sales
 add column month_name varchar (15);
 update sales
 set month_name= monthname(date);
 -- ---------------------------------------------------------------------------------------------
 
 -- ----------------GENERIC--------------------------------------------------------------------
 -- ---------------------------------------------------------------------------------------------
 -- -How many distinct cities are present in the dataset?
 select distinct city 
 from sales;
 
 
 -- In which city is each branch situated?
 select  distinct branch
 from sales;
 
 select distinct city,branch
 from sales;
 
 -- ----------------------------------------------------------------------------------------------------------------
 -- ---------------------------------------PRODUCT---------------------------------------------------------------
 -- 	How many distinct product lines are there in the dataset?
 SELECT  count( distinct product_line)
 from sales;
 
 -- What is the most common payment method?-----------------------------------------------
 select 
 payment_method,
 count(payment_method)as cnt
 from sales
 group by payment_method
 order by cnt desc;
 
 -- ----------------------------------------------------------------------------------------------
 
 -- -What is the most selling product line?-----------------------------------------------------
 select product_line,
 count(product_line) as cnt
 from sales
 group by product_line
 order by cnt desc;
 
 -- -------------------------------------------------------------------------------------------------------------
 
 -- What is the total revenue by month?---------------------------------------------------------------------------
 select month_name as month,
 sum(total) as total_revenue
 from sales
 group by month_name
 order by total_revenue desc;

-- -----------------------------------------------------------------------------------------------------------------

-- ---------Which month recorded the highest Cost of Goods Sold (COGS)?----------------------------------------------
SELECT
 month_name as month,
 sum(cogs) as cogs
 from sales
 group by month_name
 order by cogs desc;
 
 -- --------------------------------------------------------------------------------------------------
 
 -- Which product line generated the highest revenue?-------------------------------------------------
 select product_line,
 sum(total)as total_revenue
 from sales
 group by product_line
 order by total_revenue desc;
 
 -- ----------------------------------------------------------------------------------------------------------------------
 -- Which city has the highest revenue?------------------------------------------------------------------------------------
 select city,branch,
sum( total)as total_revenue
 from sales
 group by city,branch
 order by total_revenue desc;
 
 -- ----------------------------------------------------------------------------------------------------------------
 -- Which product line incurred the highest VAT?--------------------------------------------------------------------
 select product_line,
 avg(VAT) as avg_vat
 from sales
 group by product_line
 order by avg_vat asc;
 
 -- ------------------------------------------------------------------------------------------------------------------------
 -- ---Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its sales are above the average.
 
 
 
 
 -- ---------------------------------------------------------------------------------------------------------------------------------------------
 
 -- Which branch sold more products than average product sold?---------------------------------------------
 select 
 branch,
 sum(quantity) as qty
 from sales
 
 group by branch
 order by qty ;
 
 -- -----------------------------------------------------------------------------------------------------------------
 -- ---What is the most common product line by gender?----------------------------------------------------------
 select
 gender,
 count(gender) as total_cnt,
 product_line
 from sales
group by gender,product_line
order by total_cnt desc;

-- -----------------------------------------------------------------------------------------------------------------------------
-- -------What is the average rating of each product line?------------------------------------------------------------------------
select 
round (avg(ratings),2) as avg_ratings,
product_line
from sales
group by product_line
order by avg_ratings desc;

-- ----------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------SALES-----------------------------------------------------------------------------------
-- -------- Number of sales made in each time of the day per weekday---------------------------------------------------------------
 
 SELECT
 time_of_day,
 count(*) as total_sales
 FROM SALES
 where day_name= "monday"
 group by time_of_day
 order by total_sales;
 
 -- --------------------------------------------------------------------------------------------------------------------
 
 -- ------Identify the customer type that generates the highest revenue.---------------------------------------------------
 select customer_type,
 sum(total) as total_revenue
 from sales
 group by customer_type
 order by total_revenue desc;
 
 -- ---------------------------------------------------------------------------------------------------------------------------
 
 -- Which city has the largest tax percent/ VAT (Value Added Tax)?------------------------------------------------------------
 
 select city,
avg ( VAT) as total_vat
 from sales
 group by city
 order by total_vat desc;
 
 -- --------------------------------------------------------------------------------------------------
 -- -------------Which customer type pays the most VAT?-------------------------------------------
 select customer_type,
 sum(VAT) AS vat_rate
 from sales
 group by customer_type
 order by vat_rate desc;
 
 select gender,
 sum(VAT) as vat_rate
 from sales
 group by gender
 order by vat_rate desc;
 
 -- --------------------------------------------------------------------------------------------------------------
 
 -- ----------------------------CUSTOMER ANALYSIS----------------------------------------------------------------
 -- ---How many unique customer types does the data have?----------------------------------------------------------
 SELECT customer_type,
 count(customer_type)
 from sales
 group by customer_type;
 
 -- ---------------------------------------------------------------------------------------------------------
 
 -- ----------How many unique payment methods does the data have?--------------------------------------------
 select payment_method,
 count(payment_method)
 from sales
 group by payment_method;
 
 -- ---------------------------------------------------------------------------------------------------------------------
 
 -- ------------Which is the most common customer type?-----------------------------------------------------------------
 -- -------------Which customer type buys the most?-----------------------------------------------------------------------
 select customer_type,
 count(customer_type) AS cnt
 from sales
 group by customer_type
 order by customer_type desc;

-- ---------------------------------------------------------------------------------------------------------
-- -----------------------What is the gender of most of the customers?---------------------------------------
select gender,
 count(customer_type) as cnt
 from sales
 group by gender
 order by cnt desc;
 -- ---------------------------------------------------------------------------------------------------
 
 -- ---------What is the gender distribution per branch?-----------------------------------------------
 
 select gender,
 count(branch) as cnt
 from sales
 where branch ="c"
 group by gender
 order by cnt desc;
 -- ------------------------------------------------------------------------------
 -- ----------Which time of the day do customers give most ratings?------------------------
  select time_of_day,
 avg(ratings) as avg_ratings
 from sales
 group by time_of_day
 
 
 
 