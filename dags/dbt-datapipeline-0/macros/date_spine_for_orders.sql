{% macro date_spine_for_orders() %}

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="(select min(order_date) from " ~ ref('stg_tpch_orders') ~ ")",
        end_date="(select dateadd(day, 1, max(order_date)) from " ~ ref('stg_tpch_orders') ~ ")"
    ) }}

{% endmacro %}