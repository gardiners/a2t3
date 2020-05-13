# Question 2 (c)

# Packages we need
packages <- c("tidyverse", "remotes", "tidygraph", "ggraph")
# List of installed packages
installed <- installed.packages()[,1]
# Install the packages we need which aren't in the list of installed packages:
install.packages(packages[!packages %in% installed])
# Install UserNetR (repeating here in case the marker runs the scripts out of order:
remotes::install_github("https://github.com/DougLuke/UserNetR", ref = "67972b7")

# Load packages:
library(tidyverse)
library(tidygraph)
library(ggraph)

# Load the dataset and inspect:
data(Bali, package = "UserNetR")
class(Bali)


# Plot the graph with bomber role as the node label:
Bali %>%
  as_tbl_graph() %>%
  activate(nodes) %>%
  mutate(role = factor(role, levels = c("OA", "CT", "BM", "TL", "SB")),
         role_desc = factor(role, labels = c("Operational assistant", "Command team",
                                             "Bomb maker", "Team Lima",
                                             "Suicide bomber"))) %>%
  ggraph() +
  geom_edge_link() +
  geom_node_label(aes(label = role, fill = role_desc)) +
  theme_void() +
  guides(fill = guide_legend(override.aes = list(label = c("OA", "CT", "BM", "TL", "SB")),
                             title = "Role"))