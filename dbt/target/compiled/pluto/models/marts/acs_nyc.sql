
with acs as (
    select * from `pluto-panel`.`dbt_ted`.`stg_acs_agg`
),

nyc_pumas as (
    select 
        puma_name,
        puma_geo_id as geo_id
    from `pluto-panel`.`dbt_ted`.`stg_puma_geos`
)

select 
    *
from acs 
inner join nyc_pumas using (geo_id)



  where false

