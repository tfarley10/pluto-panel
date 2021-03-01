{% macro make_bbl() -%}
case borough
    when 'MN' then '1'
    when 'BX' then '2'
    when 'BK' then '3'
    when 'QN' then '4'
    when 'SI' then '5'
    end
    ||
    lpad(block::varchar(5), 5, '0')
    ||
    lpad(lot::varchar(4), 4, '0')
{%- endmacro %}
