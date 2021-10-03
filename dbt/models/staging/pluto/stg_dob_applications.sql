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
        
        job_status,
        lpad(block, 5, '0') as block,
        lpad(lot, 4, '0') as lot,
        existing_dwelling_units,
        proposed_dwelling_units,
        trim(latest_action_date) as latest_action_date,
        existing_occupancy
    from raw_pluto.raw_job_applications

)

select 
    *,
    case 
        when regexp_contains(latest_action_date, '-') then date(latest_action_date)
        else safe.parse_date('%m/%d/%Y', latest_action_date)
    end as latest_action_dt,
    borough_num || block || lot as bbl 

from prep