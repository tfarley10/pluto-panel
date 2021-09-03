{{config(
    materialized = "incremental",
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

with has_lag as (

    select 
        * 
    from {{ref('stg_lot_year')}}
    where
        (lag_bbl_year_hash_id is not null or year = 2002)

    union all 

    select * from {{ref('stg_missing_bbl')}}

),

missing_lag as (
    select 
        *
    from {{ref('stg_lot_year')}}
    where bbl_year_hash_id not in (
        select bbl_year_hash_id from has_lag
    )
),

final as (
    select * from has_lag

    union all 

    select * from missing_lag
)

select * from final


{% if is_incremental() %}

  where false

{% endif %}