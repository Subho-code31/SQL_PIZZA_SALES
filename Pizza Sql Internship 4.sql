select * from order_details;
create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));

select * from orders;
select * from pizzas;
select * from pizza_types;

 # Retrieve the total number of Orders placed.
select count(order_id) from orders;
 
# calculate the total revenue generated from pizza sales.
select sum(order_details.quantity * pizzas. price) as revenue 
from order_details join pizzas on order_details.pizza_id=pizzas.pizza_id ; 

#Identify the highest priced pizza.
select pizza_id,sum(price) as total_price 
from pizzas group by pizza_id order by total_price desc limit 1;

#Identify the most common pizza size ordered.
select count(order_id),size 
from pizzas join order_details on pizzas.pizza_id=order_details.pizza_id 
group by size order by count(order_id) desc;

#List the top 5 most ordered pizza types along with their quantities.
select pizza_type_id,sum(quantity) as total_quantity 
from order_details join pizzas on order_details.pizza_id=pizzas.pizza_id 
group by pizza_type_id order by total_quantity desc limit 5;
 
# Join the necessery tables to find the total quantity of each pizza ordered.
select category,sum(quantity) from order_details join pizzas on order_details.pizza_id = pizzas.pizza_id join pizza_types 
on pizza_types.pizza_type_id = pizzas.pizza_type_id group by category order by sum(quantity) desc;

#Determine the distribution of Orders by hour of the day.
select count(order_id),hour(time) from orders group by hour(time); 

#Join relevant tables to find the category wise distribution of pizza.
select category,count(name) from pizza_types group by category;

#Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(order_id),date from orders group by date;

# Determine The top 3 most ordered pizzas order based on revenue. 
select sum(order_details.quantity * pizzas. price) as revenue,pizzas.pizza_type_id 
from order_details join pizzas on order_details.pizza_id=pizzas.pizza_id join
 pizza_types on pizzas.pizza_type_id= pizza_types.pizza_type_id 
group by pizzas.pizza_type_id order by revenue desc limit 3;

# Calculate the percentage contribution to each pizza type to total revenue.

select pizza_types.category,
round(sum(order_details.quantity * pizzas.price ) / 
( select round(sum(order_details.quantity * pizzas.price),2) as total_sales 
from order_details 
join 
pizzas on pizzas.pizza_id = order_details.pizza_id) * 100,2) as revenue
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details on  order_details.pizza_id = pizzas.pizza_id 
group by pizza_types.category order by revenue desc;

 # calculate the percentage contributiopn of each pizza type of total revenue.

SELECT
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS Total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;



 # Analyze the Cumilative revenue generated over time.
select date,sum(revenue) over(order by date) from
(select sum(order_details.quantity * pizzas. price) as revenue,date from order_details 
join pizzas on order_details.pizza_id=pizzas.pizza_id join orders  on orders.order_id=order_details.order_id 
group by orders.date order by revenue desc) as sales;

 # Determine the top 3 most ordered pizza types based on revenue for each pizza category.
 select sum(order_details.quantity * pizzas.price) as revenue,pizza_types.name from pizza_types join pizzas
 on pizzas.pizza_type_id = pizza_types.pizza_type_id join order_details on pizzas.pizza_id = order_details.pizza_id
 group by pizza_types.name order by revenue desc;
 











 








