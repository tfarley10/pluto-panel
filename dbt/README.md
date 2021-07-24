# Data Modelling

1. make bbl column for all tables
    - map borough -> borough_code	
        -  MN -> 1
        -  BX -> 2
        -  BK -> 3
        -  QN -> 4
        -  SI -> 5

1. make bbl-year unique key for all years
1. union columns that exist in all tables

1. Setup [odbc connection from bq -> r](https://bigrquery.r-dbi.org/)
1. Make a table that has metadata & definitions for pluto fields for all years


### Resources:
-  dbt [in the docs](https://docs.getdbt.com/docs/introduction)
