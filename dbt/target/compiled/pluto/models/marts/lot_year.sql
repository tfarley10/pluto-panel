

select 
        * 
from `pluto-panel`.`dbt_ted`.`stg_lot_year`
left join `pluto-panel`.`dbt_ted`.`stg_lot_cartesian` using (bbl_year_hash_id)