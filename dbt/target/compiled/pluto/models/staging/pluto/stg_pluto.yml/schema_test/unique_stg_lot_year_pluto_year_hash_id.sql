
    
    

select
    pluto_year_hash_id as unique_field,
    count(*) as n_records

from `pluto-panel`.`dbt_ted`.`stg_lot_year`
where pluto_year_hash_id is not null
group by pluto_year_hash_id
having count(*) > 1


