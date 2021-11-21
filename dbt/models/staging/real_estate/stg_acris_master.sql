{{
    config(
        tags = ["acris"]
    )
}}

with a as (
    select 
        * 
    from {{ source('real_estate', 'raw_acris_master') }}
)

select 
    document_id,
    doc_type,
    crfn,
    date(split(recorded_datetime, 'T')[offset(0)]) as recorded_date,
    modified_date,
    round(cast(percent_trans as numeric), 2) as percent_trans,
    good_through_date,
    doc_type_description,
    class_code_description,
    cast(document_amt as numeric) as amount,
    party1_type,
    party2_type,
    party3_type

from a 
left join {{ref('acris_document_codes')}} using (doc_type)
