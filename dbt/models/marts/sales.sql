{{config(
    materialized = "table",
    tags = ["sales"],
    cluster_by = ["bbl"],
    partition_by = {
        "field":"sale_year",
        "data_type":"int64",
      "range": {
        "start": 2002,
        "end": 2020,
        "interval": 1
      }
    }
)}}


select 
    *
from {{ref("stg_agg_sales")}}