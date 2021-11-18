{{config(
    materialized = "view",
    tags = ["sales"]
)}}

{% set real_estate_years = ['2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020' ] %}

with prep as (

{% for yr in real_estate_years %}
select 
    *
from `pluto-panel.real_estate.{{yr}}_raw`
{% if not loop.last -%} union all {%- endif %}
{% endfor %}


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
        apartment_number,
        safe_cast(residential_units as int64) as residential_units,
        safe_cast(commercial_units as int64) as commercial_units,
        safe_cast(year_built as int64) as year_built,
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