with customer_orders as (
    select
        customer_key,
        max(order_date)           as last_order_date,
        count(distinct order_key) as frequency,
        sum(total_price)          as monetary
    from {{ ref('fct_orders') }}
    group by customer_key
),

reference_date as (
    select max(order_date) as max_order_date
    from {{ ref('fct_orders') }}
),

scored as (
    select
        co.customer_key,
        datediff('day', co.last_order_date, rd.max_order_date) as recency_days,
        co.frequency,
        co.monetary,
        ntile(5) over (order by datediff('day', co.last_order_date, rd.max_order_date) desc) as recency_score,
        ntile(5) over (order by co.frequency) as frequency_score,
        ntile(5) over (order by co.monetary)  as monetary_score
    from customer_orders as co
    cross join reference_date as rd
)

select
    customer_key,
    recency_days,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    case
        when recency_score >= 4 and frequency_score >= 4 and monetary_score >= 4 then 'Champions'
        when frequency_score >= 4 and monetary_score >= 3                        then 'Loyal Customers'
        when recency_score >= 4 and frequency_score <= 2                         then 'New Customers'
        when recency_score <= 2 and frequency_score >= 3                         then 'At Risk'
        when recency_score <= 2 and frequency_score <= 2                         then 'Lost'
        else 'Others'
    end as rfm_segment
from scored
