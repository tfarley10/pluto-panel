

  create or replace table `pluto-panel`.`dbt_ted`.`stg_borough_block`
  
  
  OPTIONS()
  as (
    

with borough_block as (
    select 
        borough_code,
        block,
        array_agg(distinct puma_geo_id) as puma_geo_ids,
        st_union_agg(lot_geometry) as borough_block_geometry,
        st_centroid(st_union_agg(lot_geometry)) as borough_block_centroid
    from `pluto-panel`.`dbt_ted`.`lot_year`
    where 
        year = 2020
    group by 1,2

),

prep2 as (
select 
  borough_block.borough_code,
  borough_block.block,
  st_astext(borough_block.borough_block_centroid) as borough_block_centroid,
  to_json_string(borough_block.puma_geo_ids) as puma_geo_ids,
  round(min(ST_Distance(borough_block.borough_block_centroid, stations.station_geom)), 2) as distance_meters,

  array_agg(struct(stations.station_name, station_geom) order by st_distance(borough_block.borough_block_centroid, stations.station_geom) limit 1)[ordinal(1)] as station_struct

from borough_block
join `bigquery-public-data.new_york_subway.stations` as stations on st_dwithin(borough_block.borough_block_centroid, stations.station_geom, 10000)
group by 1,2,3,4
)

select 
    borough_code,
    block,
    borough_code || block as borough_block,
    puma_geo_ids,
    distance_meters,
    station_struct.station_name,
    station_struct.station_geom as station_centroid,
    borough_block_centroid
from prep2
  );
    