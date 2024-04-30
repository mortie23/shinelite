
#' Get SQLite database connection
#'
#' @return connection
#' @export
#'
#' @examples get_db_connection()
get_db_connection <- function() {
  config <- set_environment()
  db_path <- config$db_path
  conn <- dbConnect(SQLite(), dbname = db_path)
  return(conn)
}
