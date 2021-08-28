select 
    '360' || puma2010 as puma_geo_id,
    pumaname10 as puma_name,
    st_geogfromtext(geometry) as geometry

from `pluto-panel.metadata.puma_geography` 