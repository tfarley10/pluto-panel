{{config(
    materialized = "table",
    tags=["acs"]
    )
    }}
with acs as (
    select * replace(cast(year as integer) as year) from {{ref('stg_acs_agg')}}
),

nyc_pumas as (
    select 
        puma_name,
        puma_geo_id as geo_id
    from {{ref('stg_puma_geos')}}
)

select 
    *
from acs 
inner join nyc_pumas using (geo_id)
