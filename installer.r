# Note: Run the script before run main.r
main <- function() {
  update.packages(
    ask = FALSE
  )

  # Default packages.
  install.packages("data.table")
  install.packages("dplyr")
  install.packages("ggnewscale")
  install.packages("ggplot2")
  install.packages("gridExtra")
  install.packages("languageserver")
  install.packages('logger')
  install.packages("pipeR")
  install.packages("R6")
  install.packages("testthat")
  install.packages("tidyr")
  install.packages("tidyverse")

  # Additional package(s)
}

main()
