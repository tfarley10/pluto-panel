
{{
  config(
    schema='agg',
    materialized= 'table'
  )
}}
select
  *
from {{ ref('source_union') }}
