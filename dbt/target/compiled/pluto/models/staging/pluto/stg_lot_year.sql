

with prep as (
    select 
        *,
        case 
            when cast(lot as integer) < 1000 then 'traditional'
            when cast(lot as integer) between 1001 and 6999 then 'condo_units'
            when cast(lot as integer) between 7501 and 7599 then 'condo_billing'
            when cast(lot as integer) between 8000 and 8899 then 'subterranean'
            when cast(lot as integer) between 8900 and 8999 then 'dtm_dummy'
            when cast(lot as integer) > 8999 then 'air_rights'
            else null
        end as lot_category,
        borough_code || block || lot as bbl,
        st_centroid(lot_geometry) as lot_centroid,
        farm_fingerprint(borough_code || block || lot) as bbl_hash,
        farm_fingerprint(cast(year as string) || borough_code || block || lot) as bbl_year_hash_id

    from `pluto-panel`.`dbt_ted`.`stg_agg_pluto`
    where
        not st_isempty(lot_geometry)

),

land_use_map as (
    select 
        land_use_code,
        land_use_category,
        has_residential
    from `pluto-panel`.`dbt_ted`.`land_use`
),

owner_type_map as (
    select
        owner_type_code,
        owner_type_category
    from `pluto-panel`.`dbt_ted`.`owner_type`
),

map_categories as (
    select 
        * except(land_use_code, owner_type_code)
    from prep 
    left join land_use_map using (land_use_code)
    left join owner_type_map using (owner_type_code)
        
),

final as (


select
    map_categories.* replace(coalesce(owner_type_category, 'private') as owner_type_category),
    st_geohash(lot_centroid, 20) as centroid_geohash,
    puma_geo_id
from map_categories
inner join `pluto-panel`.`dbt_ted`.`stg_puma_geos` on st_intersects(lot_centroid, puma_geometry)

)

select 
    * 
from final