require(ggplot2)
require(R6)

source("./src/lib/ggplot2_wrapper/graph_wrapper.r")
source("./src/lib/ggplot2_wrapper/geom_flat_violin.r")

# See:
# https://pediatricsurgery.hatenadiary.jp/entry/2018/03/04/133703
# https://sugioka.wiki.fc2.com/wiki/ggplot2%E3%81%A7violinplot%E3%82%92%E6%8F%8F%E3%81%8F
# https://ggplot2.tidyverse.org/reference/geom_boxplot.html
# http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software
flat_violin_wrapper <-
  R6Class("flat_violin_wrapper",
    inherit = graph_wrapper,

    public = list(
      initialize = function(...) {
        data   <- list(...)$data

        super$initialize(data)
      },

      add_geom = function(
        aes,
        color,
        adjust,
        width = 1.0,
        scale = "area",
        position = 0.0
      ) {
        geom <- geom_flat_violin(
          aes,
          fill = color,
          adjust = adjust,
          width = width,
          scale = scale,
          position = position_nudge(position),
          linetype = "blank",
          alpha = 1
        )

        return(geom)
      },

      # TODO: Replace hard code to args.
      add_box_plot = function(aes, width, position) {
        box_plot <- geom_boxplot(
          aes,
          width = width,
          position = position_nudge(position),
          lwd = 0.25,
          outlier.size = 0.5
        )

        return(box_plot)
      }
    )
  )
