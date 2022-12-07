require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/const.r")

# See:
# https://cran.r-project.org/web/packages/R6/R6.pdf
# https://adv-r.hadley.nz/r6.html
legend_wrapper <-
  R6Class("legend_wrapper",
    public = list(
      initialize = function() {
      },

      # place legends inside the plot using relative coordinates between 0 and 1
      # examples:
      # positon = "top"
      # positon = c(0.1, 0.9)
      # justification = c(1, 1) # top-right, c(1, 0) # bottom-right
      #                 c(0, 1) # top-left, c(0, 0) # bottom-left
      set_position = function(position, justification = c(1, 1)) {
        return(theme(legend.position = position,
                     legend.justification = justification))
      },

      set_font = function(size = 14) {
        return(theme(legend.title = element_text(size = size),
                     legend.text = element_text(size = size)))
      },

      set_edge = function() {
        return(theme(legend.box.background = element_rect(),
                     legend.box.margin = margin(1, 1, 1, 1)))
      },

      # See:
      # https://ggplot2.tidyverse.org/reference/guide_legend.html
      # https://rstudio-pubs-static.s3.amazonaws.com/459388_c0f0abce1612426c8aec91b678da8670.html#labs-theme-guides
      # https://heavywatal.github.io/rstats/ggplot2.html
      set_line_size = function(size = 1.5) {
        return(guides(color = guide_legend(override.aes = list(size = size))))
      },

      set_title = function(title) {
        return(guides(fill = guide_legend(title = title)))
      },

      hide = function() {
        return(guides(fill = NONE))
      }
    )
  )
