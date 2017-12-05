#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme('cyborg'),
  
  tags$head(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    
                    h1 {
                    font-family: 'Apple chancery';
                    font-weight: 600;
                    line-height: 1.1;
                    color: #4d3a7d;
                    }
                    "))
    ),  
  
  # Application title
  headerPanel("Data Analysis: Student Alcohol Consumption"),

    mainPanel(
       tabsetPanel(
         tabPanel("Home", htmlOutput("Overview")),
         tabPanel("Absences vs. Grades", htmlOutput("Summary"), plotOutput("plot1"),
                  selectInput("Plots", label = "Choose a Plot", 
                                                     choices = list('Absences vs. G1', 'Absences vs. G2', 'Absences vs. G3'))
                  ),
         tabPanel("Academic Failure Plot", 
                  htmlOutput("Description1"),
                  plotOutput("plot4"),
                  radioButtons('option1',
                               "Plot By:",
                               c("Paid For Classes" = "paid",
                                 "Had School Support" = "schoolsup",
                                 "Had Family Support" = "famsup",
                                 "In A Relationship" = "romantic")
                               
                  )
                  ),
         tabPanel("Student Health", htmlOutput("Description2"), plotOutput("plot5"),
                  radioButtons('option2',
                                                 "Plot By:",
                                                 c("5 Drinks/Week" = "5",
                                                   "4 Drinks/Week" = "4",
                                                   "3 Drinks/Week" = "3",
                                                   "2 Drinks/Week" = "2",
                                                   "1 Drink/Week" = "1"
                                                 )
         )
                  )
       )
    )
  
  )
)
