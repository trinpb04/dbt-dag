select
    c.customer_key,
    c.customer_name,
    c.market_segment,
    n.nation_name,
    r.region_name
from
    {{ ref('stg_tpch_customers') }} as c
join
    {{ ref('stg_tpch_nations') }} as n
    on c.nation_key = n.nation_key
join
    {{ ref('stg_tpch_regions') }} as r
    on n.region_key = r.region_key