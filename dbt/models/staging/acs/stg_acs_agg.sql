{% set acs_years = ['2007','2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'] %}


{% for yr in acs_years %}
select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    {# number of households w/o a car #}
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    {{yr}} as year
from `bigquery-public-data.census_bureau_acs.puma_{{yr}}_1yr`
{% if not loop.last -%} union all {%- endif %}
{% endfor %}