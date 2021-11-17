
    
    

with all_values as (

    select
        land_use_code as value_field,
        count(*) as n_records

    from `pluto-panel`.`dbt_ted`.`stg_lot_year`
    group by land_use_code

)

select *
from all_values
where value_field not in (
    '01','02','03','04','05','06','07','08','09','10','11'
)


