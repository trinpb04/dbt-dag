SELECT
    customer_key,
    date_trunc('month', MIN(order_date)) as cohort_month
FROM {{ ref('stg_tpch_orders') }}
GROUP BY customer_key