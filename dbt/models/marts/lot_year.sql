{{config(
    materialized = "table",
    cluster_by = ["lot_geometry", "bbl"],
    partition_by = {
      "field": "year",
      "data_type": "int64",
      "range": {
        "start": 2002,
        "end": 2020,
        "interval": 1
      }
    }
)}}

select 
        * 
from {{ref('stg_lot_year')}}
left join {{ref('stg_lot_cartesian')}} using (bbl_year_hash_id)