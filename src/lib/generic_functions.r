# Load packages.
require(data.table)
require(dplyr)
require(stringr)

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/files
exists_dir <- function(dir_path) {
  result <- file.exists(
    dir_path
  )

  return(result)
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/files2
create_dir <- function(dir_path) {
  if (!exists_dir(dir_path)) {
    dir.create(
      dir_path,
      recursive = TRUE
    )
  }
}

get_file_list <- function(path, file_type, is_full_path = FALSE) {
  # See:
  # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list.files
  file_list <- list.files(
    path,
    pattern = file_type,
    full.names = is_full_path
  )

  return(file_list)
}

exists_file <- function(file_path) {
  result <- file.exists(
    file_path
  )

  return(result)
}

copy_file <- function(from, to, overwrite = TRUE) {
  # See:
  # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/files
  file.copy(
    from = from,
    to = to,
    overwrite = overwrite
  )
}

read_csv_using_fread <- function(file, ignore_row_count = 1) {
  # See:
  # https://www.rdocumentation.org/packages/data.table/versions/1.14.2/topics/fread
  results <- fread(
    file = file,
    skip = ignore_row_count
  )

  return(results)
}

read_csv_with_utf_8 <- function(
  input_file_name,
  header = TRUE,
  file_encoding = "utf-8"
) {
  # See:
  # https://ja.stackoverflow.com/questions/33919/csv%E3%82%92%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%82%82%E3%81%86%E3%81%A8%E3%81%99%E3%82%8B%E3%81%A8-%E4%B8%8D%E6%AD%A3%E3%81%AA%E3%83%9E%E3%83%AB%E3%83%81%E3%83%90%E3%82%A4%E3%83%88%E6%96%87%E5%AD%97%E3%81%8C%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99-%E3%81%A8%E3%81%84%E3%81%86%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%8C%E5%87%BA%E3%82%8B
  data_object <- read.csv(
    file = input_file_name,
    header = header,
    fileEncoding = file_encoding
  )

  return(data_object)
}

write_csv <- function(
  data_object,
  file,
  row_names = FALSE,
  file_encoding = "utf-8"
) {
  write.csv(
    data_object,
    file = file,
    row.names = row_names,
    fileEncoding = file_encoding
  )
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/which
# https://www.delftstack.com/ja/howto/r/find-index-in-r/
search_for_indexes <- function(data_object, condition) {
  return(which(data_object %in% condition))
}

search_for_index_of_maximum_value <- function(data_object) {
  # See:
  # https://stat.ethz.ch/R-manual/R-patched/library/base/html/which.min.html
  # https://bioinfo-dojo.net/2017/08/31/r-which_max/
  return(which.max(data_object))
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/nrow
count_row <- function(object) {
  return(nrow(object))
}

count_column <- function(object) {
  return(ncol(object))
}

extract_columns <- function(data_object, column_names) {
  # See:
  # https://sites.google.com/site/webtextofr/operating
  extracted_data_object <- data_object[, column_names]

  return(extracted_data_object)
}

get_row_names <- function(data_object) {
  return(rownames(data_object))
}

get_column_names <- function(data_object) {
  return(colnames(data_object))
}

# See:
# https://www.rdocumentation.org/packages/stringr/versions/1.4.0/topics/str_replace
replace_string <- function(string, pattern, replacement) {
  result <- str_replace(
    string,
    pattern,
    replacement
  )

  return(result)
}

# See:
# https://dplyr.tidyverse.org/reference/mutate_all.html
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/grep
replace_all_values_using_dplyr <- function(data_frame, pattern, replacement) {
  result <- mutate_all(
    data_frame,
    ~gsub(
      .,
      pattern = pattern,
      replacement = replacement
    )
  )

  return(result)
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/apply
get_value_of_each_column <- function(values, func) {
  dir_rows <- 2

  return(apply(values, dir_rows, func))
}

free_up_memory <- function(object) {
  remove_object(object)
  use_garbage_collection_twice()
}

remove_object <- function(object) {
  rm(object)
}

# See:
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/gc
# http://www.okadajp.org/RWiki/?%E7%9F%A5%E3%81%A3%E3%81%A6%E3%81%84%E3%82%8B%E3%81%A8%E3%81%84%E3%81%A4%E3%81%8B%E5%BD%B9%E3%81%AB%E7%AB%8B%E3%81%A4%28%3F%29%E9%96%A2%E6%95%B0%E9%81%94#u52d0b4e
use_garbage_collection_twice <- function() {
  gc()
  gc()
}
