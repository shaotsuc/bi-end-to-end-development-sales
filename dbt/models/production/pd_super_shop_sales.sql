{{
    config(
        materialized='incremental',
        schema='prod'
    )
}}

WITH manager AS (
    SELECT
        name AS manager,
        region_name
    FROM {{ source('dwh', 'people') }}
),

returns AS (
    SELECT
        order_id,
        returned AS is_returned
    FROM {{ source('dwh', 'returns') }}
)

SELECT
    o.order_date,
    o.ship_date,
    o.order_id,
    o.customer_id,
    o.customer_name,
    o.buyer_segment,
    o.country_name,
    o.region_name,
    o.state_name,
    o.postal_code,
    o.city_name,
    o.product_category,
    o.product_sub_category,
    o.product_id,
    o.product_name,
    o.ship_mode,
    o.gross_sales,
    o.discount_percent,
    o.net_sales,
    o.quantity,
    o.net_sales - o.profit AS cost,
    o.profit,
    CASE 
        WHEN o.net_sales >= 2000 AND COALESCE(r.is_returned, FALSE) = FALSE 
        THEN TRUE 
        ELSE FALSE 
    END AS is_high_value_sales,
    m.manager,
    COALESCE(r.is_returned, FALSE) as is_returned
FROM {{ ref('stg_orders') }} AS o
LEFT JOIN manager m ON o.region_name = m.region_name
LEFT JOIN returns r ON o.order_id = r.order_id

{% if is_incremental() %}

where order_date >= (select coalesce(max(order_date),'1900-01-01') from {{ this }} )

{% endif %}