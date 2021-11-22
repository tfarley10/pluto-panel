{{
    config(
        tags = ["acris"]
    )
}}

with prep as (
    select 
        master.* except(party1_type, party2_type, party3_type),
        legals.property_type,
        legals.bbl
    from {{ref('stg_acris_master')}}  as master
    left join {{ref('stg_acris_legals')}} as legals using (document_id)
)

select * from prep

