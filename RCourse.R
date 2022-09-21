############  GGPLOT2 #########################################################

install.packages("tidyverse")
install.packages("ggplot2")

#"Grammar of graphics":
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>, 
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>





### Exercise 1: Create multiple plots using facets

tidyr::pivot_longer(iris, -Species) %>% #Pipes everything through the pivot function. pivots the dataset but keeps the species column
  ggplot() + 
  geom_density(aes(value, 
                 fill = Species), alpha = 0.6,) + #density plot by species with slightly transparent colours
  facet_wrap(~name, nrow = 2, scales = "free") + #creates a plot for each group in the variable "name" with an individual scale for each plot 
  theme_set(theme_bw(18)) + #removes the grey background
  theme(aspect.ratio = 0.8) #changes the aspect ratio



## Interactive plots

ggplot(iris, aes(Petal.Length, Petal.Width, 
                 color = Species, shape = Species)) + 
  geom_point(size = 3)
plotly::ggplotly(width = 700, height = 450)



plotly::ggplotly(
  last_plot() + aes(text = bigstatsr::asPlotlyText(iris)),
  tooltip = "text", width = 700, height = 420)


### Exercise 2: Gapminder plot

(df <- dplyr::filter(gapminder::gapminder, year == 1992))

ggplot(df, aes(gdpPercap, lifeExp)) +
  geom_point(aes(size = pop, color = continent)) +
  scale_x_log10() +
  labs(title = "Gapminder for 1992", color = "Continent", size = "Population",
       x ="Gross Domestic Product (log scale)",
       y = "Life expectancy at birth (years)")

plotly::ggplotly(width = 700, height = 450)
  
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))


#Package to make plot animations:
install.packages("gganimate")
library(gganimate)

#Add this at the end of a plot to make colours colourblind friendly:
scale_colour_viridis_c() #"c" is for continuous alwasy use direction = -1 to havre the largest value the darkest colour.



## flights dataset
library(nycflights13)
library(tidyverse)

######  filter() Exercise: #####################################################
Arrival_delay <- filter(flights, arr_delay >= 120)
Houston <- filter(flights, dest %in% c("IAH", "HOU"))
Airline <- filter(flights, carrier %in% c("UA", "AA", "DL"))
Summer <- filter(flights, month %in% c(7:9))
Arrival_delay_2 <- filter(flights, arr_delay >= 120 & dep_delay <= 0)
Arrival_delay_3 <- filter(flights, dep_delay >= 60 & arr_delay <= 30)
DepartTime <- filter(flights, dep_time = )

######  arrange() Exercise: ####################################################
print(arrange(flights, desc(distance/air_time)), width = Inf)

######  select() Exercise: #####################################################
select(flights, starts_with("dep"), starts_with("arr"))
select(flights, dep_time, dep_delay, arr_time, arr_delay)


vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, any_of(vars))

select(flights, contains("TIME"))

######  mutate() Exercise: #####################################################
mutate(flights,
       hour = dep_time %/% 100, 
       minute = dep_time %% 100,
       dep_time = hour * 60 + minute)

select(mutate(flights,
             arrdep = arr_time - dep_time), arr_time, dep_time, arrdep)


######  group_by() Exercise: ###################################################

not_cancelled %>% count(dest)
n_distinct(x)

flights %>% 
  group_by(year, month, day) %>% 
  summarise(cancelled = sum(is.na(dep_delay)), 
            n = n()) %>% 
  arrange(desc(cancelled))  

flights %>%
  group_by(year, month, day) %>%
  summarize(prop_canceled = mean(is.na(dep_delay)),
            avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(prop_canceled, avg_delay)) +
  geom_point() +
  theme_bw(13) +
  geom_smooth()



airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

## when using left_join(), you can use suffix() to change the end of the name of the variables added to the df.
flights %>% 
  left_join(airports, c("origin" = "faa"))




