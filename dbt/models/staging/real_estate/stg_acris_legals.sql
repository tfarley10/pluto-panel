{{
    config(
        tags = ["acris"]
    )
}}

with prep as (
    select 
        document_id,
        borough as borough_code,
        lpad(nullif(block, '0'), 4, '0') as block,
        lpad(lot, 5, '0') as lot,
        if(easement = 'Y', true, false) as is_easement,
        if(partial_lot = 'P', true, false) as is_partial,
        if(air_rights = 'Y', true, false) as is_air_rights,
        date(split(good_through_date, 'T')[offset(0)]) as good_through_date,
        property_type as property_type_code,
        street_number,
        street_name,
        unit,
        if(block = '0' and lot = '0', true, false) as is_bbl_na,
        if(property_type = 'PA', true, false) as is_pre_acris
    from {{source('real_estate','raw_acris_legals')}}
    where 
        street_name is not null
),

final as(
select 
    prep.*,
    property_type,
    borough_code || block || lot as bbl,
    farm_fingerprint(borough_code || block || lot) as bbl_hash,
    max(borough_code || block || lot) over(partition by document_id, good_through_date) as bbl_max,
    count(1) over(partition by document_id) as docs_count
from prep 
left join {{ref('property_codes')}} using (property_type_code)
)

select 
    *, 
    if(is_bbl_na, bbl_max, bbl) as bbl2
from final

