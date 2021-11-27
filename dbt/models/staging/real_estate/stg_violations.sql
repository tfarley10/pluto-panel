with a as 
(
    select 
        trim(bin) as bin,
        boro as borough_code,
        ltrim(lot, '0') as lot, 
        ltrim(block, '0') as block,
        violation_type_code,
        safe.parse_date('%Y%m%d', issue_date) as issue_date,
        issue_date as issue_date_raw
        
from real_estate.raw_dob_violations 
),


b as (
    select 
        * replace(lpad(block, 5, '0') as block, lpad(lot, 4, '0') as lot)
    from a 
)



    select 
        *,
        borough_code || block || lot as bbl
    from b

