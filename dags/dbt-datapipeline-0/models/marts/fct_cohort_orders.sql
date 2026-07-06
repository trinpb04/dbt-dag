select
    o.order_key,
    o.customer_key,
    c.cohort_month,
    date_trunc('month', o.order_date) as order_month,
    datediff('month', c.cohort_month, date_trunc('month', o.order_date)) as period_number
from {{ ref('stg_tpch_orders') }} as o
join {{ ref('int_customer_cohort') }} as c
    on o.customer_key = c.customer_key