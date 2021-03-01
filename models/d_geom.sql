
{{
  config(
    schema='agg',
    materialized= 'table'
  )
}}
select
    distinct on(geometry)  geometry
    , {{add_uuid()}} as geom_uuid
from {{ ref('pluto_lot') }}
