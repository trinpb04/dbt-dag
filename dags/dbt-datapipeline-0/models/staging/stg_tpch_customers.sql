SELECT
    c_custkey as customer_key,
    c_name as customer_name,
    c_mktsegment as market_segment,
    c_nationkey as nation_key
FROM
    {{ source('tpch', 'customer') }}