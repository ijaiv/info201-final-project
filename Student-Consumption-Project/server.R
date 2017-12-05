#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(ggplot2)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Introduce the project to the User/Viewer
  # State what the dataset it/ where it came from
  # State what will be researched (the three graphs)
  
  #Print out text for the Home tab
  output$Overview <- renderUI({
    HTML(paste("This is a data analysis an visualization of student alcohol consumption rates.
          The data was retrieved from kaggle, and is a collection of statistics from hundreds of people.",
          "This application will calculate three things:", sep = "<br/>",
          "1. How the students' grades in their three class periods were affected by number of absences reported. This will be compared among sexes.",
          "2. How academic failures can be compared to number of paid classes, wherein paid classes are binary
          yes or no question", 
          "3. How the students' health affected by alcohol impacted their success"
          ))
  })

  data <- read.csv(file = 'Data/student-mat.csv', stringsAsFactors = FALSE)
  
  output$plot1 <- renderPlot({
    ggplot(data, aes(G1, absences)) + geom_point(aes(col=sex)) + ggtitle("Absences vs. First Period Grade")
  })
  
  output$plot2 <- renderPlot({
    ggplot(data, aes(G2, absences)) + geom_point(aes(col=sex)) + ggtitle("Absences vs. Second Period Grade")
  })
  
  output$plot3 <- renderPlot({
    ggplot(data, aes(G3, absences)) + geom_point(aes(col=sex)) + ggtitle("Absences vs. Third Period Grade")
  })
  
  #How do academic failures be attributed to the amount of paid classes? 
  #Academic failures are presented as a numeric number while paid classes are a binary (yes or no) question.
  output$plot2 <- renderPlot({
    
  })
  
  #How does the health of a students affected by alcohol relate to their success.
  output$plot3 <- renderPlot({
    
  })
  
  
  
})
