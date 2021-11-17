
    
    

with all_values as (

    select
        owner_type_code as value_field,
        count(*) as n_records

    from `pluto-panel`.`dbt_ted`.`stg_lot_year`
    group by owner_type_code

)

select *
from all_values
where value_field not in (
    'C','M','O','P','X'
)


