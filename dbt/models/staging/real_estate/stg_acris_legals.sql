{{
    config(
        tags = ["acris"]
    )
}}

with prep as (
    select 
        document_id,
        borough as borough_code,
        lpad(block, 4, '0') as block,
        lpad(lot, 5, '0') as lot,
        if(easement = 'Y', true, false) as is_easement,
        if(partial_lot = 'P', true, false) as is_partial,
        if(air_rights = 'Y', true, false) as is_air_rights,
        date(split(good_through_date, 'T')[offset(0)]) as good_through_date,
        property_type as property_type_code,
        street_number,
        street_name,
        unit
    from {{source('real_estate','raw_acris_legals')}}
)

select 
    prep.*,
    property_type,
    borough_code || block || lot as bbl,
    farm_fingerprint(borough_code || block || lot) as bbl_hash
from prep 
left join {{ref('property_codes')}} using (property_type_code)