create or replace table dbt_ted.tmp_missing as (
with a as (
    select 
        bbl,
        lot_centroid
    from dbt_ted.tmp_mart
    where
        far_diff is null
),

b as (
    select 
        bbl as lag_bbl,
        lot_geometry,
        has_residential as lag_resid,
        max_resid_allw_far as lag_far
    from dbt_ted.lot_year
    where 
        year = 2004
)
select 
    * except(lot_geometry, lot_centroid)
 from a
inner join b on st_intersects(a.lot_centroid, b.lot_geometry)

)