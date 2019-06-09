
library(readr)
library(tidyverse)
library(magrittr)
library(lettercase)

#### Data source: The World Bank
#### Original data: https://datacatalog.worldbank.org/dataset/gender-statistics
#### Used under CC license: https://datacatalog.worldbank.org/public-licenses#cc-by 
#### Changes made to data: filtering for selected Nordic countries


df <- read_csv('Gender_StatsData.csv')

# names for the first 4 columns have spaces
names(df)[1:4] %<>% make_names()

# clean the data; reshape it twice
df_clean <- df %>% 
  select(-X64) %>%
  gather(year, val, -Country_Name, -Country_Code, -Indicator_Name, -Indicator_Code) %>%
  select(-Indicator_Code) %>%
  spread(Indicator_Name, val) 

# make pretty names for the categories
names(df_clean) %<>% make_names()

# how many NAs? -- many
colMeans(is.na(df_clean))

# na % by country by metric
nas <- df_clean %>% 
  group_by(Country_Name) %>%
  summarise_each(funs(100*mean(is.na(.)))) %>%
  gather(metric, val, -Country_Name, -Country_Code, -year) 

## top countries
nas %>% 
  group_by(Country_Name) %>% 
  summarise(mean(val)) %>% 
  arrange(`mean(val)`)

# countries that could work: 
countries_selected <- c('Denmark', 'Norway', 'Sweden', 'Finland')

# save metrics which have less than 5% nas
metrics_to_use <- nas %>% 
  filter(Country_Name %in% !!countries_selected) %>%
  group_by(metric) %>% 
  summarise(mean(val)) %>% 
  arrange(`mean(val)`) %>%
  filter(`mean(val)` <= 5) %>%
  pull(metric)

# save into df
nordics <- df_clean %>%
  filter(Country_Name %in% !!countries_selected) %>%
  select(year, Country_Name, Country_Code, !!metrics_to_use)

# another NA check -- looks ok
colMeans(is.na(nordics))

write_csv(nordics, 'nordic_data.csv')


