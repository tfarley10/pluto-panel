{{config(
    materialized = "incremental",
    cluster_by = ["lot_geometry", "bbl"],
    partition_by = {
      "field": "year",
      "data_type": "int64",
      "range": {
        "start": 2002,
        "end": 2020,
        "interval": 1
      }
    }
)}}

with prep as (
    select 

        borough_code || block || lot as bbl,
        farm_fingerprint(cast(year as string) || borough_code || block || lot) as bbl_year_hash_id,
        *,
        cast(borough_code as int64) as borough_int,
        st_centroid(lot_geometry) as lot_centroid
    from {{ref('stg_agg_pluto')}}
    where
        not st_isempty(lot_geometry)

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
        
),

final as (

{# year over year change in maximum allowable floor area ratio #}
select
    *,
    farm_fingerprint(bbl) as bbl_hash,
    lag(bbl_year_hash_id) over(partition by bbl order by year) as lag_bbl_year_hash_id
from map_categories
inner join {{ref('stg_puma_geos')}} on st_intersects(lot_centroid, puma_geometry)

)

select * from final

{% if is_incremental() %}
  where false

{% endif %}
