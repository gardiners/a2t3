# Question 2 (b)

# Packages we need
packages <- c("tidyverse", "remotes", "tidygraph", "ggraph")
# List of installed packages
installed <- installed.packages()[,1]
# Install the packages we need which aren't in the list of installed packages:
install.packages(packages[!packages %in% installed])
# Install UserNetR:
remotes::install_github("https://github.com/DougLuke/UserNetR", ref = "67972b7")

# Load packages:
library(tidyverse)
library(tidygraph)
library(ggraph)

# Load the dataset and inspect:
data(Bali, package = "UserNetR")
class(Bali)

# Plot the graph:
Bali %>%
  as_tbl_graph() %>%
  ggraph() +
  geom_edge_link() +
  geom_node_label(aes(label = name)) +
  theme_graph() +
  scale_x_continuous(expand = c(0.1,0.1))
