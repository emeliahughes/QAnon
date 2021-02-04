
library(shiny)
library(tidyverse)
library(dplyr)

# read in original data
saveourchildren <- read.csv("CT - saveourchildren.csv")
childlivesmatter <- read.csv("CT - childlivesmatter.csv")
savethechildren <- read.csv("CT - savethechildren.csv")
endchildtrafficking <- read.csv("CT - endchildtrafficking.csv")

# add tags to each data frame as identifiers of original data frame
saveourchildren <- saveourchildren %>% 
    mutate(tag = "SOC")

childlivesmatter <- childlivesmatter %>% 
    mutate(tag = "CLM")

savethechildren <- savethechildren %>% 
    mutate(tag = "STC")

endchildtrafficking <- endchildtrafficking %>% 
    mutate(tag = "ECT")

# combine the four data frames into one
fulldata <- rbind(savethechildren, saveourchildren, childlivesmatter, 
                  endchildtrafficking)

# select which columns are necessary (check google doc for more details)
data <- fulldata %>% 
    select(tag, User.Name, Created, Followers.at.Posting, Likes, Comments,
           Total.Interactions, Description, Image.Text, URL, Photo) 

# remove the duplicated posts across tags
# note: only one of the tags is kept, I haven't figured out how to note both 
# tags on duplicated posts yet
data <- distinct(data, URL, .keep_all = TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$username <- renderText({ data[input$num,]$User.Name })
    
    output$image <- renderUI({ tags$img(src = data[input$num,]$Photo, 
                                        height = "50%", width = "50%") })
    
    output$likes <- renderText ({ data[input$num,]$Likes })
    
    output$comments <- renderText ({ data[input$num,]$Comments })
    
    output$interactions <- renderText ({ data[input$num,]$Total.Interactions })
    
    output$description <- renderText ({ data[input$num,]$Description })
    
    output$tag <- renderText ({ data[input$num,]$tag })
    
    output$date <- renderText ({ data[input$num,]$Created })
    
    output$url <- renderText ({ data[input$num,]$URL })

})
