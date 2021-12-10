{% macro get_acs_tables() %}

{% set acs_tables_query %}
with prep as (
    select
    table_name,
    regexp_extract(table_name, r'.+(\d{4}).+$') as year,
    regexp_extract(table_name, r'.+(\d{1})yr$') as estimate_length,
    max(regexp_extract(table_name, r'.+(\d{1})yr$')) over(partition by regexp_extract(table_name, r'.+(\d{4}).+$')) as max_rn
    from `bigquery-public-data.census_bureau_acs.INFORMATION_SCHEMA.TABLES`
    where regexp_contains(table_name, 'puma')
)

select table_name, estimate_length, year  from prep where estimate_length = max_rn
{% endset %}

{% set results = run_query(acs_tables_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}