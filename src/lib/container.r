if (!require(R6)) install.packages("R6")

require(R6)

source("./src/lib/figure.r")
source("./src/lib/generic_functions.r")

container <- R6Class("container",
  private = list(
    values = NA,
    count = 0
  ),

  public = list(
    # See:
    # https://heavywatal.github.io/rstats/programming.html
    initialize = function(...) {
      private$values <- c()
    },

    add = function(value, direction = "row") {
      if (direction == "row") {
        private$values <- rbind(private$values, value)
      } else {
        private$values <- cbind(private$values, value)
      }

      private$count  <- private$count + 1
    },

    get_values = function() {
      return(private$values)
    },

    add_column_labels = function(labels) {
      colnames(private$values) <- labels
    },

    add_row_labels = function(labels) {
      rownames(private$values) <- labels
    },

    count_values = function() {
      return(private$count)
    },

    # See:
    # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/factor
    # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sort
    # https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select
    # https://cran.r-project.org/web/packages/tidyselect/tidyselect.pdf
    # https://trunk28.com/column_sort/
    sort_by_columns = function(column_labels) {
      sorted_labels <- names(private$values) %>%
        factor(
          levels = column_labels
        ) %>%
        sort()

      private$values <- private$values %>%
        dplyr::select(
          all_of(
            sorted_labels
          )
        )
    },

    write_csv_file = function(
      file_path, row_names = FALSE, file_encoding = "utf-8"
    ) {
      write.csv(
        self$get_values(),
        file = file_path,
        row.names = row_names,
        fileEncoding = file_encoding
      )
    }
  )
)
