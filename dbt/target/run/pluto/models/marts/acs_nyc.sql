
        
    

    

    merge into `pluto-panel`.`dbt_ted`.`acs_nyc` as DBT_INTERNAL_DEST
        using (
          
with acs as (
    select * from `pluto-panel`.`dbt_ted`.`stg_acs_agg`
),

nyc_pumas as (
    select 
        puma_name,
        puma_geo_id as geo_id
    from `pluto-panel`.`dbt_ted`.`stg_puma_geos`
)

select 
    *
from acs 
inner join nyc_pumas using (geo_id)



  where false


        ) as DBT_INTERNAL_SOURCE
        on FALSE

    

    when not matched then insert
        (`geo_id`, `total_pop`, `pop_25_64`, `family_households`, `households`, `median_income`, `housing_units`, `median_rent`, `mortgaged_housing_units`, `gini_index`, `no_cars`, `not_us_citizen_pop`, `masters_degree`, `bachelors_degree`, `year`, `puma_name`)
    values
        (`geo_id`, `total_pop`, `pop_25_64`, `family_households`, `households`, `median_income`, `housing_units`, `median_rent`, `mortgaged_housing_units`, `gini_index`, `no_cars`, `not_us_citizen_pop`, `masters_degree`, `bachelors_degree`, `year`, `puma_name`)


  