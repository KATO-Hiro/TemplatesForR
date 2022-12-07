require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/color_wrapper.r")
source("./src/lib/ggplot2_wrapper/graph_wrapper.r")

line_graph_wrapper <-
  R6Class("line_graph_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(data, aes) {
        super$initialize(data)
        self$add_geom(aes)
      },

      add_geom = function(
        aes,
        color = BLACK,
        line_size = 1,
        add_points = FALSE,
        point_size = 1
      ) {
        private$graph_object <- private$graph_object + geom_line(
          aes,
          color = color,
          size = line_size
        )

        if (add_points) {
          private$graph_object <- private$graph_object + geom_point(
            aes,
            color = color,
            size = point_size
          )
        }
      },

      add_axis = function(is_time_series = FALSE) {
        if (is_time_series == TRUE) {
          return(axis_wrapper_time_series$new())
        } else {
          return(axis_wrapper$new())
        }
      }
    )
  )
