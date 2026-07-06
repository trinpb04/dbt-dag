select
    part_key,
    part_name,
    part_type,
    brand
FROM
    {{ ref('stg_tpch_parts') }}