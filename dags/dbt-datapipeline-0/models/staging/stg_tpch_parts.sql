SELECT
    p_partkey as part_key,
    p_name as part_name,
    p_type as part_type,
    p_brand as brand
FROM
    {{ source('tpch', 'part') }}