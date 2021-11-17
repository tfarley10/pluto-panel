create or replace table `pluto-panel.dbt_ted.tmp_incomplete_mapped` as (
select
    a.year,
    a.bbl_year_hash_id,
    a.bbl,
    b.year as mapped_year,
    b.bbl_year_hash_id as mapped_bbl_year_hash_id
from `pluto-panel.dbt_ted.tmp_incomplete_geos` as a 
inner join `pluto-panel.dbt_ted.stg_lot_year` as b on st_intersects(a.lot_centroid, b.lot_geometry)

)