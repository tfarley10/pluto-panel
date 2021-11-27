with a as 
(
    select
        job__ as job_id,
        bin__ as bin_id,
        permit_status,
        filing_status,
        permit_type,
        permit_sequence__ as permit_sequence,
        site_fill,
        case
            when filing_date like '%/%' then safe.parse_date('%F', filing_date)
            else safe.parse_date('%x', filing_date)
            end as filing_date,
        filing_date as filing_date_raw,
        case borough
            when 'MANHATTAN' then '1'
            when 'BRONX' then '2'
            when 'BROOKLYN' then '3'
            when 'QUEENS' then '4'
            when 'STATEN ISLAND' then '5'
        end as borough_code,
        ltrim(lot, '0') as lot, 
        ltrim(block, '0') as block,

from real_estate.raw_dob_permits
),


b as (
    select 
        * replace(lpad(block, 5, '0') as block, lpad(lot, 4, '0') as lot)
         
    from a 
),


c as (
    select 
        *,
        borough_code || block || lot as bbl
    from b
)

select * from c