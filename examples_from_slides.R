# install.packages('tidyverse')
# install.packages('lubridate')

library(tidyverse)
library(lubridate)
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
# Visualization 1

########### OLD ##############
df_example_7 <- df %>%
  filter(is.na(Critic.Score) == FALSE,
         is.na(User.Score) == FALSE) %>%
  mutate(difference_in_score = User.Score - Critic.Score) %>%
  arrange(desc(difference_in_score)) %>%
  select(Game, difference_in_score, Total.Sales, User.Score, Critic.Score)

p <- ggplot(data = df_example_7, mapping = aes(x = Critic.Score, y = User.Score, size = Total.Sales)) 
p <- p + geom_point() 
p <- p + theme_bw()
p <- p + labs(x = 'Critic Score', y = 'User Score', title = 'How does the critic score compare to user score for top sold games?', size = 'Total Sales')
p

# Visualization 2
df_example_9 <-
  df %>% 
  filter(Console %in% c('PS', 'PS2', 'PS3', 'PS4'), Release.Year >= 1994) %>% 
  group_by(Release.Year) %>% 
  summarise(Total.Sales = sum(Total.Sales, na.rm = T)) 

df_example_9

p <- ggplot(data = df_example_9, mapping = aes(x = Release.Year, y = Total.Sales)) 
p <- p + geom_line()
p <- p + geom_point()
p <- p + theme_bw()
p <- p + labs(x = 'Release Year', y = 'Total Sales', title = 'Total PlayStation Games Sales over Years')
p 

# Visualization 3 
df_example_10 <-
  df %>% 
  filter(Console %in% c('PS', 'PS2', 'PS3', 'PS4'), Release.Year >= 1994) %>% 
  group_by(Release.Year, Console) %>% 
  summarise(Total.Sales = sum(Total.Sales, na.rm = T)) 

df_example_10

p <- ggplot(data = df_example_10, mapping = aes(x = Release.Year, y = Total.Sales, color = Console)) 
p <- p + geom_line()
p <- p + geom_point()
p <- p + theme_bw()
p <- p + labs(x = 'Release Year', y = 'Total Sales', title = 'How many PlayStation games (by models) are sold over the years?', color = 'Console Type')
p 

# Visualization 4
df_example_11 <- 
  df_example_8 %>% 
  gather(key = region, value = sales, NA.Sales.all.games, Japan.Sales.all.games, PAL.Sales.all.games)  

p <- ggplot(data = df_example_11, mapping = aes(x = reorder(Console, sales), y = sales, fill = region)) 
p <- p + geom_col()
p <- p + theme_bw() 
p <- p + coord_flip()
p <- p + labs(x = 'Console', y = 'Total Sales', title = 'How many games are sold (by console type) in different regions?', fill = 'Region')
p

