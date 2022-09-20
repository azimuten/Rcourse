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






#Exercise 1



tidyr::pivot_longer(iris, -Species) %>% #Pipes everything through the pivot function. pivots the dataset but keeps the species column
  ggplot() + 
  geom_density(aes(value, 
                 fill = Species), alpha = 0.6,) + #density plot by species with slightly transparent colours
  facet_wrap(~name, nrow = 2, scales = "free") + #creates a plot for each group in the variable "name" with an individual scale for each plot 
  theme_set(theme_bw(18)) + #removes the grey background
  theme(aspect.ratio = 0.8) #changes the aspect ratio


