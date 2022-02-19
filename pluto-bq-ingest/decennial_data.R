library(tidyverse)
library(tidycensus)
library(plutoHelpers)

d <- 
tibble::tribble(
           ~measure,    ~`2000`,   ~`2010`,   ~`2020`,
         "total", "P003001", "P005001", "P1_001N",
  "total_single", "P003002", "P005002", "P1_002N",
         "white", "P003003", "P005003", "P1_003N",
         "black", "P003004", "P005004", "P1_004N",
        "native", "P003005", "P005005", "P1_005N",
         "asian", "P003006", "P005006", "P1_006N",
         "other", "P003008", "P005008", "P1_008N"
  )



l <- list(`2020` = d$`2020`,
     `2010` = d$`2010`,
     `2000` = d$`2000`) %>% 
  map(~set_names(.x, d$measure))



get_dec <- function(yr = NULL, vars = NULL){ 
    get_decennial(geography = "tract", variables = vars, year = yr, state = "NY", geometry = F) %>% 
    mutate(year = yr)
}


c_data <- map2_dfr(c(2020, 2010, 2000), l, ~get_dec(yr = .x, vars = .y))


saveRDS(c_data, "decennial.RDS")

con <- plutoHelpers::get_con(dataset = "")


DBI::dbWriteTable(con, "decennial_census", c_data)


