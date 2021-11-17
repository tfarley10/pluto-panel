

  create or replace view `pluto-panel`.`dbt_ted`.`agg_metadata`
  OPTIONS()
  as with union_metadata as (
    select
        *
    from `pluto-panel.metadata.metadata_2002_2003`

    union all 

    select
        *
    from `pluto-panel.metadata.metadata_2004_2020`
),

split_field as (
select
    field_name,
    data_type,
    source as data_source,
    definition,
    year as pluto_year,
    coalesce(replace(split(field_name,'(')[safe_offset(1)], ')', ''), field_name) as column_name

from union_metadata
where 
    CHAR_LENGTH(field_name) <= 150
)
select * from split_field;

