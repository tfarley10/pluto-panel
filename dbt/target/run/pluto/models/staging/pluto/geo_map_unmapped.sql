

  create or replace table `pluto-panel`.`dbt_ted`.`geo_map_unmapped`
  
  
  OPTIONS()
  as (
    

with prep as (
select
    to_map.bbl_year_hash_id,
    STRUCT<year int64, bbl_year_hash_id int64>(agg_pluto.year, agg_pluto.bbl_year_hash_id) as bbl_year_map
from `pluto-panel`.`dbt_ted`.`stg_map_lots` as to_map
inner join `pluto-panel`.`dbt_ted`.`stg_lot_year` as agg_pluto on st_intersects(to_map.lot_centroid, agg_pluto.lot_geometry)

)

select 
    bbl_year_hash_id,
    array_agg(bbl_year_map) as yr_map 
from prep 
group by 1
  );
    