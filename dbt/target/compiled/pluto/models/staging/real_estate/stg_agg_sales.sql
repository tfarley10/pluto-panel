



with prep as (


select 
    *
from `pluto-panel.real_estate.2003_raw`
union all

select 
    *
from `pluto-panel.real_estate.2004_raw`
union all

select 
    *
from `pluto-panel.real_estate.2005_raw`
union all

select 
    *
from `pluto-panel.real_estate.2006_raw`
union all

select 
    *
from `pluto-panel.real_estate.2007_raw`
union all

select 
    *
from `pluto-panel.real_estate.2008_raw`
union all

select 
    *
from `pluto-panel.real_estate.2009_raw`
union all

select 
    *
from `pluto-panel.real_estate.2010_raw`
union all

select 
    *
from `pluto-panel.real_estate.2011_raw`
union all

select 
    *
from `pluto-panel.real_estate.2012_raw`
union all

select 
    *
from `pluto-panel.real_estate.2013_raw`
union all

select 
    *
from `pluto-panel.real_estate.2014_raw`
union all

select 
    *
from `pluto-panel.real_estate.2015_raw`
union all

select 
    *
from `pluto-panel.real_estate.2016_raw`
union all

select 
    *
from `pluto-panel.real_estate.2017_raw`
union all

select 
    *
from `pluto-panel.real_estate.2018_raw`
union all

select 
    *
from `pluto-panel.real_estate.2019_raw`
union all

select 
    *
from `pluto-panel.real_estate.2020_raw`




),

final as (
    select 
        borough as borough_code,
        case borough
            when '1' then 'MN' 
            when '2' then 'BX' 
            when '3' then 'BK' 
            when '4' then 'QN' 
            when '5' then 'SI' 
        else borough end as borough,
        lpad(cast(block as string), 5, '0') as block,
        lpad(cast(lot as string), 4, '0') as lot,
        nullif(ease_ment, 'nan') as easement,
        address,
        safe_cast(residential_units as int64) as residential_units,
        safe_cast(commercial_units as int64) as commercial_units,
        safe_cast(total_units as int64) as total_units,
        safe_cast(land_square_feet as int64) as land_square_feet,
        safe_cast(gross_square_feet as int64) as gross_square_feet,
        safe_cast(sale_price as int64) as sale_price,
        date(substr(sale_date, 0, 10)) as sale_date,
        tax_class_at_present,
        tax_class_at_time_of_sale,
        building_class_at_present,
        building_class_at_time_of_sale
    from prep
)

select 
    borough_code || block || lot as bbl,
    extract(year from sale_date) as sale_year,
    *
from final