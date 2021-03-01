{% macro get_columns_from_list(schema = 'source') -%}

{% set tables_query %}

select
  column_name
FROM pluto.INFORMATION_SCHEMA.columns
WHERE
  table_schema = '{{schema}}'
  and table_name = 'raw_2020';

{% endset %}

{% set results = run_query(tables_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{% set cols_list = ['zonedist1', 'zn_dst1'] %}

{% for c in cols_list %}
  {% for r in results_list %}
    {% if c == r %}
      {% set col = c %}
    {% endif %}
  {% endfor %}
{% endfor %}

{{return(c)}}



{%- endmacro %}
