create or replace table  dbt_ted.tmp_bbl_year_map as (


with a as (
select 
    year,
    bbl,
    bbl_year_hash_id,
    STRUCT<year int64, bbl_year_hash_id int64>(t.year, t.bbl_year_hash_id) as bbl_year_map
from `pluto-panel.dbt_ted.lot_year` t 
)

select 
    bbl,
    array_agg(bbl_year_map) as yr_map,
    count(1) as n_records,
    if(count(1) = 19, true, false) as is_complete 
from a 
group by 1 

)