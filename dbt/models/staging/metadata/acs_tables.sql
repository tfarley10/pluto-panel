with prep as (
    select
    table_name,
    regexp_extract(table_name, r'.+(\d{4}).+$') as year,
    regexp_extract(table_name, r'.+(\d{1})yr$') as estimate_length,
    max(regexp_extract(table_name, r'.+(\d{1})yr$')) over(partition by regexp_extract(table_name, r'.+(\d{4}).+$')) as max_rn
    from `bigquery-public-data.census_bureau_acs.INFORMATION_SCHEMA.TABLES`
    where regexp_contains(table_name, 'puma')
)

select table_name, estimate_length, year  from prep where estimate_length = max_rn