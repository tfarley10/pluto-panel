{{
    config(
        tags = ["acris"]
    )
}}

with prep as (
    select 
        * ,
        if(reel_yr = '0', true, false) as is_pre_acris,
        row_number() over(partition by document_id order by good_through_date desc) as recency_rank
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
    party3_type,
    is_pre_acris

from prep 
left join {{ref('acris_document_codes')}} using (doc_type)
where 
    recency_rank = 1
