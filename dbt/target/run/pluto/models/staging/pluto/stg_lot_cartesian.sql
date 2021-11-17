

  create or replace table `pluto-panel`.`dbt_ted`.`stg_lot_cartesian`
  
  
  OPTIONS()
  as (
    


with n_bbl as (
    
    select 
        bbl,
        count(1) as n_records
    from `pluto-panel`.`dbt_ted`.`stg_lot_year` 
    group by 1 
),

incomplete_bbl as (
    select 
        to_map.year,
        to_map.bbl_year_hash_id,
        STRUCT<year int64, bbl_year_hash_id int64>(agg_pluto.year, agg_pluto.bbl_year_hash_id) as bbl_year_map
    from `pluto-panel`.`dbt_ted`.`stg_lot_year` as to_map
    inner join `pluto-panel`.`dbt_ted`.`stg_lot_year` as agg_pluto on st_intersects(to_map.lot_centroid, agg_pluto.lot_geometry)
    where 
        to_map.bbl in (
            select 
                bbl 
            from n_bbl 
            where 
                n_records < 19
        )
),


complete_bbl as (
    select 
        to_map.year,
        to_map.bbl_year_hash_id,
        STRUCT<year int64, bbl_year_hash_id int64>(agg_pluto.year, agg_pluto.bbl_year_hash_id) as bbl_year_map
    from `pluto-panel`.`dbt_ted`.`stg_lot_year` as to_map
    
    inner join `pluto-panel`.`dbt_ted`.`stg_lot_year` as agg_pluto using (bbl)
    where 
        to_map.bbl in (
            select 
                bbl
            from n_bbl
            where 
                n_records >= 19
        )
),

final as (
    select * from incomplete_bbl
    union all
    select * from complete_bbl
)

select 
    bbl_year_hash_id,
    array_agg(bbl_year_map) as bbl_year_combo
from final
group by 1
  );
    