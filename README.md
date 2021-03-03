## Aggregating NYCPlanning's [MapPluto](https://www1.nyc.gov/site/planning/data-maps/open-data/bytes-archive.page?sorts[year]=0) data

- This is a personal project I'm using to learn how to use [dbt](getdbt.com)

- New York City Planning has an archive of historical land use data. The data goes back to 2002 (20 years of data so far)

- I'm essentially just doing:
  `select 2002  ...
  union all ... select 2021` but the metadata changes from year to year


- All of the data are in shapefiles each having around 800k unique lots. One of the biggest challenges is that lots get merged and subdivide so the data needs to include geographies from every lot, every year.
