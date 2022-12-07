# See:
# https://rdrr.io/github/tidyverse/tidyr/f/NEWS.md
# https://speakerdeck.com/yutannihilation/tidyr-pivot
# https://heavywatal.github.io/rstats/tidyr.html
# data: Original data.
# cols: Columns you want to summarize.
#   examples:
#     cols = col1
#     cols = c(col1, col2, col3)
#     cols = col1:col3 # range
#     cols = -col2 # excluding col(s)
#     cols = c("col1", "col2", "col3")
#     cols = starts_with("col") # use helper function
#     cols = c(col1, "col2", last_col()) # combinations
# names_to: a new column label after grouping column names.
# values_to: a new column label after grouping values.
to_long_format <- function(data_frame, cols, names_to, values_to) {
  long_format_data <- data_frame %>%
    tidyr::pivot_longer(
      cols = all_of(cols),
      names_to = names_to,
      values_to = values_to
    ) %>%
      as.data.frame

  return(long_format_data)
}
