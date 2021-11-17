
    
    




with all_values as (

    select distinct
        land_use_code as value_field

    from `pluto-panel`.`dbt_ted`.`stg_lot_year`

),

validation_errors as (

    select
        value_field

    from all_values
    where value_field not in (
        '01','02','03','04','05','06','07','08','09','10','11'
    )
)

select count(*) as validation_errors
from validation_errors


