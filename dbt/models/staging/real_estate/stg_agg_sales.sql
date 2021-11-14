{% set real_estate_years = ['2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020' ] %}


{% for yr in real_estate_years %}
select 
    *
from `pluto-panel.real_estate.{{yr}}_raw`
{% if not loop.last -%} union all {%- endif %}
{% endfor %}


