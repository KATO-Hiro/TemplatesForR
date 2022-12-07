if (!require(R6)) install.packages("R6")

require(R6)

# TODO: Replace hashmap in r2r.
# See:
# https://github.com/vgherard/r2r/blob/master/R/hashmap.R

# See
# https://riptutorial.com/r/example/18339/environments-as-hash-maps
my_dictionary <-
  R6Class("my_dictionary",
    private = list(
      dict = NA
    ),

    public = list(
      initialize = function() {
        private$dict <- new.env()
      },

      add = function(key, value) {
        private$dict[[key]] <- value
      },

      get_size = function() {
        return(length(private$dict))
      },

      # HACK: The code has room to improve.
      has_key = function(key) {
        value <- private$dict[[key]]

        if (!is.null(value)) {
          return(TRUE)
        } else {
          return(FALSE)
        }
      },

      get_keys = function() {
        return(names(private$dict))
      },

      get_values = function() {
        # TODO: Implement.
      },

      get_value = function(key) {
        return(private$dict[[key]])
      }
    )
  )
