# install.packages('tidyverse')
# install.packages('lubridate')

library(tidyverse)
library(lubridate)
library(reshape2)
df <- read_csv('nordic_data.csv')

head(df)
summary(df)
str(df)
glimpse(df)

df_example_1 <- df %>%
  group_by(Country_Name) %>%
  summarise(Life_expectancy = max(Life_expectancy_at_birth_female_years_, na.rm = T)) %>%
  arrange(desc(Life_expectancy))
  
df_example_2 <- df %>%
  group_by(year) %>%
  summarise(avg_population_female = mean(Population_female_of_total_)) %>%
  arrange(desc(year))

## how top_n() works, pull versus select
df %>% 
  top_n(20, year) %>% 
  pull(year)

df %>% arrange(year) %>%
  top_n(20,year) %>%
  select(year, Country_Code)

df %>% 
  select(Country_Name, Fertility_rate_total_births_per_woman_, year) %>%
  spread(Country_Name, Fertility_rate_total_births_per_woman_) %>%
  top_n(5, year)


df_example_3 <- df %>% 
  top_n(20, year) %>% # totally hacking here
  group_by(Country_Name, year) %>%
  select(Fertility_rate_total_births_per_woman_) %>%
  spread(Country_Name, Fertility_rate_total_births_per_woman_)

# mutate examples start here
df_example_4 <- df %>%
  filter(year == year(Sys.Date())-2) %>%
  mutate(population_female_from_all = Population_ages_15_64_female/Population_ages_15_64_total,
         population_male_from_all = Population_ages_15_64_male/Population_ages_15_64_total) %>%
  select(Country_Name, population_female_from_all, population_male_from_all)


df_example_5 <- df %>%
  group_by(Country_Name) %>%
  select(year, Country_Name, Inflation_consumer_prices_annual_) %>%
  spread(Country_Name, Inflation_consumer_prices_annual_) 


df_example_6 <- df %>%
  select(Country_Name, year, Death_rate_crude_per_1_000_people_, Birth_rate_crude_per_1_000_people_) %>%
  mutate(births_per_death = Birth_rate_crude_per_1_000_people_/Death_rate_crude_per_1_000_people_) %>%
  select(Country_Name, year, births_per_death) %>%
  spread(Country_Name, births_per_death)


df_example_7 <- df %>%
  mutate(life_exp_ratio = Life_expectancy_at_birth_male_years_/Life_expectancy_at_birth_female_years_) %>%
  select(life_exp_ratio, year, Country_Name, Life_expectancy_at_birth_male_years_,Life_expectancy_at_birth_female_years_) %>%
  select(-Life_expectancy_at_birth_male_years_, -Life_expectancy_at_birth_female_years_) %>%
  spread(Country_Name, life_exp_ratio) %>%
  top_n(10, year)


df_example_8 <- df %>%
  select(GDP_growth_annual_, year, Country_Name) %>%
  spread(year, GDP_growth_annual_)


## Visualizations
# Visualization 1 - geom_line
melted_df_example_7 <- melt(df_example_7, id="year") 

plot_1 <- ggplot(data = melted_df_example_7, 
                 aes(x = year, y = value, color = variable)) +
           geom_line()

plot_1 <- plot_1 + theme_bw()
plot_1 <- plot_1 + labs(x = 'Year', 
                        y = 'Life Expectancy Ratio', 
                        title = '')

plot_1

# Visualization 2
plot_2 <- ggplot(df_example_2, 
                       aes(x = year, y = avg_population_female)) +
          geom_point(color = 'purple') + 
          geom_line(size = 5, alpha = 0.3)

plot_2 
#<- plot_2 +
#scale_y_continuous(limits = c())

# Visualization 3 - geom_bar - stacked
melted_df_example_3 <- melt(df_example_3, id="year") 

plot_3 <- ggplot(data = melted_df_example_3, 
                 aes(x = year, y = value)) +
        geom_bar(stat = 'identity', aes(fill = variable))

plot_3 <- plot_3 + 
          theme_gray() +
          labs(x = 'Year', 
               y = 'Total Births Per Woman', 
               title = 'Fertility Rate Total Births Per Woman Group by Country',
               fill = 'Country')

plot_3


# Visualization 3 - geom_bar - side by side 
plot_4 <- ggplot(data = melted_df_example_3, 
                 aes(x = year, y = value)) +
          geom_bar(stat="identity",
                   aes(fill = variable), width=.5, position = "dodge")  
          


plot_4 <- plot_4 +
          labs(x = 'Year', 
               y = 'Total Births Per Woman', 
               title = 'Fertility Rate Total Births Per Woman Group by Country',
               fill = 'Country')

plot_4