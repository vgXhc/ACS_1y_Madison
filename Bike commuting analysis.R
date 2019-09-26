library(tidycensus)
library(tidyverse)
library(purrr)

######################
######################
## Data prep        ## 
######################
######################

v17 <- load_variables(2017, "acs1/subject", cache = TRUE)
v18 <- load_variables(2018, "acs1", cache = TRUE)


#define variables for total number commuters and total bike commuters
vars <- c("B08006_001", "B08006_014")

year <- c(seq(2016, 2017, by=1))


places <- get_acs(geography = "place", table = "S0802", state = "WI", year = 2017)

us <- unique(fips_codes$state)[1:51]

# Process all tracts by state
df <- map_df(year, function(x) {
  get_acs(geography = "state", variables = "B08006_001", year = x) %>% mutate(year = x)
})

df2010 <- map_df(us, function(x) {
  get_acs(geography = "tract", variables = vars, state = x, year = 2010, output = "wide", cache_table = TRUE)
})

df_all <- inner_join(df, df2010, by = ("GEOID"))

bike_growth <- df_all %>%
  mutate(share_2010 = B08006_014E.y / B08006_001E.y, share_2017 = B08006_014E.x / B08006_001E.x, growth = share_2017 - share_2010) %>%
  filter(share_2010 > 0.03, B08006_001E.x > 500, str_detect(NAME.x, 'Dane')) %>%
  select(GEOID, NAME.x, B08006_001E.x, share_2010:growth) %>%
  arrange(desc(growth))

bike_growth <- df_all %>%
  mutate(share_2010 = B08006_014E.y / B08006_001E.y, share_2017 = B08006_014E.x / B08006_001E.x, growth = share_2017 - share_2010) %>%
  filter(share_2010 > 0.03, B08006_001E.x > 500) %>%
  select(GEOID, NAME.x, B08006_001E.x, share_2010:growth) %>%
  arrange(desc(growth))

#calculate bike mode share and sort descending
hi_bike <- df %>%
  filter(B08006_001E > 500) %>%
  mutate(bike_share = B08006_014E/B08006_001E) %>%
  filter(bike_share > 0.1) %>%
  arrange(desc(bike_share))

hi_bike <- df2010 %>%
  filter(B08006_001E > 500) %>%
  mutate(bike_share = B08006_014E/B08006_001E) %>%
  filter(bike_share > 0.1) %>%
  arrange(desc(bike_share))

view(hi_bike)

################
## Data prep 2 #
################

#section for refactoring all the transportation data

# define all transpo variables from B08006_001 to B08006_017 (i.e the ones not split by gender)

vars <- paste0("B08006_0", sprintf("%02.0f", 1:17))

#year variable for all ACS-1 years available through package
year <- c(2011:2018)

get_acs(geography = "place", state = 55, variables = vars, year = 2011, survey = "acs1")

#get Madison data for each year, join with variable names
madison <- map_df(year, function(x) {
  get_acs(geography = "place", state = "WI", variables = vars, year = x, survey = "acs1", cache_table = TRUE) %>%
    mutate(year = x) %>%
  filter(NAME == "Madison city, Wisconsin")}) %>%
  left_join(v18, by = c("variable" = "name")) %>%
  mutate(label = str_sub(label, start = 18))

#calculate percentages for each estimate; also create margin of error for those percentages
madison_perc <- madison %>%
  group_by(year) %>%
  mutate(perc_est = estimate / estimate[1],
         perc_moe = moe_prop(estimate, estimate[1], moe, moe[1]))

#define variables to be plotted
plotvars = paste0("B08006_0", c("02", "08", "14", "15", "16", "17"))

#biking plot
madison_perc %>% 
  filter(variable == "B08006_014") %>%
  ggplot(aes(x = year, y = perc_est, color = label)) + 
#  geom_line(stat = "identity") +
  geom_point() +
  geom_crossbar(aes(ymin = perc_est - perc_moe, ymax = perc_est + perc_moe)) +
  scale_y_continuous(labels = scales::percent, limits = c(0,0.08)) +
  ylab("") +
  ggtitle("One-year estimates for biking to work in Madison, 2012-2018")

#transit plot
madison_perc %>% 
  filter(variable == "B08006_008") %>%
  ggplot(aes(x = year, y = perc_est)) + 
  geom_point() +
  geom_crossbar(aes(ymin = perc_est - perc_moe, ymax = perc_est + perc_moe)) +
  scale_y_continuous(labels = scales::percent, limits = c(0,0.12)) +
  ylab("") +
  ggtitle("One-year estimates for public transit to work in Madison, 2012-2018")

#driving plot
madison_perc %>% 
  filter(variable == "B08006_002") %>%
  ggplot(aes(x = year, y = perc_est)) + 
  geom_point() +
  geom_crossbar(aes(ymin = perc_est - perc_moe, ymax = perc_est + perc_moe)) +
  scale_y_continuous(labels = scales::percent, limits = c(0,.75)) +
  ylab("") +
  ggtitle("One-year estimates for driving to work in Madison, 2012-2018")

v2018 <- madison %>% filter(year == 2018)

sum(v2018$estimate[2:17])

