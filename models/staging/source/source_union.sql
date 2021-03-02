{%- set tables            = get_tables(table_like = 'raw_') -%}
{%- set zoning_dist       = ["zonedist1", "zn_dst1"]        -%}
{%- set zoning_dist2       = ["zonedist2", "zn_dst2"]        -%}
{%- set building_class    = ["bldg_cl", "bldgclass"]        -%}
{%- set historic_district = ["hst_dst", "histdist"]         -%}
{%- set total_units       = ["unitstotal", "unts_tt"]       -%}
{%- set residential_units = ["unts_rs", "unitsres"]         -%}
{%- set land_use          =  ["landuse", "land_us", "land_s2"] -%}
{%- set n_easements = ["nm_smnt", "easmnts", "easements"] -%}
{%- set owner_type = ["ownr_ty", "ownertype"] -%}
{%- set n_buildings = ["nm_bldg", "numbldgs"] -%}
{%- set n_floors = ["nm_flrs", "numfloors"] -%}
{%- set n_residential_units = ["unitsres", "unts_rs"] -%}
{%- set year_built = ["yearbuilt", "yer_blt"] -%}
{%- set year_alter1 = ["yer_ltr", "yearalter1", "yr_ltr1"] -%}
{%- set landmark = ["landmark", "landmrk"] -%}


{% for table in tables %}
  select
      uuid
    , date(year||'-01-01') as pluto_date
    , cast({{make_bbl()}} as varchar(10)) as bbl
    , st_transform(geometry, 4326) as geometry
    , {{add_column_from_list(acceptable_values = zoning_dist, table = table)}} as zoning_dist
    , {{add_column_from_list(acceptable_values = zoning_dist2, table = table)}} as zoning_dist2
    , {{add_column_from_list(acceptable_values = building_class, table = table)}} as building_class
    , {{add_column_from_list(acceptable_values = historic_district, table = table)}} as historic_district
    , {{add_column_from_list(acceptable_values = total_units, table = table)}} as total_units
    , {{add_column_from_list(acceptable_values = residential_units, table = table)}} as residential_units
    , {{add_column_from_list(acceptable_values = land_use, table = table)}} as land_use
    , {{add_column_from_list(acceptable_values = n_easements, table = table)}} as n_easements
    , {{add_column_from_list(acceptable_values = owner_type, table = table)}} as owner_type
    , {{add_column_from_list(acceptable_values = n_buildings, table = table)}} as n_buildings
    , {{add_column_from_list(acceptable_values = n_floors, table = table)}} as n_floors
    , {{add_column_from_list(acceptable_values = n_residential_units, table = table)}} as n_residential_units
    , {{add_column_from_list(acceptable_values = year_built, table = table)}} as year_built
    , {{add_column_from_list(acceptable_values = year_alter1, table = table)}} as year_alter1
    , {{add_column_from_list(acceptable_values = landmark, table = table)}} as landmark
  from source.{{table}}
  {% if not loop.last %}
  union all {% endif %}
  {% endfor %}
