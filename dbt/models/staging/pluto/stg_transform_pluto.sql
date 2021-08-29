{{config(
    materialized = "table"
)}}

with prep as (
    select 

        md5(year || borough_code || block || lot) as pluto_year_id,
        borough_code || block || lot as bbl,
        *,
        st_centroid(lot_geometry) as lot_centroid
    from {{ref('stg_agg_pluto')}}

),

land_use_map as (
    select 
        *
    from {{ref('land_use')}}
),

owner_type_map as (
    select
        *
    from {{ref('owner_type')}}
),

map_categories as (
    select 
        * except(land_use_code, owner_type_code)
    from prep 
    left join land_use_map using (land_use_code)
    left join owner_type_map using (owner_type_code)
        
)

{# year over year change in maximum allowable floor area ratio #}
select
    *,
    max_resid_allw_far - lag(max_resid_allw_far) over(partition by bbl order by year asc) as max_resid_allw_far_diff
from map_categories
inner join {{ref('stg_puma_geos')}} on st_within(lot_centroid, puma_geometry)