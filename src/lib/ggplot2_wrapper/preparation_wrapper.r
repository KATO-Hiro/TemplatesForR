# Load packages.
require(tidyr)

to_format_for_ggplot2 <- function(
  data_frame,
  use_columns,
  category_label,
  value_label
) {
  values_df <- data_frame %>%
    pivot_longer(
      cols = starts_with(use_columns),
      names_to = category_label,
      values_to = value_label
    ) %>%
      print()

  return(values_df)
}
