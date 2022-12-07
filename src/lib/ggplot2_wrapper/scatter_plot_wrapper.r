require(ggplot2)
require(R6)

source("./src/lib/colors.r")
source("./src/lib/ggplot2_wrapper/graph_wrapper.r")
source("./src/lib/graph_settings.r")

scatter_plot_wrapper <-
  R6Class("scatter_plot_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(data, aes) {
        super$initialize(data)
        # self$add_geom(aes)
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/aes_colour_fill_alpha.html
      # https://heavywatal.github.io/rstats/ggplot2.html
      add_geom = function(aes,
        shape = SOLID_CIRCLE,
        point_size = 1,
        color = BLACK,
        transparency = 1 # 0 (transparency) - 1 (opacity)
      ) {

        private$graph_object <- private$graph_object +
          geom_point(
            aes,
            shape = shape,
            size = point_size,
            color = color,
            alpha = transparency
          )
      }
    )
  )
