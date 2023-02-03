{{ config(materialized='table',schema= 'analytics') }}


with cust_ord as
(
    select * from {{ ref('customer_orders') }}
),
ord_pay as
(
    select total_amt,customer_id from {{ ref('orders_payment') }}
)

select
    cust_ord.customer_id,
    cust_ord.first_name,
    cust_ord.last_name,
    cust_ord.first_order_date,
    cust_ord.recent_order_date,
    coalesce (ord_pay.total_amt,0) as total_amount
from
cust_ord left join ord_pay using(customer_id)

