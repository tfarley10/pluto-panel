{{config(materialized = "table")}}

with prep as (
    select 
        *
    from dbt_ted.stg_newyork_tract
),

final as (
    select 
        geoid as tract_geoid,
        variable as variable_name,
        trim(replace(split(name, ',')[offset(1)], ' County', '')) as county,
        st_geogfromtext(geography) as geog
    from prep
)

select
    *,
    case
        when county in (
            'New York',
            'Bronx',
            'Queens',
            'Kings',
            'Richmond'
        ) then true 
        else false 
        end as is_nyc
from final
