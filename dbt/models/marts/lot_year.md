{% docs lot_year %}

# Year over Year Land Use Table

One of the biggest challenges here is making lot-level comparison's between two arbitrary years. This is difficult because a lot can be a) *subdivided* or b) *merged*. This is a slowly-changing dimension problem in which a given piece of land (lot) has no consistent identifier. For example if lot `12345` and `12346` are merged in 2015 this will create a new lot `12347` in 2017 which makes it difficult to compare the land use of the piece of land in 2015 to 2016.

## Strategy

To (partially) resolve this issue I make this comparison based on which 2016 lot the centroid of the 2015 lot is located within. Therefore, each `lot_year` row has a `bbl_year_hash_id` (combined year-lot_id) column that has key-value pairs (**year**:`bbl_year_hash_id`) for all years in the dataset called `bbl_year_combo` that can be used to make arbitrary year over year comparisons. 

## Example Query

Below is an example comparing the *Land Use Categories* for all lots between 2004 and 2014:

```sql
with map_lot as (
select
    
    start_year_record.bbl_year_hash_id as start_id,
    start_year_record.land_use_category as land_use_start,
    start_year_record.year as start_year,
    start_year_record.borough as borough,

    lead_year_record.year as lead_year,
    lead_year_record.bbl_year_hash_id as lead_id

from dbt_ted.lot_year as start_year_record
cross join unnest (bbl_year_combo) as lead_year_record
where
    start_year_record.year = 2004 and 
    lead_year_record.year = 2014
)

select 
    map_lot.borough,
    map_lot.land_use_start,
    lot_year.land_use_category as land_use_end
from map_lot 
inner join dbt_ted.lot_year 
                as lot_year on map_lot.lead_id = lot_year.bbl_year_hash_id
```


{% enddocs %}