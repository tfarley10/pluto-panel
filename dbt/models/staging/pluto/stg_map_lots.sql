{{config(
    materialized = "table"
)}}

with incomplete_mapping as (

    select 
        bbl
    from {{ref('stg_lot_map')}}
    where 
        is_complete = false
)

{# get rows that are associated with  bbls that are incompletely mapped#}

select
    bbl_year_hash_id,
    lot_centroid
from {{ref('stg_lot_year')}}
inner join incomplete_mapping using (bbl)