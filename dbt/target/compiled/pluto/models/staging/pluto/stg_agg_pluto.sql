






select 
    cast(split('pluto_2002', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    far as built_far,
    landuse2 as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2002`
union all

select 
    cast(split('pluto_2003', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    far as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2003`
union all

select 
    cast(split('pluto_2004', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2004`
union all

select 
    cast(split('pluto_2005', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2005`
union all

select 
    cast(split('pluto_2006', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2006`
union all

select 
    cast(split('pluto_2007', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2007`
union all

select 
    cast(split('pluto_2008', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2008`
union all

select 
    cast(split('pluto_2009', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2009`
union all

select 
    cast(split('pluto_2010', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2010`
union all

select 
    cast(split('pluto_2011', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2011`
union all

select 
    cast(split('pluto_2012', '_')[safe_offset(1)] as int64) as year,
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

    
    maxallwfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2012`
union all

select 
    cast(split('pluto_2013', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2013`
union all

select 
    cast(split('pluto_2014', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2014`
union all

select 
    cast(split('pluto_2015', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2015`
union all

select 
    cast(split('pluto_2016', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2016`
union all

select 
    cast(split('pluto_2017', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2017`
union all

select 
    cast(split('pluto_2018', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2018`
union all

select 
    cast(split('pluto_2019', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2019`
union all

select 
    cast(split('pluto_2020', '_')[safe_offset(1)] as int64) as year,
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

    
    residfar as max_resid_allw_far,
    builtfar as built_far,
    landuse as land_use_code,
    zonedist1 as primary_zoning_district,
    nullif(lower(trim(ownertype)), '') as owner_type_code,
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
    nullif(cast(histdist as string), '0') as historic_district,
    safe.st_geogfromwkb(geometry) as lot_geometry
from `pluto-panel`.`raw_pluto`.`pluto_2020`

