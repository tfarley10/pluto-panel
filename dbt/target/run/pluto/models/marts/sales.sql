

  create or replace table `pluto-panel`.`dbt_ted`.`sales`
  partition by range_bucket(
            sale_year,
            generate_array(2002, 2020, 1)
        )
  cluster by bbl
  OPTIONS()
  as (
    


select 
    *
from `pluto-panel`.`dbt_ted`.`stg_agg_sales`
  );
    