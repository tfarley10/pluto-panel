{{config(
  tags=["valu"]
)}}

with prep as (
select 
    {# farm_fingerprint(cast(boro as string)), #}
    year, 
    period, 
    parid, 
    boro as borough_code,
    residential_area_gross, 
    units,
    lpad(cast(block as string), 5, '0') as block,
    lpad(cast(lot as string), 4, '0') as lot

from `pluto-panel.raw_pluto.raw_valuation`
)

select 
    year,
    period,
    parid as par_id,
    borough_code,
    units as count_units,
    farm_fingerprint(borough_code || block || lot) as bbl_hash,
    farm_fingerprint(cast(year as string) || borough_code || block || lot) as bbl_year_hash_id,
    borough_code || block || lot as bbl
from prep


