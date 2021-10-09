{{config(
    materialized = "table"
)}}
with prep as (
    select

        case borough
            when 'MANHATTAN'     then  '1'
            when 'BRONX'         then  '2'
            when 'BROOKLYN'      then  '3'  
            when 'QUEENS'        then  '4'
            when 'STATEN ISLAND' then  '5'
        end as borough_num,
        
        job_status as status_code,
        lpad(block, 5, '0') as block,
        lpad(lot, 4, '0') as lot,
        regexp_replace(existing_dwelling_units, '[^\\d]', '') as existing_dwelling_units,
        regexp_replace(proposed_dwelling_units, '[^\\d]', '') as proposed_dwelling_units,
        trim(latest_action_date) as latest_action_date,
        existing_occupancy
    from raw_pluto.raw_job_applications

),

final as (

select 
    status,
    safe_cast(existing_dwelling_units as integer) as existing_dwelling_units,
    safe_cast(proposed_dwelling_units as integer) as proposed_dwelling_units,
        case 
            when regexp_contains(latest_action_date, '-') then date(latest_action_date)
            else safe.parse_date('%m/%d/%Y', latest_action_date)
        end as latest_action_date,
    existing_occupancy,
    borough_num || block || lot as bbl

from prep
left join {{ref('dob_job_status')}} using(status_code)
)

select 
    *,
    row_number() over(partition by bbl order by latest_action_date desc) as recency_rank
from final