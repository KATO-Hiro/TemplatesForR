require(ggplot2)
require(R6)

source("./src/lib/colors.r")
source("./src/lib/ggplot2_wrapper/graph_wrapper.r")

histogram_wrapper <-
  R6Class("histogram_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(data, aes) {
        super$initialize(data)
      },

      # FIXME: Enable to adjust x axis position.
      add_geom = function(aes, bin_width) {
        private$graph_object <-
          private$graph_object + geom_histogram(
            aes,
            binwidth = bin_width,
            closed = "left",
            boundary = 0,
          )
      }
    )
  )
