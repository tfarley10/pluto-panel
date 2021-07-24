# Concepts  
- [ref](https://docs.getdbt.com/reference/dbt-jinja-functions/ref)
    - how to reference a model within a model
- [source](https://docs.getdbt.com/docs/building-a-dbt-project/using-sources)
    - schema definition defined in yaml file in models directory
    - videos on [sources](https://courses.getdbt.com/courses/take/fundamentals/lessons/17704147-reorganize-your-project)

# Data Modelling

1. make bbl column for all tables
    - use [dbt_utils.getcolumn_values](https://github.com/dbt-labs/dbt-utils/tree/0.7.0/#get_column_values-source) to validate that borough is consistent across all years
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
- [UNION ALL](https://discourse.getdbt.com/t/unioning-identically-structured-data-sources/921)
- [dbt hub](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/)
