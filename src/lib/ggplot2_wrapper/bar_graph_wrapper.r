require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/axis_wrapper.r")
source("./src/lib/ggplot2_wrapper/color_wrapper.r")
source("./src/lib/ggplot2_wrapper/graph_wrapper.r")

bar_graph_wrapper <-
  R6Class("bar_graph_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(data, aes) {
        super$initialize(data)
        self$add_geom(aes)
      },

      # See:
      # https://web.archive.org/web/20191203092515/http://yutakahogeta.blogspot.com/2014/09/ggplot2_8.html
      # https://ggplot2.tidyverse.org/reference/geom_bar.html
      add_geom = function(aes, position = "dodge") {
        private$graph_object <- private$graph_object +
          geom_bar(
            aes,
            stat = "identity",
            position = position,
            width = 0.5,
            color = black,
            size = 0.25
          )
      },

      add_axis = function(is_time_series = FALSE) {
        if (is_time_series) {
          return(axis_wrapper_time_series$new())
        } else {
          return(axis_wrapper$new())
        }
      }
    )
  )
