create  table dbt_ted.tmp_incomplete_geos as (
with has_missing as (
    select 
        bbl
    from dbt_ted.tmp_bbl_year_map
    where 
        is_complete = false
),

prep as (

select 
    bbl,
    year,
    lot_centroid,
    bbl_year_hash_id
from dbt_ted.stg_lot_year as ly 
inner join has_missing using(bbl)
)
select * from prep
)