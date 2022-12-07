store_default_graph_settings <- function() {
  old_params <- par(no.readonly = TRUE)

  return(old_params)
}

# See:
# http://takenaka-akio.org/doc/r_auto/chapter_05.html
change_font_size <- function(font_size = 18) {
  par(ps = font_size)
}

change_no_of_figs_per_sheet <- function(row_count, column_count) {
  par(mfrow = c(row_count, column_count))
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/formatC
specify_axis_format <- function(values, digits, format = "f") {
  results <- formatC(
    values,
    digits = digits,
    format = format
  )

  return(results)
}

# See:
# http://cse.naro.affrc.go.jp/takezawa/r-tips/r/55.html
# mex: size based on character.
add_margin <- function(
  bottom_mex = 0,
  left_mex = 0,
  top_mex = 0,
  right_mex = 0
) {
  par(oma = c(bottom_mex, left_mex, top_mex, right_mex))
}

# See:
# http://cse.naro.affrc.go.jp/takezawa/r-tips/r/52.html
change_plot_region <- function(
  bottom_ratio = 0,
  left_ratio = 1,
  top_ratio = 0,
  right_ratio = 1
) {
  par(plt = c(bottom_ratio, left_ratio, top_ratio, right_ratio))
}

BOTTOM <- 1
LEFT   <- 2
TOP    <- 3
RIGHT  <- 4

# Note: Render graph(s) and then use this method.
# See:
# http://cse.naro.affrc.go.jp/takezawa/r-tips/r/55.html
add_overall_title <- function(side, text, character_size) {
  mtext(
    side = side,
    outer = TRUE,
    text = text,
    cex = character_size
  )
}

overwrite_plot <- function() {
  par(new = TRUE)
}

# Set line type
SOLID_LINE  <- 1
DASHED_LINE <- 2

POINT_PLOT          <- "p"
LINE_AND_POINT_PLOT <- "b"

# Set point type
DASHED_CIRCLE <- 1 # "○"
SOLID_CIRCLE  <- 20 # "●"
NO_MARKER     <- 30

restore_default_graph_settings <- function(default_graph_settings) {
  par(default_graph_settings)
}

IS_OUTPUT_PDF <- TRUE

# See:
# https://stat.ethz.ch/R-manual/R-patched/library/grDevices/html/pdf.html
open_pdf <- function(pdf_name, width = 7, height = 7) {
  pdf(file = pdf_name,
      width = width,
      height = height
     )
}

# Note: If you call "open_pdf", you must use it.
close_pdf <- function() {
  dev.off()
}
