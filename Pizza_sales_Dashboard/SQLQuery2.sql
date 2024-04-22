/* To show the whole table */
select * from pizza_sales
/* Total revenue */
select SUM(total_price) as Total_revenue from pizza_sales
/* Average order value, defined as total revenue/Total orders */
select SUM(total_price)/COUNT( distinct order_id ) as Average_order_value from pizza_sales
/* Total pizzas sold, ie sum of quantity */
select SUM(quantity) as Total_pizza_sold from pizza_sales
/* Total orders */
select COUNT(distinct order_id) as Total_orders from pizza_sales
/* Avg pizzas per order, use CAST to get decimal value upto 2 */
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_pizza_per_order from pizza_sales
/* daily trend of orders (ie, by days) */
select DATENAME(DW,order_date) as order_day, COUNT(distinct order_id) as Total_orders from pizza_sales Group by DATENAME(DW,order_date) 
/* monthly trend of orders */
select DATENAME(month, order_date) as order_month, count(distinct order_id) as Total_orders from pizza_sales Group by DATENAME(month, order_date) order by Total_orders desc
/* Hourly trend of orders */
select Datetrunc(hour, order_time) as time_, count (distinct order_id) as Total_orders from pizza_sales Group by DATETRUNC(hour, order_time) order by time_ asc 
/* percentage of sales per category */
select pizza_category, sum(total_price)* 100 / (select sum(total_price)from pizza_sales) as percentage_sales_per_category from pizza_sales Group by pizza_category 
/* percentage of sales per pizza size */
select pizza_size, cast(sum(total_price) *100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as percentage_sales_per_size from pizza_sales group by pizza_size
/* Total pizza sold in each category */
select pizza_category, sum(quantity) from pizza_sales as Total_pizza_sold group by pizza_category
/*Total pizza sold for any quarter for each category */
select pizza_category, cast(sum(total_price) as decimal(10,2)) as Total_sales_for_q1 from pizza_sales where datepart(quarter,order_date) = 1 group by pizza_category
/* Top 5 best sellers by revenue */
select Top 5 pizza_name, sum(total_price) as Total_revenue from pizza_sales group by pizza_name order by Total_revenue desc
/* Top 5 best sellers by orders */
select Top 5 pizza_name, count(distinct order_id) as Total_orders from pizza_sales group by pizza_name order by Total_orders desc
/* Top 5 best sellers byquantity */
select Top 5 pizza_name, sum(quantity) as Total_quantity from pizza_sales group by pizza_name order by Total_quantity desc
/* Bottom 5 best sellers by revenue */
select Top 5 pizza_name, sum(total_price) as Total_revenue from pizza_sales group by pizza_name order by Total_revenue asc
/* Bottom  5 best sellers by orders */
select Top 5 pizza_name, count(distinct order_id) as Total_orders from pizza_sales group by pizza_name order by Total_orders asc
/* Bottom  5 best sellers byquantity */
select Top 5 pizza_name, sum(quantity) as Total_quantity from pizza_sales group by pizza_name order by Total_quantity asc