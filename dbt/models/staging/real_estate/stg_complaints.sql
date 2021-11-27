with a as (
    select 
        complaint_number,
        trim(bin) as bin,
        status,
        safe.parse_date('%m/%d/%Y', date_entered) as complaint_date,
        date_entered as date_entered_raw,
        disposition_code,
        trim(complaint_category) as code
    from real_estate.raw_dob_complaints
)

select 
    * 
from a 
left join {{ref('complaint_codes')}} using (code)