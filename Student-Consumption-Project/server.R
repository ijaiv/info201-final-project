#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(dplyr)
library(ggplot2)
library(gridExtra)
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
    x <- ggplot(data, aes(G1, absences)) + geom_point(aes(col=sex)) + ggtitle("Absences vs. First Period Grade")
    print(x)
  })
  
  output$plot2 <- renderPlot({
    y <- ggplot(data, aes(G2, absences)) + geom_point(aes(col=sex)) + ggtitle("Absences vs. Second Period Grade")
    print(y)
  })
  
  output$plot3 <- renderPlot({
    z <- ggplot(data, aes(G3, absences)) + geom_point(aes(col=sex)) + ggtitle("Absences vs. Third Period Grade")
    print(z)
  })
  
  #How do academic failures be attributed to the amount of paid classes? 
  #Academic failures are presented as a numeric number while paid classes are a binary (yes or no) question.
  output$plot4 <- renderPlot({
    a <-   ggplot(data, aes(failures)) +   
      geom_bar(aes_string(fill = input$option1), position = "dodge") + ggtitle("Failures vs. Paid Classes")
    print(a)
  })
  
  #How does the health of a students affected by alcohol relate to their success.
  output$plot5 <- renderPlot({
    ## Filter data to only the amount of drinks per week given to the
    ## function
    alcohol.data <- data %>% filter(Walc == input$option2)
    
    ## Allow failures column to be read by ggplot and used for fill colors
    alcohol.data$failures <- as.character(alcohol.data$failures)
    
    ## Create the graph
    ggplot(data = alcohol.data) +
      geom_bar(mapping = aes(x = health, fill = failures), position = "dodge",
               width = .8) + ggtitle("Health vs. Success")
  
  
  })
  
  output$Description2 <- renderUI({
    HTML(paste("This graph depicts how the amount of classes failed by students who consume alcohol
               is affected by certain traits:
               1. If they paid for classes
               2. If they had major school support
               3. If they had major family support
               4, If they were in a relationship
               
               "
    ))
  })
  
  output$Description1 <- renderUI({
    HTML(paste("This graph depicts the health of students who consume alcohol on a range of 1 to 5,
               with 1 being very poor health, and 5 being no health issues. The amount of classes 
               failed is then measured based on each health category, showing how the health of students
               affects their performance. The radio buttons filter the data, showing information for students
               who drink a certain amount of alcohol per week.
               "
    ))
  })
  
})
