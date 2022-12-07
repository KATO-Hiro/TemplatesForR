# Load packages.
require(logger)

# See:
# https://daroczig.github.io/logger/articles/customize_logger.html
# https://daroczig.github.io/logger/articles/customize_logger.html#delivering-log-records-to-their-destination
set_log_file <- function(file = NULL) {
  if (is.null(file)) {
    log_appender(
      appender_stdout
    )
  } else {
    log_appender(
      appender_file(
        file
      )
    )
  }
}

set_debug_mode <- function() {
  log_threshold(DEBUG)
}

set_info_mode <- function() {
  log_threshold(INFO)
}

set_warn_mode <- function() {
  log_threshold(WARN)
}
