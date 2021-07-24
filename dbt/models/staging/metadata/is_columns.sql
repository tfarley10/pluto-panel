{% set countries =  ['au', 'us'] %}

{% for country in countries %}
  select 
      *,
      '{{ country }}' as country
  from {{ source(country, 'orders') }}
{% if not loop.last -%} union all {%- endif %}
{% endfor %}