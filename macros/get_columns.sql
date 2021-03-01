{% macro get_columns(schema = 'source', table = '') -%}

{% set tables_query %}

select
  column_name
FROM pluto.INFORMATION_SCHEMA.columns
WHERE
      table_schema = '{{schema}}'
  and table_name = '{{table}}';

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
