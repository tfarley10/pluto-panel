{% set pluto_tables = get_pluto_tables() %}
{% set max_far_col = ["residfar", "maxallwfar"] %}
{% set built_far_col = ["far", "builtfar"] %}

{% for tb in pluto_tables %}
select 
    split('{{tb}}', '_')[safe_offset(1)] as year,
    borough,
    case borough 
        when 'MN' then '1'
        when 'BX' then '2'
        when 'BK' then '3'
        when 'QN' then '4'
        when 'SI' then '5'
        else borough
    end as borough_code,
    lpad(cast(block as string), 5, '0') as block,
    lpad(cast(lot as string), 4, '0') as lot,
    {{across(dbtplyr.one_of(max_far_col, source('pluto', tb )), "{{var}}")}} as max_resid_allw_far,
    {{across(dbtplyr.one_of(built_far_col, source('pluto', tb )), "{{var}}")}} as built_far,
    {{across(dbtplyr.starts_with('landuse', source('pluto', tb )), "{{var}}")}} as land_use_category,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type,
    ownername as owner_name,
    resarea as residentail_floor_area,
    comarea as commercial_floor_area,
    numbldgs as count_buildings,
    numfloors as total_floors,
    unitstotal as total_units,
    unitsres as total_residential_units,
    assessland as assessed_land_value,
    yearbuilt as year_built,
    address as lot_address,
    cast(histdist as string) as historic_district,
    safe.st_geogfromtext(wkt_geom) as geom
from {{source('pluto', tb )}}
{% if not loop.last -%} union all {%- endif %}
{% endfor %}
