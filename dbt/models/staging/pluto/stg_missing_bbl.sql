{{config(
    materialized = "table"
    )
    }}

with missing_lag as (

    select 
        * except(lag_bbl_year_hash_id)
    from {{ref('stg_lot_year')}}
    where
        lag_bbl_year_hash_id is null and 
        year != 2002 

),

year_geom as (
    
    select 
        bbl_year_hash_id,
        year,
        borough,
        lot_geometry
    from {{ref('stg_lot_year')}}
    where 
        year < 2020

),

final as (

    select 
        missing_lag.*,
        year_geom.bbl_year_hash_id as lag_bbl_year_hash_id
    from missing_lag 
    inner join year_geom on 
            st_intersects(missing_lag.lot_centroid, year_geom.lot_geometry) and 
            missing_lag.year - 1 = year_geom.year and 
            missing_lag.borough = year_geom.borough
)

select * from final

{% if is_incremental() %}

  where false

{% endif %}