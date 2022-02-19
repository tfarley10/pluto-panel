{{
    config(
        materialized = "table",
        tags = ["acris"]
    )
}}


with prep as (
        select 
            document_id,
            party_type,
            name,
            case
                when address_2 is not null then address_1 || ' | ' || address_2 
                else address_1 
            end as address,
            country,
            city,
            state
        from {{ source('real_estate', 'raw_acris_parties') }}
)


select 
    document_id, 
    recorded_date as document_date, 
    doc_type,
    case  
        when party_type = '1' then party1_type
        when party_type = '2' then party2_type
        when party_type = '3' then party3_type
    end as party_type,
    doc_type_description,
    name,
    address,
    country,
    state
from prep 
left join {{ref('stg_acris_master')}} using (document_id)
