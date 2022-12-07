# Load packages.
require(R6)

# Read other source files.
source("./src/lib/ggplot2_wrapper/const.r")

# Factory method ===
make_line_graph_factory <- function(...) {
  factory <- line_graph_factory$new()

  return(factory)
}
# ===

line_graph_factory <-
  R6Class("line_graph_factory",

    private = list(
      data_frame = NULL,
      aes = NULL,
      x_axis_name = "",
      y_axis_name = "",
      x_axis_range = NULL,
      y_axis_range = NULL,
      main_title = "",
      legend_enabled = TRUE,
      legend_title = NA,
      aspect_ratio = 1.0,
      file_path = "",
      line_size = 1.5,
      add_points = TRUE,
      point_size = 3
    ),

    public = list(
      initialize = function(...) {
      },

      # Required ===
      add_data_frame = function(data_frame) {
        private$data_frame <- data_frame
      },

      add_aes = function(aes) {
        private$aes <- aes
      },

      # Optional ===
      add_x_axis_name = function(name) {
        private$x_axis_name <- name
      },

      add_y_axis_name = function(name) {
        private$y_axis_name <- name
      },

      add_x_axis_range = function(range) {
        private$x_axis_range <- range
      },

      add_y_axis_range = function(range) {
        private$y_axis_range <- range
      },

      add_main_title = function(title) {
        private$main_title <- title
      },

      add_file_path = function(...) {
        private$file_path <- list(...)$file_path
      },

      update_line_size = function(size) {
        private$line_size <- size
      },

      hide_points = function() {
        private$add_points <- FALSE
      },

      update_point_size = function(size) {
        private$point_size <- size
      },

      update_aspect_ratio = function(ratio) {
        private$aspect_ratio <- ratio
      },

      update_legend_title = function(title) {
        private$legend_title <- title
      },

      hide_legend = function() {
        private$legend_enabled <- FALSE
      },

      # Getter ===
      get_data_frame = function() {
        return(private$data_frame)
      },

      get_aes = function() {
        return(private$aes)
      },

      get_x_axis_name = function() {
        return(private$x_axis_name)
      },

      get_y_axis_name = function() {
        return(private$y_axis_name)
      },

      get_x_axis_range = function() {
        return(private$x_axis_range)
      },

      get_y_axis_range = function() {
        return(private$y_axis_range)
      },

      get_main_title = function() {
        return(private$main_title)
      },

      get_file_path = function() {
        return(private$file_path)
      },

      get_line_size = function() {
        return(private$line_size)
      },

      is_add_points = function() {
        return(private$add_points)
      },

      get_point_size = function() {
        return(private$point_size)
      },

      get_aspect_ratio = function() {
        return(private$aspect_ratio)
      },

      is_legend_enabled = function() {
        return(private$legend_enabled)
      },

      get_legend_title = function() {
        return(private$legend_title)
      }
    )
  )
