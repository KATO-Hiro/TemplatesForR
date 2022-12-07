if (!require(R6)) install.packages("R6")

require(R6)

# Usage:
figure <-
  R6Class("figure",
    private = list(
      # Implement initial value of attributes in sub-class.
    ),

    public = list(
      # See:
      # https://heavywatal.github.io/rstats/programming.html
      initialize = function(...) {
        # Implement attributes in sub-class.
      },

      render = function(...) {
        # Implement figure object in sub-class.
      },

      rotate_axis = function(direction = 1, range = seq(0, 250, 12), las = 3) {
        # See:
        # https://bioinfo-dojo.net/2016/11/24/various_axis_r/
        # direction: 1 means below.
        axis(side = direction,
             at = range,
             labels = as.character(range),
             las = las
            )
      },

      # See:
      # http://cse.naro.affrc.go.jp/takezawa/r-tips/r/51.html
      add_axis_label = function(label_name = "", side = LEFT, length_from_axis = 3) {
        mtext(label_name,
              side = side,
              line = length_from_axis
             )
      }
    )
  )
