

  create or replace table `pluto-panel`.`dbt_ted`.`lot_year`
  partition by range_bucket(
            year,
            generate_array(2002, 2020, 1)
        )
  cluster by lot_geometry, bbl
  OPTIONS()
  as (
    

select 
        * 
from `pluto-panel`.`dbt_ted`.`stg_lot_year`
left join `pluto-panel`.`dbt_ted`.`stg_lot_cartesian` using (bbl_year_hash_id)
  );
    