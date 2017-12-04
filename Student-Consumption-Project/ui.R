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
  
  # Application title
  titlePanel("Data Analysis: Student Alcohol Consumption"),

    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(
         tabPanel("Home", verbatimTextOutput("Overview")),
         tabPanel("Workday Alcohol Consumption: Male vs. Female", plotOutput("plot1")),
         tabPanel("Academic Failure Plot", plotOutput("plot2")),
         tabPanel("Student Health", plotOutput("plot3"))
       )
    )
  )
)
