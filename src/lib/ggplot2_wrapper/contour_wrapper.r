# Load packages.
require(ggplot2)
require(R6)

# Read other source files.
source("./src/lib/ggplot2_wrapper/graph_wrapper.r")

contour_wrapper <-
  R6Class("contour_wrapper",
    inherit = graph_wrapper,

    private = list(
      # TODO: Refactoring. Extract method.
      get_band_width = function(values) {
        band_width <- MASS::bandwidth.nrd(
          values
        )

        # HACK: This solution may not be good.
        # See:
        # https://github.com/mwaskom/seaborn/issues/1990
        if (band_width == 0) {
          band_width <- 10 ** (-6)
        }

        return(band_width)
      }
    ),

    public = list(
      initialize = function(data, aes) {
        super$initialize(data, aes)
        self$add_geom(aes)
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/geom_density_2d.html
      # https://rdrr.io/r/base/pretty.html
      add_geom = function(aes) {
        data         <- private$graph_object$data
        x_band_width <- private$get_band_width(data$first_point)
        y_band_width <- private$get_band_width(data$second_point)

        private$graph_object <- private$graph_object + geom_density_2d_filled(
          aes,
          breaks = c(0, 0.001, seq(0.05, 0.50, 0.05), 1.00, 2.00),
          h = c(x_band_width, y_band_width)
        )
      }
    )
  )
