{{config(
    materialized = "table"
)}}

with prep as (
    select 
        borough_code,
        block,
        array_agg(distinct puma_geo_id) as puma_geo_ids,
        st_union_agg(lot_geometry) as borough_block_geometry
    from dbt_ted.lot_year
    where 
        year = 2020
    group by 1,2

)

select 
    *,
    array_length(puma_geo_ids) as num_puma_geo_ids,
    st_centroid(borough_block_geometry) as borough_block_centroid
from prep