# http://qiita.com/hik0107/items/e486943721e815e4e006
require(ggplot2)
require(R6)

source("./src/lib/operator.r")

pdf_creator <-
  R6Class("pdf_creator",
    # Required: The initial value of the member variable.
    private = list(
      name = "",
      size = ""
    ),

    public = list(
      initialize = function(my_name, paper_size = "a4r") {
          private$name <- my_name
          private$size <- paper_size
      },

      # See:
      # https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/pdf.html
      open = function(point_size = 10, width = 7, height = 7) {
          pdf(file = join_strings(private$name, ".pdf"),
              width = width,
              height = height,
              paper = private$size
             )

          # Set permanent parameter.
          par(ps = point_size)
      },

      # TODO: If R6 class has destructor, this method move to it.
      # Required: The device should be closed after open method in your script.
      close = function() {
          dev.off()
      }
    )
  )
