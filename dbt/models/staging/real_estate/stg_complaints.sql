with a as (
    select 
        complaint_number,
        trim(bin) as bin,
        status,
        safe.parse_date('%m/%d/%Y', date_entered) as complaint_date,
        date_entered as date_entered_raw,
        disposition_code,
        complaint_category
    from real_estate.raw_dob_complaints
)

select * from a 