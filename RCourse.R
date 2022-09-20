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
scale_colour_viridis_c() #"c" is for continuous

