{% set acs_years = ['2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'] %}


{% for yr in acs_years %}
select 
    geo_id,
    family_households,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    no_car,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    puma_geo.puma_name,
    {{yr}} as year
from `bigquery-public-data.census_bureau_acs.puma_{{yr}}_1yr` as acs
inner join {{ref('stg_puma_geos')}} as puma_geo on puma_geo.puma_geo_id = acs.geo_id
{% if not loop.last -%} union all {%- endif %}
{% endfor %}