require(dplyr)
require(R6)

# See:
# https://dplyr.tidyverse.org/reference/filter.html
extract_rows_from_df <- function(data_frame, condition) {
  selected_rows <- data_frame %>%
    dplyr::filter(
      condition
    ) %>%
      as.data.frame()

  return(selected_rows)
}

# See:
# https://tidyselect.r-lib.org/reference/faq-external-vector.html
extract_columns_from_df <- function(data_frame, columns) {
  selected_columns <- data_frame %>%
    dplyr::select(
      all_of(
        columns
      )
    ) %>%
      as.data.frame()

  return(selected_columns)
}

# See:
# https://dplyr.tidyverse.org/reference/arrange.html
sort_rows_of_data_frame <- function(data_frame, columns) {
  sorted_df <- data_frame %>%
    arrange(columns) %>%
      as.data.frame()

  return(sorted_df)
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/factor
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sort
# https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select
# https://cran.r-project.org/web/packages/tidyselect/tidyselect.pdf
# https://trunk28.com/column_sort/
get_sorted_data_frame_by_columns <- function(data_frame, column_labels) {
  sorted_labels <- names(data_frame) %>%
    factor(
      levels = column_labels
    ) %>%
    sort()

  sorted_df <- data_frame %>%
    dplyr::select(
      all_of(
        sorted_labels
      )
    )

  return(sorted_df)
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/cumsum
# https://bioinfo-dojo.net/2017/08/09/r-cumsum/
# https://dplyr.tidyverse.org/reference/rename.html
calc_cumulative_sums <- function(data_frame, column, new_column_name) {
  data_frame <- within(data_frame, temp <- cumsum(column))
  data_frame <- data_frame %>%
    dplyr::rename("{new_column_name}" := temp)

  return(data_frame)
}

dplyr_operator_wrapper <-
  R6Class("dplyr_operator_wrapper",

    private = list(
      values = NULL,
      columns_for_grouping = NULL,
      calculated_values_label = NULL
    ),

    public = list(
      initialize = function(...) {
        private$values                  <- list(...)$values
        private$columns_for_grouping    <- list(...)$columns_for_grouping
        private$calculated_values_label <- list(...)$calculated_values_label
      },

      # See:
      # https://rlang.r-lib.org/reference/abort.html
      execute = function() {
        rlang::abort("This is an abstract method. Create a subclass and implement concrete processing there.")
      }
    )
  )

# operator_sum <- operator_sum_wrapper$new(
#   values = data_frame, # It is assumed that there are at least columns a, b, c and d.
#   columns_for_grouping = c("a", "b", "c"),
#   column_for_aggregation = c("d"),
#   calculated_values_label = "bar"
# )
# results <- operator_sum$execute()
operator_sum_wrapper <-
  R6Class("operator_sum_wrapper",
    inherit = dplyr_operator_wrapper,

    private = list(
      column_for_aggregation = NULL
    ),

    public = list(
      initialize = function(...) {
        super$initialize(...)
        private$column_for_aggregation <- list(...)$column_for_aggregation
      },

      # See:
      # https://dplyr.tidyverse.org/reference/summarise.html
      # https://adv-r.hadley.nz/quasiquotation.html#unquoting
      execute = function() {
        results <- private$values %>%
          group_by(across(.cols = all_of(private$columns_for_grouping))) %>%
            summarise(!!private$calculated_values_label :=
              sum(across(.cols = all_of(private$column_for_aggregation)))
            ) %>%
              as.data.frame

        return(results)
      }
    )
  )

# Usage:
# operator_sums <- operator_sums_wrapper$new(
#   values = data_frame, # It is assumed that there are at least columns a, b, c, d and e.
#   columns_for_grouping = c("a", "b", "c"),
#   columns_for_aggregation = c("d", "e")
# )
# results <- operator_sums$execute()
operator_sums_wrapper <-
  R6Class("operator_sums_wrapper",
    inherit = dplyr_operator_wrapper,

    private = list(
      columns_for_aggregation = NULL
    ),

    public = list(
      initialize = function(...) {
        super$initialize(...)
        private$columns_for_aggregation <- list(...)$columns_for_aggregation
      },

      # See:
      # https://dplyr.tidyverse.org/reference/summarise.html
      # https://dplyr.tidyverse.org/reference/across.html
      # https://adv-r.hadley.nz/quasiquotation.html#unquoting
      execute = function() {
        results <- private$values %>%
          group_by(across(.cols = all_of(private$columns_for_grouping))) %>%
            summarise(
              across(
                .cols = all_of(private$columns_for_aggregation),
                .fns = sum,
                .names = "{private$calculated_values_label}"
              )
            ) %>%
              as.data.frame

        return(results)
      }
    )
  )

# HACK: Refactoring. The wrapper is almost same operator_sums_wrapper.
# Usage:
# operator_cumulative_sums <- operator_cumulative_sums_wrapper$new(
#   values = data_frame, # It is assumed that there are at least columns a, b, c, d and e.
#   columns_for_grouping = c("a", "b", "c"),
#   columns_for_aggregation = c("d", "e"),
#   calculated_values_label = c("bar", "foo")
# )
# results <- operator_cumulative_sums$execute()
operator_cumulative_sums_wrapper <-
  R6Class("operator_cumulative_sums_wrapper",
    inherit = dplyr_operator_wrapper,

    private = list(
      columns_for_aggregation = NULL
    ),

    public = list(
      initialize = function(...) {
        super$initialize(...)
        private$columns_for_aggregation <- list(...)$columns_for_aggregation
      },

      # See:
      # https://dplyr.tidyverse.org/reference/summarise.html
      # https://dplyr.tidyverse.org/reference/across.html
      # https://adv-r.hadley.nz/quasiquotation.html#unquoting
      # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/cumsum
      execute = function() {
        results <- private$values %>%
          group_by(across(.cols = all_of(private$columns_for_grouping))) %>%
            summarise(
              across(
                .cols = all_of(private$columns_for_aggregation),
                .fns = cumsum,
                .names = "{private$calculated_values_label}"
              )
            ) %>%
              as.data.frame

        return(results)
      }
    )
  )

# Usage:
# operator_division <- operator_division_wrapper$new(
#   values = data_frame, # It is assumed that there are at least columns a, b, c, hoge and foo.
#   columns_for_grouping = c("a", "b", "c"),
#   numerator = "hoge",
#   denominator = "foo",
#   calculated_values_label = "bar"
# )
# results <- operator_division$execute()
operator_division_wrapper <-
  R6Class("operator_division_wrapper",
    inherit = dplyr_operator_wrapper,

    private = list(
      numerator = NULL,
      denominator = NULL
    ),

    public = list(
      initialize = function(...) {
        super$initialize(...)
        private$numerator   <- list(...)$numerator
        private$denominator <- list(...)$denominator
      },

      # See:
      # https://dplyr.tidyverse.org/reference/summarise.html
      # https://adv-r.hadley.nz/quasiquotation.html#unquoting
      # https://trunk28.com/dplyr_for/#mutatetransmute
      # https://dplyr.tidyverse.org/reference/na_if.html
      execute = function() {
        private$values <- private$values %>%
          group_by(across(.cols = all_of(private$columns_for_grouping))) %>%
            summarise(
              !!private$numerator :=
                sum(across(.cols = all_of(private$numerator))),
              !!private$denominator :=
                sum(across(.cols = all_of(private$denominator)))
            ) %>%
            mutate("{private$calculated_values_label}" :=
              na_if(
                x = across(.cols = private$numerator) / across(.cols = private$denominator),
                y = Inf
              )
            ) %>%
              as.data.frame

        # HACK: The column name of the numerator remains even if a new column
        # name is specified, so the original column name must be specified.
        colnames(private$values[, private$calculated_values_label]) <-
          private$calculated_values_label

        return(private$values)
      }
    )
  )
