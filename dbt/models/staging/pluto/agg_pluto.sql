{% set pluto_tables = get_pluto_tables() %}

{% for tb in pluto_tables %}
select 
    case borough 
        when 'MN' then '1'
        when 'BX' then '2'
        when 'BK' then '3'
        when 'QN' then '4'
        when 'SI' then '5'
        else borough
    end as borough_code,
    block,
    lot,
    split('{{tb}}', '_')[SAFE_OFFSET(1)] as year
from {{source('pluto', tb )}}
{% if not loop.last -%} union all {%- endif %}
{% endfor %}

