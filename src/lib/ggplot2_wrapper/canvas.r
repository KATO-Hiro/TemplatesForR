require(ggplot2)
require(R6)

# See:
# https://cran.r-project.org/web/packages/R6/R6.pdf
# https://adv-r.hadley.nz/r6.html
canvas <-
  R6Class("canvas",
    public = list(
      initialize_background = function() {
        return(theme_bw())
      },

      add_title = function(main_title = "") {
        return(labs(title = main_title))
      },

      add_margin = function(size = c(0.5, 1, 0.5, 0.5), unit = "cm") {
        return(theme(plot.margin = unit(size, unit)))
      }
    )
  )
