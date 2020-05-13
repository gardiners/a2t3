# Question 2 (a)

# Install packages if needed: 
packages <- c("tidyverse", "WDI", "maps", "countrycode")
# List of installed packages
installed <- installed.packages()[,1]
# Install the packages we need which aren't in the list of installed packages:
install.packages(packages[!packages %in% installed])

# Load packages:
library(tidyverse)
library(WDI)
library(countrycode)

# Find the right WDI dataset:
WDIsearch("(CO2).*(PC)", field = "indicator")

# Save the dataset and examine:
emissions <- WDI(indicator = "EN.ATM.CO2E.PC", start = 2014, end = 2014,
                 extra = TRUE)
glimpse(emissions)

# Load the map data and add an ISO3C country code column:
world <- map_data("world")
world_cc <- world %>%
  mutate(iso3c = countrycode(region, origin = "country.name", destination = "wb"))
glimpse(world_cc)

# Join the datasets:
world_emissions <- world_cc %>%
  left_join(emissions, by = "iso3c")

# Plot the choropleth:
ggplot(world_emissions, aes(long, lat, group = group, fill = EN.ATM.CO2E.PC)) +
  geom_polygon() +
  theme_void() +
  scale_fill_distiller(palette = "Reds", direction = 1,
                       name = expression(CO[2] ~ Emissions (tons ~ per ~ capita))) +
  theme(legend.position = "bottom",
        plot.caption = element_text(hjust = 0, colour = "slategrey")) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_quickmap() +
  labs(title = expression("Distribution of" ~ CO[2] ~ "emissions (2014)"),
       caption = "Sources: World Bank (2016); Natural Earth Project (2020)")
