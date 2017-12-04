library('dplyr')
library('ggplot2')

## Creates a function that takes in the number of drinks taken
## per week, and creates a graph with that data that shows the
## health of students who drink that much on a scale of 1-5
## along with the number of failed classes for each health stage
health.success <- function(weekly.intake) {
  ## Read and store data
  alcohol.data <- read.csv('Data/student-mat.csv')
  
  ## Filter data to only the amount of drinks per week given to the
  ## function
  alcohol.data <- alcohol.data %>% filter(Walc == weekly.intake)
  
  ## Allow failures column to be read by ggplot and used for fill colors
  alcohol.data$failures <- as.character(alcohol.data$failures)
  
  ## Create the graph
  ggplot(data = alcohol.data) +
    geom_bar(mapping = aes(x = health, fill = failures), position = "dodge",
             width = .8)
  
  
}

