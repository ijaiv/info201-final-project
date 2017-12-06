#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(ggplot2)
library(dplyr)
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
  
  n <- reactive({
    if(input$Plots == 'Absences vs. G1')
      period <<- data %>% select(G1)
    else if(input$Plots == 'Absences vs. G2')
      period <<- data %>% select(G2)
    else if(input$Plots == 'Absences vs. G3')
      period <<- data %>% select(G3)
  })
  
  output$plot1 <- renderPlot({
    data <- read.csv(file = 'Data/student-mat.csv', stringsAsFactors = FALSE)
    n.graph <- n()
    t <- ggplot(n.graph, aes(period, data$absences)) + geom_point(aes(col=data$sex)) + ggtitle(input$Plots)
    print(t)
  })

  
  output$Summary <- renderUI({
    HTML(paste("One of the most important factors in determining student performance has to do with the number of
               absences recorded. This is helpful as it informs educators on the student's participation.
               Theoretically, actie participation should lead to a higher grade. Those who are not engaged in
               class would not do as well on tests; there are exceptions to this rule even then.
               The data has two columns types that would help us test this hypothesis: One charts student absences
               from 0 to 93 while the other type is split into three different columns. The second type has to do with
               recorded Math and Portuguese grades split into three periods (G1, G2, and G3).", sep = "<br/>",
               "Here, the data visualization shows that those with fewer absences generally had higher grades.
               However, it is difficult to make an inference based on sex."))
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
  
  output$Description1 <- renderUI({
    HTML(paste("This graph depicts how the amount of classes failed by students who consume alcohol
               is affected by certain traits:", sep = "<br/>",
               "1. If they paid for classes",
               "2. If they had major school support",
               "3. If they had major family support",
               "4, If they were in a relationship"
               
               
    ))
  })
  
  output$Description2 <- renderUI({
    HTML(paste("This graph depicts the health of students who consume alcohol on a range of 1 to 5,
               with 1 being very poor health, and 5 being no health issues. The amount of classes 
               failed is then measured based on each health category, showing how the health of students
               affects their performance. The radio buttons filter the data, showing information for students
               who drink a certain amount of alcohol per week.
               "
    ))
  })
  
  output$Table <- renderDataTable({data})
  
  output$Description3 <- renderUI({ 
    HTML(paste("This tab shows the raw data used for our analysis on student alcohol consumption rate. We were able to 
                retrieve the dataset from https://www.kaggle.com/datasets. </br>
                </br>
                The attributes for the dataset is as follows:</br>
                1. school - student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)</br>
                2. sex - student's sex (binary: 'F' - female or 'M' - male)</br>
               3. age - student's age (numeric: from 15 to 22)</br>
              4.address - student's home address type (binary: 'U' - urban or 'R' - rural)</br>
               5. famsize - family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)</br>
               6. Pstatus - parent's cohabitation status (binary: 'T' - living together or 'A' - apart)</br>
               7. Medu - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 3 – secondary education or 4 – higher education)</br>
              8. Fedu - father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 3 – secondary education or 4 – higher education)</br>
               9. Mjob - mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')</br>
               10. Fjob - father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')</br>
               11. reason - reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')</br>
               12. guardian - student's guardian (nominal: 'mother', 'father' or 'other')</br>
               13. traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)</br>
               14. studytime - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)</br>
               15. failures - number of past class failures (numeric: n if 1<=n<3, else 4)</br>
               16. schoolsup - extra educational support (binary: yes or no)</br>
               17. famsup - family educational support (binary: yes or no)</br>
               18. paid - extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)</br>
               19. activities - extra-curricular activities (binary: yes or no)</br>
               20. nursery - attended nursery school (binary: yes or no)</br>
               21. higher - wants to take higher education (binary: yes or no)</br>
               22. internet - Internet access at home (binary: yes or no)</br>
               23. romantic - with a romantic relationship (binary: yes or no)</br>
               24. famrel - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)</br>
               25. freetime - free time after school (numeric: from 1 - very low to 5 - very high)</br>
               26. goout - going out with friends (numeric: from 1 - very low to 5 - very high)</br>
               27. Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)</br>
               28. Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)</br>
               29. health - current health status (numeric: from 1 - very bad to 5 - very good)</br>
               30. absences - number of school absences (numeric: from 0 to 93)</br>
               These grades are related with the course subject, Math or Portuguese:</br>
               </br>
               G1 - first period grade (numeric: from 0 to 20)</br>
               G2 - second period grade (numeric: from 0 to 20)</br>
               G3 - final grade (numeric: from 0 to 20, output target)</br>
               "))
    })
})
