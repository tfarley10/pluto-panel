{{config(
    materialized = "table"
)}}

with prep as (
select 

    md5(year || borough_code || block || lot) as pluto_year_id,
    borough_code || block || lot as bbl,
    *,
    st_centroid(geom) as lot_centroid
from {{ref('stg_agg_pluto')}}

)

{# year over year change in maximum allowable floor area ratio #}
select
    *,
    max_resid_allw_far - lag(max_resid_allw_far) over(partition by bbl order by year asc) as max_resid_allw_far_diff
from prep
join {{ref('stg_puma_geos')}} on st_within(lot_centroid, geometry)