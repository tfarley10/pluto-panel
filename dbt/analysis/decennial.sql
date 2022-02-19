with a as (
SELECT *, cast(GEOID as string) as geo_id
FROM `pluto-panel.dbt_ted.decennial_census` 
),

b as (
    SELECT *  FROM `bigquery-public-data.geo_census_tracts.census_tracts_new_york`
)

select * from a left join b on a.geo_id = b.geo_id