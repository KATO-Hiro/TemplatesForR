# Graph wrapper for ggplot2.

# Usage:
##  Install these packages as needed.
#  install.packages("R6")
#  install.packages("tidyverse")
#
##  Import libraries and helper files.
#  require(R6)
#  require("tidyr")
#  require("reshape2")
#
#  source("graphwrapper.r")
#  source("renderer.r")
#
##  Prepare data and convert its format for ggplot2.
#
##  Make a scatter plot.
#  scatter_plot <- scatter_plot_wrapper$new(data, aes)
#  g <- scatter_plot$get_graph_object()
#
#  canvas <- scatter_plot$add_canvas()
#  g <- g + canvas$initialize_background()
#  g <- g + canvas$add_title(title)
#  g <- g + canvas$add_margin()
#
#  axis <- scatter_plot$add_axis()
#  g <- g + axis$add_labels(x_axis_name = "TODO: Write x axis label name.",
#                           y_axis_name = "TODO: Write y axis label name.")
#  g <- g + axis$set_labels_font()
#  g <- g + axis$modify_x_axis(lower_and_upper = c(1.0, 7.0),
#                              ticks = seq(1.0, 7.0, 0.5))
#  g <- g + axis$modify_y_axis(lower_and_upper = c(0, 80),
#                              ticks = seq(0, 80, 10))
#  g <- g + axis$set_axis_font()
#
#  g <- g + scale_fill_manual(name = "",
#                             values = c("green"),
#                             labels = c("TODO: Write label name"))
#  legend <- scatter_plot$add_legend()
#  g <- g + legend$set_position(c(0.25, 0.9))
#  g <- g + legend$set_font()
#  g <- g + legend$set_edge()
#
#  grid <- scatter_plot$add_grid()
#  g <- g + grid$set_default()
#
#  print(g)

require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/axis_wrapper.r")
source("./src/lib/ggplot2_wrapper/canvas.r")
source("./src/lib/ggplot2_wrapper/grid_wrapper.r")
source("./src/lib/ggplot2_wrapper/legend_wrapper.r")

# See:
# https://cran.r-project.org/web/packages/R6/R6.pdf
# https://adv-r.hadley.nz/r6.html
graph_wrapper <-
  R6Class("graph_wrapper",
    private = list(
      graph_object = NA
    ),

    public = list(
      initialize = function(data, aes = NULL) {
        if (is.null(aes)) {
          private$graph_object <- ggplot(data)
        } else {
          private$graph_object <- ggplot(data, aes)
        }
      },

      add_geom = function(aes) {

      },

      get_graph_object = function() {
        return(private$graph_object)
      },

      add_canvas = function() {
        return(canvas$new())
      },

      add_axis = function() {
        return(axis_wrapper$new())
      },

      add_legend = function() {
        return(legend_wrapper$new())
      },

      add_grid = function() {
        return(grid_wrapper$new())
      }
    )
  )

# function_shape: Shape of function.
# function_args : args of function. Use list type.
# x_axis_range  : lower and upper limit in x axis. c(value_min, value_max)

# Usage:
# Define your function if needs. You can use built-in functions.
# power_function <- function(x, a, b, c) {
#   a * (x - b) ** c
# }
#
# Add a curve to existed graphic object.
# g <- g + add_curve(
#   aes = aes,
#   function_shape = power_function,
#   function_args = list(a = hoge, b = foo, c = bar),
#   x_axis_range = c(1.0, 7.0),
#   color = "black",
#   size = 1.5)

# See:
# https://ggplot2.tidyverse.org/reference/stat_function.html#arguments
# https://qiita.com/hoxo_b/items/a6522a6e6561f8ca7b96#q
add_curve <-
  function(aes, function_shape, function_args,
           x_axis_range, color = "black", size = 1.5) {
  stat_function(mapping = aes,
                fun = function_shape,
                args = function_args,
                xlim = x_axis_range,
                color = color,
                size = size,
                )
}

# See:
# https://ggplot2.tidyverse.org/reference/geom_point.html
# https://rpubs.com/yoshio/95824
add_point_plot_to_existing_figure <- function(
  g,
  data,
  aes,
  color,
  size = 1.0
) {
  g <- g + geom_point(
    data = data,
    mapping = aes,
    position = "identity",
    color = color,
    size = size
  )

  return(g)
}
