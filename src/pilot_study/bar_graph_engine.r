# Load packages.
require(R6)

# Read other source files.
source("./src/lib/container.r")
source("./src/lib/ggplot2_wrapper/bar_graph_wrapper.r")
source("./src/lib/ggplot2_wrapper/const.r")
source("./src/lib/ggplot2_wrapper/graph_maker.r")
source("./src/pilot_study/const.r")

run_bar_graph_engine <- function(...) {
  engine <- bar_graph_engine$new(factory = list(...)$bar_graph_factory)
  engine$render(...)
}

bar_graph_engine <-
  R6Class("bar_graph_engine",
    inherit = container,

    private = list(
      factory = NULL,

      # See:
      # https://stackoverflow.com/questions/70975914/how-to-check-if-instance-of-r6-class-is-present-in-a-vector-of-class-instances
      is_instance = function(...) {
        return(sapply(c(list(...)$factory), inherits, "bar_graph_factory"))
      }
    ),

    public = list(
      initialize = function(...) {
        super$initialize(...)

        factory <- list(...)$factory

        # TODO: Enable to show current class type.
        if (!private$is_instance(factory = factory)) {
          rlang::abort("Type Error. Expected object of type bar_graph_factory.")
        }

        private$factory <- factory
      },

      render = function(...) {
        factory <- private$factory
        aes     <- factory$get_aes()

        graph_maker_object <- graph_maker$new(
          graph = bar_graph_wrapper$new(data = factory$data_frame, aes = aes)
        )

        # Overwrite default settings. ===
        bar_graph <- graph_maker_object$get_instance()
        bar_graph$add_geom(aes, position = factory$get_bar_position())
        graph_maker_object$update_graph_object()
        # ===

        graph_maker_object$use_default_settings(
          x_axis_name = factory$get_x_axis_name(),
          y_axis_name = factory$get_y_axis_name(),
          # range: min value, max value, interval
          y_axis_range = factory$get_y_axis_range(),
          legend_pos = TOP_RIGHT,
          legend_justification = TOP_RIGHT
        )

        # Options ===
        bar_colors <- list(...)$bar_colors

        if (!is.null(bar_colors)) {
          graph_maker_object$set_colors(colors = bar_colors)
        }

        graph_maker_object$add_main_title(
          main_title = factory$get_main_title()
        )
        graph_maker_object$rotate_x_axis()
        graph_maker_object$set_aspect_ratio_for_axes(
          ratio = factory$get_aspect_ratio()
        )

        legend_title <- factory$get_legend_title()

        if (is.null(legend_title) || !is.na(legend_title)) {
          graph_maker_object$set_legend_title(title = legend_title)
        }

        if (!factory$is_legend_enabled()) {
          graph_maker_object$hide_legend()
        }
        # ===

        graph_maker_object$render(
          file_path = factory$get_file_path(),
          figure_height_cm = DEFAULT_FIGURE_HEIGHT_CM,
          figure_width_cm = DEFAULT_FIGURE_WIDTH_CM
        )
      }
    )
  )
