Introduction to tidyverse
========================================================
author: Anastasia Kuprina & Hazel Kavili
date: 09/06/2019
autosize: true

<style>

.tiny-text p {
  font-size: 5px; /*does not fucking work*/
}
.reveal .slides{
    height: 95% !important;  /* or other width */
}
.reveal h1, .reveal h2, .reveal h3 {
  word-wrap: normal;
  -moz-hyphens: none;
}
.reveal p, .reveal li, .reveal ul {
  font-size: 0.9em;
}
.small-code pre code {
  font-size: 0.9em;
}
</style>

Who are we?
========================================================

![Anastasia](https://ohjelmistoebusiness.fi/wp-content/uploads/2019/02/seriously-portrait2016_Anastasia-1-300x330.jpg)

- Has been doing data analysis since late 2016
- Knows SQL, R and Python. Studying more Python & stats
- Tries to improve diversity and inclusivity of tech by organising regular codebar workshops and other events

***

![Hazel](https://ohjelmistoebusiness.fi/wp-content/uploads/2019/02/Hazel-Kavili-seriously-highres-2-300x330.jpg)

- Write stuff here
- and here
- and here too


Why tidyverse?
========================================================
<br/>
- A huge community supported by RStudio themselves
- Help and support in social media
- tidytuesday

***
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/tidyverse_popularity.png" width=1000px>
</div>

Some interesting tidyverse learning & usage data
========================================================
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/survey_responses.png" width=1000px>
</div>

Data analysis workflow
========================================================
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/process.png" width=900px>
</div>


Data analysis workflow: tidyverse version
========================================================
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/tidyverse_map.png" width=1000px>
</div>


Data analysis workflow in our daily work
========================================================
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/seriously_map.png" width=800px>
</div>

Let's get to it!
========================================================

**Step 1**: Start up a new project in RStudio (File -> New project and follow the instructions)

**Step 2**: Make sure to install packages:


```r
install.packages('tidyverse', 'lubridate')
```
Note: if the package installer asks you whether or not to install with compilcation, respond 'n' for 'no'.

**Step 3**: Create a new script (File -> New script)

**Step 4**: Load libraries into the session & fetch the data:


```r
library(tidyverse)
library(lubridate)

df <- readr::read_csv('https://raw.githubusercontent.com/kuprinaga/R-ladies-workshop/master/nordic_data.csv')
```


Reading data in
========================================================



```r
readr::read_csv('example.csv')
readr::read_tsv('example.tsv')
readr::read_table('example.txt')
```
<br/>
Why use readr?
- progress bar
- faster for large files
- outputs exactly what the column types are 
- can automatically parse data types
- outputs a tibble (tidy dataframe)


Kind of a side note
========================================================
### Why tibble?
- printing (shows only the first 10 rows, and all the columns that fit on screen + datatype)
- Tibbles are strict about subsetting: <br/>
-> [] always returns another tibble, <br/>
-> [[]] always returns a vector
- Tibbles do not return partial names
- Strings are strings, not factors


Let's learn more about the data
========================================================
class: small-code

```r
summary(df)
```

```
      year      Country_Name       Country_Code      
 Min.   :1960   Length:236         Length:236        
 1st Qu.:1974   Class :character   Class :character  
 Median :1989   Mode  :character   Mode  :character  
 Mean   :1989                                        
 3rd Qu.:2004                                        
 Max.   :2018                                        
                                                     
 Adolescent_fertility_rate_births_per_1_000_women_ages_15_19_
 Min.   : 4.123                                              
 1st Qu.: 8.036                                              
 Median :12.164                                              
 Mean   :17.308                                              
 3rd Qu.:26.617                                              
 Max.   :45.913                                              
 NA's   :4                                                   
 Age_dependency_ratio_of_working_age_population_
 Min.   :46.85                                  
 1st Qu.:50.69                                  
 Median :54.05                                  
 Mean   :53.56                                  
 3rd Qu.:56.02                                  
 Max.   :60.60                                  
 NA's   :4                                      
 Age_population_age_0_female_interpolated
 Min.   :22803                           
 1st Qu.:28794                           
 Median :31913                           
 Mean   :36079                           
 3rd Qu.:40590                           
 Max.   :60289                           
 NA's   :4                               
 Age_population_age_0_male_interpolated
 Min.   :24234                         
 1st Qu.:30260                         
 Median :33476                         
 Mean   :37934                         
 3rd Qu.:42520                         
 Max.   :63430                         
 NA's   :4                             
 Age_population_age_01_female_interpolated
 Min.   :23102                            
 1st Qu.:29277                            
 Median :31780                            
 Mean   :36182                            
 3rd Qu.:40718                            
 Max.   :59392                            
 NA's   :4                                
 Age_population_age_01_male_interpolated
 Min.   :24492                          
 1st Qu.:30742                          
 Median :33418                          
 Mean   :38038                          
 3rd Qu.:42674                          
 Max.   :62511                          
 NA's   :4                              
 Age_population_age_02_female_interpolated
 Min.   :23382                            
 1st Qu.:29532                            
 Median :31764                            
 Mean   :36298                            
 3rd Qu.:40545                            
 Max.   :59071                            
 NA's   :4                                
 Age_population_age_02_male_interpolated
 Min.   :24732                          
 1st Qu.:31027                          
 Median :33329                          
 Mean   :38154                          
 3rd Qu.:42391                          
 Max.   :62168                          
 NA's   :4                              
 Age_population_age_03_female_interpolated
 Min.   :23653                            
 1st Qu.:29556                            
 Median :31875                            
 Mean   :36442                            
 3rd Qu.:40156                            
 Max.   :58930                            
 NA's   :4                                
 Age_population_age_03_male_interpolated
 Min.   :24963                          
 1st Qu.:31150                          
 Median :33482                          
 Mean   :38305                          
 3rd Qu.:41956                          
 Max.   :62012                          
 NA's   :4                              
 Age_population_age_04_female_interpolated
 Min.   :23899                            
 1st Qu.:29674                            
 Median :32045                            
 Mean   :36559                            
 3rd Qu.:40056                            
 Max.   :58998                            
 NA's   :4                                
 Age_population_age_04_male_interpolated
 Min.   :25153                          
 1st Qu.:31270                          
 Median :33696                          
 Mean   :38425                          
 3rd Qu.:41927                          
 Max.   :62097                          
 NA's   :4                              
 Age_population_age_05_female_interpolated
 Min.   :24085                            
 1st Qu.:29895                            
 Median :32161                            
 Mean   :36662                            
 3rd Qu.:41143                            
 Max.   :59061                            
 NA's   :4                                
 Age_population_age_05_male_interpolated
 Min.   :25338                          
 1st Qu.:31434                          
 Median :33805                          
 Mean   :38527                          
 3rd Qu.:42903                          
 Max.   :62122                          
 NA's   :4                              
 Birth_rate_crude_per_1_000_people_ Death_rate_crude_per_1_000_people_
 Min.   : 9.10                      Min.   : 7.700                    
 1st Qu.:11.50                      1st Qu.: 9.500                    
 Median :12.60                      Median : 9.900                    
 Mean   :13.04                      Mean   : 9.993                    
 3rd Qu.:14.00                      3rd Qu.:10.500                    
 Max.   :18.50                      Max.   :12.100                    
 NA's   :4                          NA's   :4                         
 Fertility_rate_total_births_per_woman_ GDP_current_US_    
 Min.   :1.380                          Min.   :5.163e+09  
 1st Qu.:1.710                          1st Qu.:3.400e+10  
 Median :1.810                          Median :1.194e+11  
 Mean   :1.904                          Mean   :1.574e+11  
 3rd Qu.:1.942                          3rd Qu.:2.531e+11  
 Max.   :2.980                          Max.   :5.794e+11  
 NA's   :4                              NA's   :4          
 GDP_per_capita_Current_US_ Inflation_consumer_prices_annual_
 Min.   :  1179             Min.   :-0.4945                  
 1st Qu.:  6764             1st Qu.: 1.9253                  
 Median : 22422             Median : 3.4165                  
 Mean   : 26283             Mean   : 4.5857                  
 3rd Qu.: 38654             3rd Qu.: 6.9353                  
 Max.   :103059             Max.   :17.8114                  
 NA's   :4                  NA's   :4                        
 Life_expectancy_at_birth_female_years_
 Min.   :72.24                         
 1st Qu.:77.35                         
 Median :79.20                         
 Mean   :79.25                         
 3rd Qu.:81.65                         
 Max.   :84.40                         
 NA's   :4                             
 Life_expectancy_at_birth_male_years_ Population_ages_0_14_female
 Min.   :65.09                        Min.   :391307             
 1st Qu.:71.23                        1st Qu.:449800             
 Median :72.78                        Median :475984             
 Mean   :73.52                        Mean   :554806             
 3rd Qu.:76.22                        3rd Qu.:678134             
 Max.   :80.90                        Max.   :858311             
 NA's   :4                            NA's   :4                  
 Population_ages_0_14_of_total_ Population_ages_15_64_female
 Min.   :16.37                  Min.   :1127457             
 1st Qu.:17.96                  1st Qu.:1532222             
 Median :19.28                  Median :1677554             
 Mean   :20.13                  Mean   :1857320             
 3rd Qu.:21.74                  3rd Qu.:1981936             
 Max.   :30.41                  Max.   :3086964             
 NA's   :4                      NA's   :4                   
 Population_ages_15_64_male Population_ages_15_64_of_total_
 Min.   :1129967            Min.   :62.27                  
 1st Qu.:1501511            1st Qu.:64.09                  
 Median :1723196            Median :64.91                  
 Mean   :1891386            Mean   :65.15                  
 3rd Qu.:2009612            3rd Qu.:66.36                  
 Max.   :3197079            Max.   :68.10                  
 NA's   :4                  NA's   :4                      
 Population_ages_15_64_total Population_ages_65_and_above_female
 Min.   :2257422             Min.   : 203691                    
 1st Qu.:3038145             1st Qu.: 369027                    
 Median :3403464             Median : 456222                    
 Mean   :3748712             Mean   : 500324                    
 3rd Qu.:3991547             3rd Qu.: 575268                    
 Max.   :6284045             Max.   :1079139                    
 NA's   :4                   NA's   :4                          
 Population_ages_65_and_above_of_total_ Population_female
 Min.   : 7.328                         Min.   :1797400  
 1st Qu.:12.886                         1st Qu.:2368052  
 Median :15.007                         Median :2596508  
 Mean   :14.713                         Mean   :2912450  
 3rd Qu.:16.360                         3rd Qu.:3111078  
 Max.   :21.228                         Max.   :5024414  
 NA's   :4                              NA's   :4        
 Population_female_of_total_ Population_total   GDP_growth_annual_
 Min.   :49.55               Min.   : 3581239   Min.   :-8.269    
 1st Qu.:50.33               1st Qu.: 4623662   1st Qu.: 1.507    
 Median :50.52               Median : 5122300   Median : 2.756    
 Mean   :50.63               Mean   : 5757404   Mean   : 2.734    
 3rd Qu.:50.72               3rd Qu.: 6194899   3rd Qu.: 4.162    
 Max.   :51.83               Max.   :10057698   Max.   : 9.593    
 NA's   :4                   NA's   :4          NA's   :8         
```

========================================================
class: small-code

```r
head(df, 10)
```

```
# A tibble: 10 x 37
    year Country_Name Country_Code Adolescent_fert… Age_dependency_…
   <dbl> <chr>        <chr>                   <dbl>            <dbl>
 1  1960 Denmark      DNK                      44.2             55.8
 2  1961 Denmark      DNK                      45.0             55.6
 3  1962 Denmark      DNK                      45.9             55.2
 4  1963 Denmark      DNK                      45.5             54.8
 5  1964 Denmark      DNK                      45.1             54.5
 6  1965 Denmark      DNK                      44.7             54.3
 7  1966 Denmark      DNK                      44.4             54.4
 8  1967 Denmark      DNK                      44.0             54.6
 9  1968 Denmark      DNK                      40.7             54.8
10  1969 Denmark      DNK                      37.4             55.0
# … with 32 more variables:
#   Age_population_age_0_female_interpolated <dbl>,
#   Age_population_age_0_male_interpolated <dbl>,
#   Age_population_age_01_female_interpolated <dbl>,
#   Age_population_age_01_male_interpolated <dbl>,
#   Age_population_age_02_female_interpolated <dbl>,
#   Age_population_age_02_male_interpolated <dbl>,
#   Age_population_age_03_female_interpolated <dbl>,
#   Age_population_age_03_male_interpolated <dbl>,
#   Age_population_age_04_female_interpolated <dbl>,
#   Age_population_age_04_male_interpolated <dbl>,
#   Age_population_age_05_female_interpolated <dbl>,
#   Age_population_age_05_male_interpolated <dbl>,
#   Birth_rate_crude_per_1_000_people_ <dbl>,
#   Death_rate_crude_per_1_000_people_ <dbl>,
#   Fertility_rate_total_births_per_woman_ <dbl>, GDP_current_US_ <dbl>,
#   GDP_per_capita_Current_US_ <dbl>,
#   Inflation_consumer_prices_annual_ <dbl>,
#   Life_expectancy_at_birth_female_years_ <dbl>,
#   Life_expectancy_at_birth_male_years_ <dbl>,
#   Population_ages_0_14_female <dbl>,
#   Population_ages_0_14_of_total_ <dbl>,
#   Population_ages_15_64_female <dbl>, Population_ages_15_64_male <dbl>,
#   Population_ages_15_64_of_total_ <dbl>,
#   Population_ages_15_64_total <dbl>,
#   Population_ages_65_and_above_female <dbl>,
#   Population_ages_65_and_above_of_total_ <dbl>, Population_female <dbl>,
#   Population_female_of_total_ <dbl>, Population_total <dbl>,
#   GDP_growth_annual_ <dbl>
```

========================================================
class: small-code

```r
str(df)
```

```
Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame':	236 obs. of  37 variables:
 $ year                                                        : num  1960 1961 1962 1963 1964 ...
 $ Country_Name                                                : chr  "Denmark" "Denmark" "Denmark" "Denmark" ...
 $ Country_Code                                                : chr  "DNK" "DNK" "DNK" "DNK" ...
 $ Adolescent_fertility_rate_births_per_1_000_women_ages_15_19_: num  44.2 45 45.9 45.5 45.1 ...
 $ Age_dependency_ratio_of_working_age_population_             : num  55.8 55.6 55.2 54.8 54.5 ...
 $ Age_population_age_0_female_interpolated                    : num  38797 39700 40226 40386 40240 ...
 $ Age_population_age_0_male_interpolated                      : num  40519 41292 41731 41866 41780 ...
 $ Age_population_age_01_female_interpolated                   : num  36505 38292 37831 38443 38877 ...
 $ Age_population_age_01_male_interpolated                     : num  38452 40044 39555 40095 40520 ...
 $ Age_population_age_02_female_interpolated                   : num  35003 36372 37831 36967 37758 ...
 $ Age_population_age_02_male_interpolated                     : num  37117 38315 39612 38763 39496 ...
 $ Age_population_age_03_female_interpolated                   : num  34189 35103 36280 37392 36868 ...
 $ Age_population_age_03_male_interpolated                     : num  36418 37192 38219 39205 38693 ...
 $ Age_population_age_04_female_interpolated                   : num  33961 34406 35242 36209 36949 ...
 $ Age_population_age_04_male_interpolated                     : num  36259 36599 37306 38147 38799 ...
 $ Age_population_age_05_female_interpolated                   : num  34218 34203 34663 35403 36135 ...
 $ Age_population_age_05_male_interpolated                     : num  36545 36461 36818 37444 38078 ...
 $ Birth_rate_crude_per_1_000_people_                          : num  16.6 16.6 16.7 17.6 17.7 18 18.4 16.8 15.3 14.6 ...
 $ Death_rate_crude_per_1_000_people_                          : num  9.5 9.4 9.8 9.8 9.9 10.1 10.3 9.9 9.7 9.8 ...
 $ Fertility_rate_total_births_per_woman_                      : num  2.57 2.55 2.55 2.67 2.6 2.61 2.62 2.35 2.12 2 ...
 $ GDP_current_US_                                             : num  6.25e+09 6.93e+09 7.81e+09 8.32e+09 9.51e+09 ...
 $ GDP_per_capita_Current_US_                                  : num  1365 1504 1681 1775 2013 ...
 $ Inflation_consumer_prices_annual_                           : num  1.26 3.45 7.38 6.11 3.09 ...
 $ Life_expectancy_at_birth_female_years_                      : num  74 74.4 74.4 74.5 74.8 ...
 $ Life_expectancy_at_birth_male_years_                        : num  70.4 70.6 70.3 70.4 70.3 ...
 $ Population_ages_0_14_female                                 : num  561643 560269 557581 554298 552010 ...
 $ Population_ages_0_14_of_total_                              : num  25.2 25 24.7 24.3 24 ...
 $ Population_ages_15_64_female                                : num  1484063 1495246 1509267 1523949 1537736 ...
 $ Population_ages_15_64_male                                  : num  1455561 1468735 1484952 1502241 1519265 ...
 $ Population_ages_15_64_of_total_                             : num  64.2 64.3 64.4 64.6 64.7 ...
 $ Population_ages_15_64_total                                 : num  2939628 2963981 2994219 3026185 3056997 ...
 $ Population_ages_65_and_above_female                         : num  261702 268492 275846 283448 291111 ...
 $ Population_ages_65_and_above_of_total_                      : num  10.6 10.8 10.9 11.1 11.2 ...
 $ Population_female                                           : num  2307409 2324007 2342694 2361695 2380857 ...
 $ Population_female_of_total_                                 : num  50.4 50.4 50.4 50.4 50.4 ...
 $ Population_total                                            : num  4579603 4611687 4647727 4684483 4722072 ...
 $ GDP_growth_annual_                                          : num  NA 6.379 5.667 0.637 9.27 ...
 - attr(*, "spec")=
  .. cols(
  ..   year = col_double(),
  ..   Country_Name = col_character(),
  ..   Country_Code = col_character(),
  ..   Adolescent_fertility_rate_births_per_1_000_women_ages_15_19_ = col_double(),
  ..   Age_dependency_ratio_of_working_age_population_ = col_double(),
  ..   Age_population_age_0_female_interpolated = col_double(),
  ..   Age_population_age_0_male_interpolated = col_double(),
  ..   Age_population_age_01_female_interpolated = col_double(),
  ..   Age_population_age_01_male_interpolated = col_double(),
  ..   Age_population_age_02_female_interpolated = col_double(),
  ..   Age_population_age_02_male_interpolated = col_double(),
  ..   Age_population_age_03_female_interpolated = col_double(),
  ..   Age_population_age_03_male_interpolated = col_double(),
  ..   Age_population_age_04_female_interpolated = col_double(),
  ..   Age_population_age_04_male_interpolated = col_double(),
  ..   Age_population_age_05_female_interpolated = col_double(),
  ..   Age_population_age_05_male_interpolated = col_double(),
  ..   Birth_rate_crude_per_1_000_people_ = col_double(),
  ..   Death_rate_crude_per_1_000_people_ = col_double(),
  ..   Fertility_rate_total_births_per_woman_ = col_double(),
  ..   GDP_current_US_ = col_double(),
  ..   GDP_per_capita_Current_US_ = col_double(),
  ..   Inflation_consumer_prices_annual_ = col_double(),
  ..   Life_expectancy_at_birth_female_years_ = col_double(),
  ..   Life_expectancy_at_birth_male_years_ = col_double(),
  ..   Population_ages_0_14_female = col_double(),
  ..   Population_ages_0_14_of_total_ = col_double(),
  ..   Population_ages_15_64_female = col_double(),
  ..   Population_ages_15_64_male = col_double(),
  ..   Population_ages_15_64_of_total_ = col_double(),
  ..   Population_ages_15_64_total = col_double(),
  ..   Population_ages_65_and_above_female = col_double(),
  ..   Population_ages_65_and_above_of_total_ = col_double(),
  ..   Population_female = col_double(),
  ..   Population_female_of_total_ = col_double(),
  ..   Population_total = col_double(),
  ..   GDP_growth_annual_ = col_double()
  .. )
```


Let's learn more about the data: tidyverse way
========================================================
class: small-code

```r
glimpse(df)
```

```
Observations: 236
Variables: 37
$ year                                                         <dbl> 196…
$ Country_Name                                                 <chr> "De…
$ Country_Code                                                 <chr> "DN…
$ Adolescent_fertility_rate_births_per_1_000_women_ages_15_19_ <dbl> 44.…
$ Age_dependency_ratio_of_working_age_population_              <dbl> 55.…
$ Age_population_age_0_female_interpolated                     <dbl> 387…
$ Age_population_age_0_male_interpolated                       <dbl> 405…
$ Age_population_age_01_female_interpolated                    <dbl> 365…
$ Age_population_age_01_male_interpolated                      <dbl> 384…
$ Age_population_age_02_female_interpolated                    <dbl> 350…
$ Age_population_age_02_male_interpolated                      <dbl> 371…
$ Age_population_age_03_female_interpolated                    <dbl> 341…
$ Age_population_age_03_male_interpolated                      <dbl> 364…
$ Age_population_age_04_female_interpolated                    <dbl> 339…
$ Age_population_age_04_male_interpolated                      <dbl> 362…
$ Age_population_age_05_female_interpolated                    <dbl> 342…
$ Age_population_age_05_male_interpolated                      <dbl> 365…
$ Birth_rate_crude_per_1_000_people_                           <dbl> 16.…
$ Death_rate_crude_per_1_000_people_                           <dbl> 9.5…
$ Fertility_rate_total_births_per_woman_                       <dbl> 2.5…
$ GDP_current_US_                                              <dbl> 624…
$ GDP_per_capita_Current_US_                                   <dbl> 136…
$ Inflation_consumer_prices_annual_                            <dbl> 1.2…
$ Life_expectancy_at_birth_female_years_                       <dbl> 74.…
$ Life_expectancy_at_birth_male_years_                         <dbl> 70.…
$ Population_ages_0_14_female                                  <dbl> 561…
$ Population_ages_0_14_of_total_                               <dbl> 25.…
$ Population_ages_15_64_female                                 <dbl> 148…
$ Population_ages_15_64_male                                   <dbl> 145…
$ Population_ages_15_64_of_total_                              <dbl> 64.…
$ Population_ages_15_64_total                                  <dbl> 293…
$ Population_ages_65_and_above_female                          <dbl> 261…
$ Population_ages_65_and_above_of_total_                       <dbl> 10.…
$ Population_female                                            <dbl> 230…
$ Population_female_of_total_                                  <dbl> 50.…
$ Population_total                                             <dbl> 457…
$ GDP_growth_annual_                                           <dbl> NA,…
```


How to manipulate data: tidyverse way
========================================================
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/tidy_verbs.png" height=600>
</div>


Compare to the Base R way
========================================================

```r
df[ , c('year', 'Country_Code')]

df %>% select(year, Country_Code)
```

Why use pipes?
========================================================
Here are two pieces of code that return exactly the same thing. What do you think about their readability?



```r
# piped way
df %>%
  group_by(Country_Name) %>%
  summarise(Life_expectancy = max(Life_expectancy_at_birth_female_years_)) %>%
  arrange(Life_expectancy)
```


```r
# same functions, no pipes
arrange(summarise(group_by(df, Country_Name), Life_expectancy = max(Life_expectancy_at_birth_female_years_),Life_expectancy))
```

<div class = 'img-block' align="right">
<img src="https://pics.me.me/could-you-not-memeful-com-via-9gag-com-14187083.png" height=200px>
</div>


Let's get to it!
========================================================
class: small-code
### Step 0 - let's look at the data again
#### Our question: what is the maximum life expectancy for women across all years?


```r
df %>%
  glimpse()
```

```
Observations: 236
Variables: 37
$ year                                                         <dbl> 196…
$ Country_Name                                                 <chr> "De…
$ Country_Code                                                 <chr> "DN…
$ Adolescent_fertility_rate_births_per_1_000_women_ages_15_19_ <dbl> 44.…
$ Age_dependency_ratio_of_working_age_population_              <dbl> 55.…
$ Age_population_age_0_female_interpolated                     <dbl> 387…
$ Age_population_age_0_male_interpolated                       <dbl> 405…
$ Age_population_age_01_female_interpolated                    <dbl> 365…
$ Age_population_age_01_male_interpolated                      <dbl> 384…
$ Age_population_age_02_female_interpolated                    <dbl> 350…
$ Age_population_age_02_male_interpolated                      <dbl> 371…
$ Age_population_age_03_female_interpolated                    <dbl> 341…
$ Age_population_age_03_male_interpolated                      <dbl> 364…
$ Age_population_age_04_female_interpolated                    <dbl> 339…
$ Age_population_age_04_male_interpolated                      <dbl> 362…
$ Age_population_age_05_female_interpolated                    <dbl> 342…
$ Age_population_age_05_male_interpolated                      <dbl> 365…
$ Birth_rate_crude_per_1_000_people_                           <dbl> 16.…
$ Death_rate_crude_per_1_000_people_                           <dbl> 9.5…
$ Fertility_rate_total_births_per_woman_                       <dbl> 2.5…
$ GDP_current_US_                                              <dbl> 624…
$ GDP_per_capita_Current_US_                                   <dbl> 136…
$ Inflation_consumer_prices_annual_                            <dbl> 1.2…
$ Life_expectancy_at_birth_female_years_                       <dbl> 74.…
$ Life_expectancy_at_birth_male_years_                         <dbl> 70.…
$ Population_ages_0_14_female                                  <dbl> 561…
$ Population_ages_0_14_of_total_                               <dbl> 25.…
$ Population_ages_15_64_female                                 <dbl> 148…
$ Population_ages_15_64_male                                   <dbl> 145…
$ Population_ages_15_64_of_total_                              <dbl> 64.…
$ Population_ages_15_64_total                                  <dbl> 293…
$ Population_ages_65_and_above_female                          <dbl> 261…
$ Population_ages_65_and_above_of_total_                       <dbl> 10.…
$ Population_female                                            <dbl> 230…
$ Population_female_of_total_                                  <dbl> 50.…
$ Population_total                                             <dbl> 457…
$ GDP_growth_annual_                                           <dbl> NA,…
```

Exercise 1, step 1
========================================================


```r
df %>%
  group_by(Country_Name)
```

```
# A tibble: 236 x 37
# Groups:   Country_Name [4]
    year Country_Name Country_Code Adolescent_fert… Age_dependency_…
   <dbl> <chr>        <chr>                   <dbl>            <dbl>
 1  1960 Denmark      DNK                      44.2             55.8
 2  1961 Denmark      DNK                      45.0             55.6
 3  1962 Denmark      DNK                      45.9             55.2
 4  1963 Denmark      DNK                      45.5             54.8
 5  1964 Denmark      DNK                      45.1             54.5
 6  1965 Denmark      DNK                      44.7             54.3
 7  1966 Denmark      DNK                      44.4             54.4
 8  1967 Denmark      DNK                      44.0             54.6
 9  1968 Denmark      DNK                      40.7             54.8
10  1969 Denmark      DNK                      37.4             55.0
# … with 226 more rows, and 32 more variables:
#   Age_population_age_0_female_interpolated <dbl>,
#   Age_population_age_0_male_interpolated <dbl>,
#   Age_population_age_01_female_interpolated <dbl>,
#   Age_population_age_01_male_interpolated <dbl>,
#   Age_population_age_02_female_interpolated <dbl>,
#   Age_population_age_02_male_interpolated <dbl>,
#   Age_population_age_03_female_interpolated <dbl>,
#   Age_population_age_03_male_interpolated <dbl>,
#   Age_population_age_04_female_interpolated <dbl>,
#   Age_population_age_04_male_interpolated <dbl>,
#   Age_population_age_05_female_interpolated <dbl>,
#   Age_population_age_05_male_interpolated <dbl>,
#   Birth_rate_crude_per_1_000_people_ <dbl>,
#   Death_rate_crude_per_1_000_people_ <dbl>,
#   Fertility_rate_total_births_per_woman_ <dbl>, GDP_current_US_ <dbl>,
#   GDP_per_capita_Current_US_ <dbl>,
#   Inflation_consumer_prices_annual_ <dbl>,
#   Life_expectancy_at_birth_female_years_ <dbl>,
#   Life_expectancy_at_birth_male_years_ <dbl>,
#   Population_ages_0_14_female <dbl>,
#   Population_ages_0_14_of_total_ <dbl>,
#   Population_ages_15_64_female <dbl>, Population_ages_15_64_male <dbl>,
#   Population_ages_15_64_of_total_ <dbl>,
#   Population_ages_15_64_total <dbl>,
#   Population_ages_65_and_above_female <dbl>,
#   Population_ages_65_and_above_of_total_ <dbl>, Population_female <dbl>,
#   Population_female_of_total_ <dbl>, Population_total <dbl>,
#   GDP_growth_annual_ <dbl>
```

Exercise 1, step 2
========================================================


```r
df %>%
  group_by(Country_Name) %>%
  summarise(Life_expectancy = max(Life_expectancy_at_birth_female_years_, na.rm = TRUE))
```

```
# A tibble: 4 x 2
  Country_Name Life_expectancy
  <chr>                  <dbl>
1 Denmark                 82.9
2 Finland                 84.4
3 Norway                  84.2
4 Sweden                  84.2
```


Exercise 1, step 3 + assignment
========================================================

```r
df_example_1 <- df %>%
  group_by(Country_Name) %>%
  summarise(Life_expectancy = max(Life_expectancy_at_birth_female_years_, na.rm = TRUE)) %>%
  arrange(desc(Life_expectancy))
```


Exercise 2, step 0
========================================================
class: small-code
### Let's look at the data
#### Our new question is: what is the average female population over time?

```r
df %>%
  head()
```

```
# A tibble: 6 x 37
   year Country_Name Country_Code Adolescent_fert… Age_dependency_…
  <dbl> <chr>        <chr>                   <dbl>            <dbl>
1  1960 Denmark      DNK                      44.2             55.8
2  1961 Denmark      DNK                      45.0             55.6
3  1962 Denmark      DNK                      45.9             55.2
4  1963 Denmark      DNK                      45.5             54.8
5  1964 Denmark      DNK                      45.1             54.5
6  1965 Denmark      DNK                      44.7             54.3
# … with 32 more variables:
#   Age_population_age_0_female_interpolated <dbl>,
#   Age_population_age_0_male_interpolated <dbl>,
#   Age_population_age_01_female_interpolated <dbl>,
#   Age_population_age_01_male_interpolated <dbl>,
#   Age_population_age_02_female_interpolated <dbl>,
#   Age_population_age_02_male_interpolated <dbl>,
#   Age_population_age_03_female_interpolated <dbl>,
#   Age_population_age_03_male_interpolated <dbl>,
#   Age_population_age_04_female_interpolated <dbl>,
#   Age_population_age_04_male_interpolated <dbl>,
#   Age_population_age_05_female_interpolated <dbl>,
#   Age_population_age_05_male_interpolated <dbl>,
#   Birth_rate_crude_per_1_000_people_ <dbl>,
#   Death_rate_crude_per_1_000_people_ <dbl>,
#   Fertility_rate_total_births_per_woman_ <dbl>, GDP_current_US_ <dbl>,
#   GDP_per_capita_Current_US_ <dbl>,
#   Inflation_consumer_prices_annual_ <dbl>,
#   Life_expectancy_at_birth_female_years_ <dbl>,
#   Life_expectancy_at_birth_male_years_ <dbl>,
#   Population_ages_0_14_female <dbl>,
#   Population_ages_0_14_of_total_ <dbl>,
#   Population_ages_15_64_female <dbl>, Population_ages_15_64_male <dbl>,
#   Population_ages_15_64_of_total_ <dbl>,
#   Population_ages_15_64_total <dbl>,
#   Population_ages_65_and_above_female <dbl>,
#   Population_ages_65_and_above_of_total_ <dbl>, Population_female <dbl>,
#   Population_female_of_total_ <dbl>, Population_total <dbl>,
#   GDP_growth_annual_ <dbl>
```

Exercise 2, step 1
========================================================


```r
df %>%
  group_by(year)
```

```
# A tibble: 236 x 37
# Groups:   year [59]
    year Country_Name Country_Code Adolescent_fert… Age_dependency_…
   <dbl> <chr>        <chr>                   <dbl>            <dbl>
 1  1960 Denmark      DNK                      44.2             55.8
 2  1961 Denmark      DNK                      45.0             55.6
 3  1962 Denmark      DNK                      45.9             55.2
 4  1963 Denmark      DNK                      45.5             54.8
 5  1964 Denmark      DNK                      45.1             54.5
 6  1965 Denmark      DNK                      44.7             54.3
 7  1966 Denmark      DNK                      44.4             54.4
 8  1967 Denmark      DNK                      44.0             54.6
 9  1968 Denmark      DNK                      40.7             54.8
10  1969 Denmark      DNK                      37.4             55.0
# … with 226 more rows, and 32 more variables:
#   Age_population_age_0_female_interpolated <dbl>,
#   Age_population_age_0_male_interpolated <dbl>,
#   Age_population_age_01_female_interpolated <dbl>,
#   Age_population_age_01_male_interpolated <dbl>,
#   Age_population_age_02_female_interpolated <dbl>,
#   Age_population_age_02_male_interpolated <dbl>,
#   Age_population_age_03_female_interpolated <dbl>,
#   Age_population_age_03_male_interpolated <dbl>,
#   Age_population_age_04_female_interpolated <dbl>,
#   Age_population_age_04_male_interpolated <dbl>,
#   Age_population_age_05_female_interpolated <dbl>,
#   Age_population_age_05_male_interpolated <dbl>,
#   Birth_rate_crude_per_1_000_people_ <dbl>,
#   Death_rate_crude_per_1_000_people_ <dbl>,
#   Fertility_rate_total_births_per_woman_ <dbl>, GDP_current_US_ <dbl>,
#   GDP_per_capita_Current_US_ <dbl>,
#   Inflation_consumer_prices_annual_ <dbl>,
#   Life_expectancy_at_birth_female_years_ <dbl>,
#   Life_expectancy_at_birth_male_years_ <dbl>,
#   Population_ages_0_14_female <dbl>,
#   Population_ages_0_14_of_total_ <dbl>,
#   Population_ages_15_64_female <dbl>, Population_ages_15_64_male <dbl>,
#   Population_ages_15_64_of_total_ <dbl>,
#   Population_ages_15_64_total <dbl>,
#   Population_ages_65_and_above_female <dbl>,
#   Population_ages_65_and_above_of_total_ <dbl>, Population_female <dbl>,
#   Population_female_of_total_ <dbl>, Population_total <dbl>,
#   GDP_growth_annual_ <dbl>
```

Exercise 2, step 2
========================================================


```r
df %>%
  group_by(year) %>%
  summarise(avg_population_female = mean(Population_female_of_total_))
```

```
# A tibble: 59 x 2
    year avg_population_female
   <dbl>                 <dbl>
 1  1960                  50.6
 2  1961                  50.6
 3  1962                  50.6
 4  1963                  50.6
 5  1964                  50.6
 6  1965                  50.6
 7  1966                  50.6
 8  1967                  50.6
 9  1968                  50.6
10  1969                  50.6
# … with 49 more rows
```

Exercise 2, step 3 + assignment
========================================================


```r
df_example_2 <- df %>%
  group_by(year) %>%
  summarise(avg_population_female = mean(Population_female_of_total_)) %>%
  arrange(desc(year))
```



A bit more theory: tidy data concept
========================================================

<div class = 'img-block' align="center">
<img src="https://cdn-images-1.medium.com/max/1600/1*_64CzT-YicPKgCEJsOi6_A.png" >

<img src="https://d33wubrfki0l68.cloudfront.net/8350f0dda414629b9d6c354f87acf5c5f722be43/bcb84/images/tidy-8.png" >
</div>



spread() & gather()
========================================================
class: small-code
### tidyverse (tidyr) way


```r
phones_data_wide %>%
  head(3)
```

```
  N.Amer Europe Asia S.Amer Oceania Africa Mid.Amer year
1  45939  21574 2876   1815    1646     89      555 1951
2  60423  29990 4708   2568    2366   1411      733 1956
3  64721  32510 5230   2695    2526   1546      773 1957
```

```r
phones_data_wide %>% gather(country, number, -year) %>% head(5)
```

```
  year country number
1 1951  N.Amer  45939
2 1956  N.Amer  60423
3 1957  N.Amer  64721
4 1958  N.Amer  68484
5 1959  N.Amer  71799
```

```r
phones_data_long %>% spread(country, number) %>% head(3)
```

```
  year Africa Asia Europe Mid.Amer N.Amer Oceania S.Amer
1 1951     89 2876  21574      555  45939    1646   1815
2 1956   1411 4708  29990      733  60423    2366   2568
3 1957   1546 5230  32510      773  64721    2526   2695
```


A bit more explanation
========================================================
### gather()
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/gather.png" >
</div>
### spread()
<div class = 'img-block' align="center">
<img src="./pics_for_presentation/spread.png" >
</div>




