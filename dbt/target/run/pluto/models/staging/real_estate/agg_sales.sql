

  create or replace view `pluto-panel`.`dbt_ted`.`agg_sales`
  OPTIONS()
  as 



select 
    *
from `pluto-panel.real_estate.2003_raw`
union all

select 
    *
from `pluto-panel.real_estate.2004_raw`
union all

select 
    *
from `pluto-panel.real_estate.2005_raw`
union all

select 
    *
from `pluto-panel.real_estate.2006_raw`
union all

select 
    *
from `pluto-panel.real_estate.2007_raw`
union all

select 
    *
from `pluto-panel.real_estate.2008_raw`
union all

select 
    *
from `pluto-panel.real_estate.2009_raw`
union all

select 
    *
from `pluto-panel.real_estate.2010_raw`
union all

select 
    *
from `pluto-panel.real_estate.2011_raw`
union all

select 
    *
from `pluto-panel.real_estate.2012_raw`
union all

select 
    *
from `pluto-panel.real_estate.2013_raw`
union all

select 
    *
from `pluto-panel.real_estate.2014_raw`
union all

select 
    *
from `pluto-panel.real_estate.2015_raw`
union all

select 
    *
from `pluto-panel.real_estate.2016_raw`
union all

select 
    *
from `pluto-panel.real_estate.2017_raw`
union all

select 
    *
from `pluto-panel.real_estate.2018_raw`
union all

select 
    *
from `pluto-panel.real_estate.2019_raw`
union all

select 
    *
from `pluto-panel.real_estate.2020_raw`

;

