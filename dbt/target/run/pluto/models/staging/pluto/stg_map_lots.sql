

  create or replace table `pluto-panel`.`dbt_ted`.`stg_map_lots`
  
  
  OPTIONS()
  as (
    

with incomplete_mapping as (

    select 
        bbl
    from `pluto-panel`.`dbt_ted`.`stg_lot_map`
    where 
        is_complete = false
)



select
    bbl_year_hash_id,
    lot_centroid
from `pluto-panel`.`dbt_ted`.`stg_lot_year`
inner join incomplete_mapping using (bbl)
  );
    