

  create or replace view `pluto-panel`.`dbt_ted`.`stg_acs_agg`
  OPTIONS()
  as 



select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2007 as year
from `bigquery-public-data.census_bureau_acs.puma_2007_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2008 as year
from `bigquery-public-data.census_bureau_acs.puma_2008_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2009 as year
from `bigquery-public-data.census_bureau_acs.puma_2009_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2010 as year
from `bigquery-public-data.census_bureau_acs.puma_2010_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2011 as year
from `bigquery-public-data.census_bureau_acs.puma_2011_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2012 as year
from `bigquery-public-data.census_bureau_acs.puma_2012_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2013 as year
from `bigquery-public-data.census_bureau_acs.puma_2013_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2014 as year
from `bigquery-public-data.census_bureau_acs.puma_2014_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2015 as year
from `bigquery-public-data.census_bureau_acs.puma_2015_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2016 as year
from `bigquery-public-data.census_bureau_acs.puma_2016_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2017 as year
from `bigquery-public-data.census_bureau_acs.puma_2017_1yr`
union all

select 
    geo_id,
    total_pop,
    pop_25_64,
    family_households,
    households,
    median_income,
    housing_units,
    median_rent,
    mortgaged_housing_units,
    gini_index,
    
    no_cars,
    not_us_citizen_pop,
    masters_degree,
    bachelors_degree,
    2018 as year
from `bigquery-public-data.census_bureau_acs.puma_2018_1yr`

;

