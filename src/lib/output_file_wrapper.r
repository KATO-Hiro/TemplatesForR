if (!require(R6)) install.packages("R6")

require(R6)

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sink
# https://www1.doshisha.ac.jp/~mjin/R/Chap_02/02.html
output_file_wrapper <-
  R6Class("output_file_wrapper",
    private = list(
      file_path = "", # File extension is required.

      open = function() {
        sink(private$file_path)
      }
    ),

    public = list(
      # See:
      # https://heavywatal.github.io/rstats/programming.html
      initialize = function(...) {
        private$file_path <- list(...)$file_path
        private$open()
      },

      write = function(data) {
        print(data)
      },

      # This method is expected to be called after all the data have been
      # written.
      close = function() {
        sink()
      }
    )
  )
