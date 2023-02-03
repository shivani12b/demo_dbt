{{ config(materialized='table') }}

with customers as (

    select * from {{ ref('stg_customers') }}

),
orders as (

    select
    customer_id,
    min(order_date) as min_date,
    max(order_date) as max_date,
    count(order_id) as order_count
    from {{ ref('stg_orders') }}
    group by 1

),
  customer_orders as (
  select
  customers.first_name ,
  customers.last_name,
  customers.customer_id as customer_id,
  orders.min_date as first_order_date,
  orders.max_date as recent_order_date,
  coalesce (orders.order_count,0) as order_count
  from customers left join orders using (customer_id)
)

select * from customer_orders