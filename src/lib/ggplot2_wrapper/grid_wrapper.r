require(ggplot2)
require(R6)

# See:
# https://cran.r-project.org/web/packages/R6/R6.pdf
# https://adv-r.hadley.nz/r6.html
# https://ggplot2.tidyverse.org/reference/geom_abline.html
grid_wrapper <-
  R6Class("grid_wrapper",
    public = list(
      set_default = function() {
        results <- self$add_major_line()
        results <- results + self$add_minor_line()
        return(results)
      },

      add_major_line = function(color = "black") {
        return(theme(panel.grid.major = element_line(color)))
      },

      add_minor_line = function(color = "white") {
        return(theme(panel.grid.minor = element_line(color)))
      },

      add_forty_five_degree_line = function(intercept = 0, slope = 1) {
        line <- geom_abline(
          intercept = intercept,
          slope = slope
        )

        return(line)
      }
    )
  )
