
with prep as (
    select 
        * ,
        split(regexp_replace(trim(label), '^!!|:', ''), '!!') as label_c,
        lower(regexp_extract(name, '^[A-Z]+')) as suffix
    from metadata.stg_decennial
),

prep2 as (
    select
        *,
        label_c[safe_offset(0)] as h1,
        label_c[safe_offset(1)] as h2,
        label_c[safe_offset(2)] as h3,
        label_c[safe_offset(3)] as h4,
        label_c[safe_offset(4)] as h5,
        label_c[safe_offset(5)] as h6,
        case suffix 
            when 'p' then 'population'
            when 'pct' then 'population_census_tract'
            when 'h' then 'household'
            when 'pco' then 'population_county'
            when 'hct' then 'household_census_tract'
            else null
        end as suffix_clean
    from prep

),

final as (
select 
    lower(concept) as concept,
    label,
    name as variable,
    year,
    suffix_clean as suffix,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6
from prep2
)

select * from final

