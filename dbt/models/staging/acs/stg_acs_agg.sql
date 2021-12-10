{{config(
    materialized = "table",
    tags=["acs"]
    )
    }}
{% set acs_tables = get_acs_tables() %}

{% for table in acs_tables %}
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
    white_pop,
    black_pop,
    asian_pop,
    hispanic_pop,
    regexp_extract('{{table}}', r'.+(\d{4}).+$') as year,
    regexp_extract('{{table}}', r'.+(\d{1})yr$') as estimate_length,
from `bigquery-public-data.census_bureau_acs.{{table}}`
{% if not loop.last -%} union all {%- endif %}
{% endfor %}