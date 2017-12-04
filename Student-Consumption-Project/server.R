#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Introduce the project to the User/Viewer
  # State what the dataset it/ where it came from
  # State what will be researched (the three graphs)
  
  #What are the differences of workday alcohol consumption numbers between genders?
  output$Overview <- renderText({
    
  })
  
  #How do academic failures be attributed to the amount of paid classes? 
  #Academic failures are presented as a numeric number while paid classes are a binary (yes or no) question.
  output$plot1 <- renderPlot({
    
  })
  
  #How does the health of a students affected by alcohol relate to their success.
  output$plot2 <- renderPlot({
    
  })
  
  
  
})
