# Emelia Hughes
# QAnon DRG Data

# load libraries
library(shiny)
library(tidyverse)
library(dplyr)

# Read in source files
source("ui.R")
source("server.R")

# Run the application
shinyApp(ui = ui, server = server)