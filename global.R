# load packages
library(shiny)
# library(shiny.semantic)
library(semantic.dashboard)
library(dplyr)
library(rlang)
library(scales)
library(leaflet)
library(testthat)
import::from(shiny.semantic, grid, grid_template,semanticPage)

# load separate module and function scripts
source("function_grid.R")
source("module_selection.R")
source("module_speed.R")
source("function_safe_subset.R")
source("function_distance_speed.R")
source("function_travel_number.R")
