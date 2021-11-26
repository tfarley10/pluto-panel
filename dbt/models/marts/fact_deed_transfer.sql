{{
    config(
        tags = ["acris"]
    )
}}

with prep as (
    select 
        master.* except(party1_type, party2_type, party3_type, doc_type, doc_type_description)
    from {{ref('stg_acris_master')}}  as master
    where 
        doc_type = 'DEED' and 
        amount > 0 and
        percent_trans > 0
)

select * from prep

