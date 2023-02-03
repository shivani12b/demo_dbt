{{ config(schema='jaffle_shop') }}

with orders as (
  select user_id as customer_id,
  min(order_date) as min_date,
  max(order_date) as max_date,
  count(id) as order_count
  from jaffle_shop.orders
  group by user_id
),
customers as (
  select
  id as customer_id,
  first_name,
  last_name
  from jaffle_shop.customers
),
  customer_orders as (
  select
  customers.first_name  as first_name,
  customers.last_name as last_name ,
  customers.customer_id as customer_id,
  orders.min_date as first_order_date,
  orders.max_date as recent_order_date,
  coalesce (orders.order_count,0) as order_count
  from customers left join orders using (customer_id)
)

select * from customer_orders