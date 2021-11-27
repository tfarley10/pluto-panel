{% docs lot_year %}

```sql
with start_year as (
select 
    year_start.bbl_year_hash_id as start_id,
    max_resid_allw_far,
    lot_geometry,
    has_residential,
    year_end.bbl_year_hash_id
from dbt_ted.lot_year as year_start
cross join unnest (bbl_year_combo) as year_end
where 
    year_end.year = 2014 and 
    year_start.year = 2004

),

yoy as (
    select 
        start_id,
        coalesce(start_year.has_residential, false) as has_residential,
        round(end_year.max_resid_allw_far - start_year.max_resid_allw_far, 3) as allw_far_diff,
        st_astext(start_year.lot_geometry) as lot_geometry
    from start_year
    inner join dbt_ted.lot_year as end_year using (bbl_year_hash_id)
    where 
        end_year.year = 2014
)

select 
    start_id,
    st_geogfromtext(lot_geometry, make_valid => TRUE) as lot_geometry,
    case
        when (has_residential = false or allw_far_diff = 0) then 'No Change/Non-Residential'
        when allw_far_diff > 0 then 'Upzone'
        when allw_far_diff < 0 then 'Downzone'
    end as difference_categorical
from yoy
```


{% enddocs %}