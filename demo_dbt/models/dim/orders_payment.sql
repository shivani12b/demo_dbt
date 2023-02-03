
with payment as
(
    select order_id, sum(amount) as total_amt from {{ ref('stg_payments') }}
    where status='success'
group by 1
),

orders as
(
    select * from {{ ref('stg_orders') }}
)

select
    orders.order_id,
    orders.customer_id,
      orders.order_date,
        orders.status,
        coalesce(payment.total_amt,0) as total_amt
from orders  left join  payment using (order_id)

