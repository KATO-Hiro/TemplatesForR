require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/graph_wrapper.r")

# See:
# https://ggplot2.tidyverse.org/reference/geom_boxplot.html?q=geom_boxplot#ref-examples
# http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization
box_plot_wrapper <-
  R6Class("box_plot_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(data, aes) {
        super$initialize(data)
        self$add_geom(aes)
      },

      add_geom = function(aes) {
        private$graph_object <- private$graph_object + geom_boxplot(aes)
      }
    )
  )
