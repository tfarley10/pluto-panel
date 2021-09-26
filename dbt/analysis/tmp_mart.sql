
create  or replace table dbt_ted.tmp_mart as (
with mayor_range as (
    select 
        bbl_year_hash_id,
        borough,
        year,
        bbl,
        puma_name,
        lot_geometry,
        lot_centroid,
        max_resid_allw_far as end_far,
        lag(max_resid_allw_far) over(partition by bbl order by year) as start_far,
        lag(has_residential) over(partition by bbl order by year) as start_residential

    from dbt_ted.lot_year
    where 
        year in (2004, 2014)

),

    prep as (
    select 
        bbl, 
        lot_geometry,
        lot_centroid,
        borough,
        puma_name,
        end_far - start_far as far_diff,
        start_residential 
    from mayor_range
    where 
        year = 2014
)

select *,
    case
        when start_residential is null then null
        when far_diff > 0 then 'Upzone'
        when far_diff < 0 then 'Downzone'
    end as diff_cat
from prep

)