{{
    config(
        tags = ["acris"]
    )
}}

with prep as (
    select 
        *
    from {{ref('stg_acris_legals')}} as legals
    where 
        document_id in (select document_id from {{ref('fact_deed_transfer')}})
)

select * from prep