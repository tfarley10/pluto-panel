select 
    *,
    md5(year || borough_code || block || lot) as pluto_year_id,
    borough_code || block || lot as bbl
from {{ref('agg_pluto')}}
