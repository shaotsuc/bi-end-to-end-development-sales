{{
    config(
        materialized='incremental',
        schema='stg'
    )
}}

SELECT
  TO_DATE(order_date, 'dd-mm-yyyy') AS order_date,
  TO_DATE(ship_date, 'dd-mm-yyyy') AS ship_date,
  order_id,
  customer_id,
  customer_name,
  discount AS discount_percent,
  country_name,
  region_name,
  state_name,
  postal_code,
  city_name,
  category AS product_category,
  sub_category AS product_sub_category,
  product_id,
  product_name,
  sales AS gross_sales,
  CASE WHEN discount > 0 THEN (1 - Discount) * sales ELSE sales END AS net_sales,
  quantity,
  profit,
  segment AS buyer_segment,
  ship_mode
FROM {{ source('dwh', 'orders') }}