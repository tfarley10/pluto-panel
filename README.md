# NYC Zoning Data Project

## Objectives

1. Aggregate NYC Zoning data from 2002 - present in a reporducible manner

2. Add other sources of data such as census, ACRIS and Real Estate data to widen the scope of the dataset

3. Do data analysis

## Project Structure

- pluto-bq-ingest:
    - how I'm loading raw data into BigQuery
- dbt
    - modelling the data
- metadata
    - trying to add structure to the 19+ years of metadata that from PLUTO

    - python scripts that scrape the html and PDF metadata files
    


## Next Steps

### Census

-[Census Microdata](https://www.census.gov/data/developers/guidance/microdata-api-user-guide.html)  
    -[tds on Census API](https://towardsdatascience.com/using-the-us-census-api-for-data-analysis-a-beginners-guide-98063791785c)

### NYCHVS

- [use this](https://github.com/mdzhang/nychvs) for 2014 and 2017  
-  [lodown package r](http://asdfree.com/new-york-city-housing-and-vacancy-survey-nychvs.html) for anything before 
