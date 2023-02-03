{{ config(materialized='view',schema= 'staging') }}

  select
  id as customer_id,
  first_name,
  last_name
  from jaffle_shop.customers
