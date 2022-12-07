require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/graph_wrapper.r")

histogram_wrapper <-
  R6Class("histogram_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(data, aes) {
        super$initialize(data)
        self$add_geom(aes)
      },

      add_geom = function(aes) {
        private$graph_object <-
          private$graph_object + geom_histogram(aes)
      }
    )
  )
