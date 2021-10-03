{% macro get_pluto_tables() %}

{% set pluto_tables_query %}
select distinct
table_name
{# use raw_pluto dataset #}
from `pluto-panel.raw_pluto.INFORMATION_SCHEMA.TABLES`
where 
    regexp_contains(table_name, 'pluto_\\d{4}')
order by 1
{% endset %}

{% set results = run_query(pluto_tables_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}