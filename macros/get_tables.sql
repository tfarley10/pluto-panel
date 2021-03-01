{% macro get_tables(schema = 'source', table_like = '') -%}

{% set tables_query %}

select
  table_name
FROM pluto.INFORMATION_SCHEMA.tables
WHERE
  table_type = 'BASE TABLE'
  and table_schema = '{{schema}}'
  and table_name like '%{{table_like}}%';

{% endset %}

{% set results = run_query(tables_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}


{%- endmacro %}
