require(ggplot2)
require(R6)
require(scales)

# See:
# https://cran.r-project.org/web/packages/R6/R6.pdf
# https://adv-r.hadley.nz/r6.html
# https://ggplot2.tidyverse.org/reference/scale_continuous.html
# https://www.rdocumentation.org/packages/ggplot2/versions/2.1.0/topics/element_text
axis_wrapper <-
  R6Class("axis_wrapper",
    public = list(
      initialize = function() {
      },

      add_labels = function(x_axis_name, y_axis_name) {
        return(labs(x = x_axis_name, y = y_axis_name))
      },

      set_labels_font = function(size = 15) {
        return(theme(axis.title = element_text(size = size)))
      },

      # lower_and_upper: modify the axis limits.
      # ticks          : choose where the ticks appear.
      # accuracy       : label format. ex: 1, 0.1, 0.01, ...

      # example:
      # modify_x_axis(lower_and_upper = c(1.0, 7.0),
      #               breaks = seq(1.0, 7.0, 0.5),
      #               expand = c(0, 0))
      # seq(min_value, max_value, span)
      modify_x_axis = function(lower_and_upper, ticks) {
        return(scale_x_continuous(limits = lower_and_upper,
                                  breaks = ticks,
                                  expand = c(0, 0))
        )
      },

      modify_y_axis = function(lower_and_upper, ticks, accuracy = NULL) {
        return(scale_y_continuous(limits = lower_and_upper,
                                  breaks = ticks,
                                  expand = c(0, 0),
                                  labels = number_format(accuracy = accuracy))
        )
      },

      set_axis_font = function(size = 15) {
        return(theme(axis.text = element_text(size = size)))
      },

      set_x_axis_font = function(size = 15) {
        return(theme(axis.text.x = element_text(size = size)))
      },

      set_y_axis_font = function(size = 15) {
        return(theme(axis.text.y = element_text(size = size)))
      },

      # angle: angle (in [0, 360])
      # hjust: horizontal justification (in [0, 1])
      # vjust: vertical justification (in [0, 1])
      rotate_x_axis = function(angle = 90, hjust = 1, vjust = 0.5) {
        return(theme(axis.text.x = element_text(angle = angle,
                                                hjust = hjust,
                                                vjust = vjust)))
      },

      # See:
      # https://community.rstudio.com/t/axis-labels-with-individual-colors/77848/2
      set_x_axis_color = function(colors) {
        return(theme(axis.text.x = element_text(color = colors)))
      },

      set_y_axis_color = function(colors) {
        return(theme(axis.text.y = element_text(color = colors)))
      }
    )
  )

axis_wrapper_time_series <-
  R6Class("axis_wrapper_time_series",
    inherit = axis_wrapper,

    public = list(
      # Require: The below library is needed.
      # require(scales)
      # ticks: scale interval.

      # example:
      # breaks = date_breaks("30 days")
      modify_x_axis = function(lower_and_upper, ticks) {
        return(scale_x_datetime(breaks = ticks))
      }
    )
  )