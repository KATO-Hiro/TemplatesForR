# Load packages.
require(data.table)
require(R6)

# Read other source files.
source("./src/lib/const.r")
source("./src/lib/container.r")
source("./src/lib/dplyr_wrapper.r")
source("./src/lib/generic_functions.r")
source("./src/lib/graph_settings.r")
source("./src/lib/logging_wrapper.r")
source("./src/lib/operator.r")
source("./src/lib/pdfcreator.r")
source("./src/preparation/const.r")

main <- function() {
  # FIXME: Rename output file name.
  pdf_name <-  "./src/output/results-Ver.1.3"

  # IS_OUTPUT_PDF <- FALSE # For dry run.

  pdf_creator_object <- pdf_creator$new(my_name = pdf_name)

  before_run(
    is_output_pdf = IS_OUTPUT_PDF,
    pdf_creator_object = pdf_creator_object
  )
  run()
  after_run(
    is_output_pdf = IS_OUTPUT_PDF,
    pdf_creator_object = pdf_creator_object
  )
}

before_run <- function(...) {
  #TODO: Implement commands before run() method.
  create_dir(LOG_DIR)
  set_log_file(LOG_FILE)
  set_info_mode()

  is_output_pdf      <- list(...)$is_output_pdf
  pdf_creator_object <- list(...)$pdf_creator_object

  if (is_output_pdf) {
    pdf_creator_object$open(point_size = 16)
  }
}

after_run <- function(...) {
  #TODO: Implement commands after run() method.
  is_output_pdf      <- list(...)$is_output_pdf
  pdf_creator_object <- list(...)$pdf_creator_object

  if (is_output_pdf) {
    pdf_creator_object$close()
  }
}

run <- function() {
  log_info("Start calculations and drawings in the pilot study.")

  is_dry_run <- TRUE # for developing.
  # is_dry_run <- FALSE # for production.

  settings <- initialize_settings()

  render(
    is_dry_run = is_dry_run
  )

  # TODO: Enable to handle multiple cases.
  render_a_case(
    is_dry_run = is_dry_run
  )

  log_info("Calculations and drawings in the pilot study have been completed.")
}

initialize_settings <- function() {
  return()
}

render <- function(...) {
  is_dry_run   <- list(...)$is_dry_run

  log_info("dry run: {is_dry_run}")
}

render_a_case <- function(...) {
  is_dry_run   <- list(...)$is_dry_run

  log_info("dry run: {is_dry_run}")
}

main()
