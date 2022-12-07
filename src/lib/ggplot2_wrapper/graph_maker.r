# Load packages.
require(ggplot2)
require(R6)

# Read other source files.
source("./src/lib/colors.r")
source("./src/lib/ggplot2_wrapper/const.r")

# Usage:
# source("./src/lib/ggplot2_wrapper/const.r")
# source("./src/lib/ggplot2_wrapper/graph_maker.r")
# source("./src/lib/ggplot2_wrapper/scatter_plot_wrapper.r")
# source("./src/lib/ggplot2_wrapper/bar_graph_wrapper.r")

# # Scatter plot.
# # sample data
# x <- data.frame(
#   weight = c(1.2, 1.5, 1.1, 1.6, 1.6, 1.4, 1.3, 0.9, 1.1),
#   seeds = c(26, 31, 19, 34, 38, 23, 24, 21, 24)
# )

# aes <- aes(x = weight, y = seeds)
# graph_maker_object <- graph_maker$new(
#   graph = scatter_plot_wrapper$new(data = x, aes = aes)
# )

# # Overwrite default settings. ===
# scatter_graph <- graph_maker_object$get_instance()
# scatter_graph$add_geom(aes, point_size = 2, color = RED)
# graph_maker_object$update_graph_object()
# # ===

# graph_maker_object$use_default_settings(
#   x_axis_name = "Weight",
#   y_axis_name = "Seeds",
#   x_axis_range = seq(0, 2, 0.2), # min value, max value, interval
#   y_axis_range = seq(0, 40, 5), # min value, max value, interval
#   legend_pos = TOP_LEFT,
#   legend_justification = TOP_LEFT
# )

# # Options ===
# graph_maker_object$add_main_title(
#   main_title = "TODO: Write title here!"
# )
# graph_maker_object$rotate_x_axis()
# graph_maker_object$add_forty_five_degree_line()
# # ===

# graph_maker_object$render(
#   file_path = "figure_name.png",
#   figure_height_cm = 15,
#   figure_width_cm = 15
# )


# # Bar plot
# # sample data
# x <- data.frame(
#   cell   = c("A", "A", "B", "B", "C", "C"),
#   sample = c("A1", "A2", "B1", "B2", "C1", "C2"),
#   weight = c(0.32, 0.33, 0.21, 0.22, 0.37, 0.36)
# )

# aes <- aes(x = cell, y = weight, fill = sample)
# graph_maker_object <- graph_maker$new(
#   graph = bar_graph_wrapper$new(data = x, aes = aes)
# )

# # Overwrite default settings. ===
# bar_graph <- graph_maker_object$get_instance()
# bar_graph$add_geom(aes, position = STACK)
# graph_maker_object$update_graph_object()
# # ===

# graph_maker_object$use_default_settings(
#   x_axis_name = "Cell",
#   y_axis_name = "Weight",
#   # x_axis_range = seq(0, 2, 0.2), # min value, max value, interval
#   y_axis_range = seq(0, 1.0, 0.1), # min value, max value, interval
#   legend_pos = TOP_LEFT,
#   legend_justification = TOP_LEFT
# )

# # Options ===
# graph_maker_object$add_main_title(
#   main_title = "TODO: Write title here!"
# )
# graph_maker_object$set_colors(
#   colors = c(RED, ORANGE, YELLOW, YELLOW_GREEN, LIGHT_BLUE, BLUE, BLACK)
# )
# graph_maker_object$hide_grid()
# # ===

# graph_maker_object$render(
# #   file_path = "figure_name.png",
# #   figure_height_cm = 15,
# #   figure_width_cm = 15
# )

# See:
# https://cran.r-project.org/web/packages/R6/R6.pdf
# https://adv-r.hadley.nz/r6.html
graph_maker <-
  R6Class("graph_maker",
    private = list(
      graph = NULL,
      g = NULL,
      canvas = NULL,
      axis = NULL,
      legend = NULL,
      grid = NULL,

      set_canvas = function(...) {
        private$canvas <- private$graph$add_canvas()

        private$g <- private$g + private$canvas$initialize_background()
        private$g <- private$g + private$canvas$add_margin()
      },

      set_axis = function(...) {
        private$axis <- private$graph$add_axis()

        private$g <- private$g + private$axis$add_labels(
          x_axis_name = list(...)$x_axis_name,
          y_axis_name = list(...)$y_axis_name
        )

        private$set_axis_range(...)

        private$set_axis_font(...)
      },

      set_axis_range = function(...) {
        x_axis_range <- list(...)$x_axis_range
        y_axis_range <- list(...)$y_axis_range

        if (!is.null(x_axis_range)) {
          private$g <- private$g + private$axis$modify_x_axis(
            lower_and_upper = c(min(x_axis_range), max(x_axis_range)),
            ticks = x_axis_range
          )
        }

        if (!is.null(y_axis_range)) {
          private$g <- private$g + private$axis$modify_y_axis(
            lower_and_upper = c(min(y_axis_range), max(y_axis_range)),
            ticks = y_axis_range
          )
        }
      },

      set_axis_font = function(...) {
        private$g <- private$g + private$axis$set_axis_font()
        private$g <- private$g + private$axis$set_labels_font()
      },

      set_legend = function(...) {
        private$legend <- private$graph$add_legend()

        private$g <- private$g + private$legend$set_position(
          position = list(...)$legend_pos,
          justification = list(...)$legend_justification
        )
        private$g <- private$g + private$legend$set_font()
        private$g <- private$g + private$legend$set_edge()
      },

      set_grid = function(...) {
        private$grid <- private$graph$add_grid()

        private$g <- private$g + private$grid$set_default()
        private$g <- private$g + private$grid$add_major_line(DARK_GRAY)
        private$g <- private$g + private$grid$add_minor_line(WHITE)
      }
    ),

    public = list(
      initialize = function(...) {
        private$graph <- list(...)$graph
        private$g <- private$graph$get_graph_object()
      },

      use_default_settings = function(...) {
        private$set_canvas(...)
        private$set_axis(...)
        private$set_grid(...)
        private$set_legend(...)
      },

      get_instance = function() {
        return(private$graph)
      },

      update_graph_object = function() {
        private$g <- private$graph$get_graph_object()
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/scale_manual.html
      set_colors = function(...) {
        aes_type <- list(...)$aes_type

        if (is.null(aes_type)) {
          private$g <- private$g + scale_fill_manual(
            values = list(...)$colors
          )
        } else if (aes_type == AES_COLOR) {
          private$g <- private$g + scale_color_manual(
            values = list(...)$colors
          )
        }
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/scale_linetype.html
      # http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software
      set_line_types = function(...) {
        private$g <- private$g + scale_linetype_manual(
          values = list(...)$line_types
        )
      },

      add_main_title = function(...) {
        private$g <- private$g + private$canvas$add_title(
          main_title = list(...)$main_title
        )
      },

      rotate_x_axis = function(angle = 90, hjust = 1, vjust = 0.5) {
        private$g <- private$g + private$axis$rotate_x_axis(
          angle = angle,
          hjust = hjust,
          vjust = vjust
        )
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/coord_fixed.html
      set_aspect_ratio_for_axes = function(ratio = 1.0) {
        private$g <- private$g + coord_fixed(
          # ratio: aspect ratio, expressed as y axis / x axis
          ratio = ratio
        )
      },

      set_legend_title = function(...) {
        aes_type <- list(...)$aes_type
        title    <- list(...)$title

        if (is.null(aes_type)) {
          private$g <- private$g + private$legend$set_title(
            title = title
          )
        } else if (aes_type == AES_COLOR) {
          private$g <- private$g + guides(color = guide_legend(title = title))
        }
      },

      hide_legend = function() {
        private$g <- private$g + private$legend$hide()
      },

      hide_grid = function() {
        private$g <- private$g + private$grid$add_major_line(WHITE)
      },

      add_forty_five_degree_line = function(intercept = 0, slope = 1) {
        private$g <- private$g + private$grid$add_forty_five_degree_line(
          intercept = intercept,
          slope = slope
        )
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/annotate.html
      fill_with_rectangle = function(
        x_axis_min, x_axis_max,
        y_axis_min, y_axis_max,
        color = BLACK,
        transparency = 1 # 0 (transparency) - 1 (opacity)
      ) {
        private$g <- private$g + annotate(
          "rect",
          xmin = x_axis_min, xmax = x_axis_max,
          ymin = y_axis_min, ymax = y_axis_max,
          fill = color,
          alpha = transparency
        )
      },

      # Usage:
      # colors = ifelse(vector == condition, color for special case, color for base case)
      #
      # See:
      # https://community.rstudio.com/t/axis-labels-with-individual-colors/77848/2
      #
      # Note: Vectorized input to `element_text()` is not officially supported.
      # Results may be unexpected or may change in future versions of ggplot2.
      change_x_axis_color = function(colors) {
        private$g <- private$g + private$axis$set_x_axis_color(colors = colors)
      },

      change_y_axis_color = function(colors) {
        private$g <- private$g + private$axis$set_y_axis_color(colors = colors)
      },

      render = function(...) {
        file_path <- list(...)$file_path

        figure_height_cm <- list(...)$figure_height_cm
        figure_width_cm  <- list(...)$figure_width_cm

        if (is.null(file_path) || is.null(figure_height_cm) || is.null(figure_width_cm)) {
          print(private$g)
        } else {
          ggsave(
            file_path,
            width = figure_width_cm,
            height = figure_height_cm,
            units = "cm"
          )
        }
      }
    )
  )
