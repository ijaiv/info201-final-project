#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
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
         tabPanel("Absences vs. Grades", plotOutput("plot1"), plotOutput("plot2"), plotOutput("plot3")),
         tabPanel("Academic Failure Plot", plotOutput("plot4")),
         tabPanel("Student Health", plotOutput("plot5"))
       )
    )
  
  )
)
