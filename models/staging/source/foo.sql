{% set t = 'raw_2016' %}
{% set columns = get_columns(table = t) %}
{% set cols_list = ['zonedist1', 'zn_dst1'] %}

select
uuid,
{% for column in columns %}
{% if column in cols_list %}
{{column}} as {{column}}
{% endif %}
{% endfor %}
from source.{{t}}
