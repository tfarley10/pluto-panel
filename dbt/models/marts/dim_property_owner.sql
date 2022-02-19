{{
    config(
        materialized = "table",
        tags = ["acris"]
    )
}}
select 
    * except(party_type)
from {{ref('stg_acris_parties_long')}}
where 
    party_type = 'GRANTEE/BUYER'