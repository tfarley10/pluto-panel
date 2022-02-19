select 
    name as tract_name,
    geoid as tract_geoid,
    variable,
    year,
    value
from dbt_ted.stg_new_york_decennial