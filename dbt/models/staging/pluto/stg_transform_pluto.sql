{{config(
    materialized = "table"
)}}

with prep as (
select 
    *,
    md5(year || borough_code || block || lot) as pluto_year_id,
    borough_code || block || lot as bbl
from {{ref('stg_agg_pluto')}}

)

select
    *,
    max_resid_allw_far - lag(max_resid_allw_far) over(partition by bbl order by year asc) as max_resid_allw_far_diff
from prep
