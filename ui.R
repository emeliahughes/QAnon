source("server.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("QAnon Instagram Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            choose_post <-  numericInput("num", label = h3("Choose Row Number"),
                                         value = 1),
            h3("Date Posted: "),
            textOutput("date"),
            h3("Username: "),
            textOutput("username"),
            h3("Likes: "),
            textOutput("likes"),
            h3("Comments: "),
            textOutput("comments"),
            h3("Total interactions: "),
            textOutput("interactions"),
            h3("Instagram URL: "),
            textOutput("url"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            uiOutput("image"),
            h3("Description: "),
            textOutput("description")
        )
    )
))
