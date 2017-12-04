library('dplyr')
library('ggplot2')

## Creates a function that takes in a column from the student alcohol
## consumption dataset (must be a binomial column) that creates
## a graph that shows how number of failures affects the given
## column
failures.graph <- function(yaxis) {
  ## Read and store data
  alcohol.data <- read.csv('Data/student-mat.csv')
  
  ## Create plot
  ggplot(alcohol.data, aes(failures)) +   
    geom_bar(aes_string(fill = yaxis), position = "dodge")

}



