# Load packages.
require(R6)

# Read other source files.
source("./src/lib/container.r")
source("./src/lib/ggplot2_wrapper/const.r")
source("./src/lib/ggplot2_wrapper/graph_maker.r")
source("./src/lib/ggplot2_wrapper/lines_graph_wrapper.r")
source("./src/pilot_study/const.r")

run_line_graph_engine <- function(...) {
  engine <- line_graph_engine$new(factory = list(...)$line_graph_factory)
  engine$render(...)
}

line_graph_engine <-
  R6Class("line_graph_engine",
    inherit = container,

    private = list(
      factory = NULL,

      # See:
      # https://stackoverflow.com/questions/70975914/how-to-check-if-instance-of-r6-class-is-present-in-a-vector-of-class-instances
      is_instance = function(...) {
        return(sapply(c(list(...)$factory), inherits, "line_graph_factory"))
      }
    ),

    public = list(
      initialize = function(...) {
        super$initialize(...)

        factory <- list(...)$factory

        # TODO: Enable to show current class type.
        if (!private$is_instance(factory = factory)) {
          rlang::abort("Type Error. Expected object of type line_graph_factory.")
        }

        private$factory <- factory
      },

      render = function(...) {
        factory <- private$factory
        aes     <- factory$get_aes()

        graph_maker_object <- graph_maker$new(
          graph = lines_graph_wrapper$new(data = factory$data_frame, aes = aes)
        )

        # Overwrite default settings. ===
        line_graph <- graph_maker_object$get_instance()
        line_graph$add_geom(
          aes,
          line_size = factory$get_line_size(),
          add_points = factory$is_add_points(),
          point_size = factory$get_point_size()
        )
        graph_maker_object$update_graph_object()
        # ===

        graph_maker_object$use_default_settings(
          x_axis_name = factory$get_x_axis_name(),
          y_axis_name = factory$get_y_axis_name(),
          # range: min value, max value, interval
          x_axis_range = factory$get_x_axis_range(),
          y_axis_range = factory$get_y_axis_range(),
          legend_pos = BOTTOM_RIGHT,
          legend_justification = BOTTOM_RIGHT
        )

        # Options ===
        line_colors <- list(...)$line_colors

        if (!is.null(line_colors)) {
          graph_maker_object$set_colors(aes_type = AES_COLOR, colors = line_colors)
        }

        line_types <- list(...)$line_types

        if (!is.null(line_types)) {
          graph_maker_object$set_line_types(line_types = line_types)
        }

        graph_maker_object$add_main_title(main_title = factory$get_main_title())
        graph_maker_object$rotate_x_axis()
        graph_maker_object$set_aspect_ratio_for_axes(ratio = factory$get_aspect_ratio())

        legend_title <- factory$get_legend_title()

        if (is.null(legend_title) || !is.na(legend_title)) {
          graph_maker_object$set_legend_title(aes_type = AES_COLOR, title = legend_title)
        }

        if (!factory$is_legend_enabled()) {
          graph_maker_object$hide_legend()
        }
        # ===
        figure_height_cm <- list(...)$figure_height_cm
        figure_width_cm  <- list(...)$figure_width_cm

        graph_maker_object$render(
          file_path = factory$get_file_path(),
          figure_height_cm = ifelse(is.null(figure_height_cm), DEFAULT_FIGURE_HEIGHT_CM, figure_height_cm),
          figure_width_cm = ifelse(is.null(figure_width_cm), DEFAULT_FIGURE_WIDTH_CM, figure_width_cm)
        )
      }
    )
  )
