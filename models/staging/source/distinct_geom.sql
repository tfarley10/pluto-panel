

{{
  config(
    schema='agg'
    , materialized = 'incremental'
  )
}}

{% set tables = get_tables(table_like = 'raw_') %}

with geoms as (
{% for table in tables %}
  select
    st_transform(geometry, 4326) as geometry
    , date(year||'-01-01') as pluto_date

  from source.{{table}}
  {% if not loop.last -%} union all {%- endif %}
  {% endfor %}
)



, geom_hash as (
  select
        distinct on(geometry) geometry
      , pluto_date
      , st_geohash(geometry, 36) as geom_id
  from geoms
)

select
  *
from geom_hash

  {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where date(now()) < (select max(pluto_date) from {{ this }})

{% endif %}


order by geom_id, pluto_date
