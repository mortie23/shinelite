
#' Set environment
#'
#' @return config
#' @export
#'
#' @examples set_environment()
set_environment <- function() {
  # Get the environment
  env <- Sys.getenv("env")

  # Define configurations for each environment
  dev_config <- list(
    db_path = "/u01/data/shinelite/dev",
    other_config_variable = "value"
  )

  prd_config <- list(
    db_path = "/u01/data/shinelite/prd",
    other_config_variable = "value"
  )

  # Set configuration based on environment
  if (env == "dev") {
    return(dev_config)
  } else if (env == "prd") {
    return(prd_config)
  } else {
    stop("Unknown environment specified")
  }
}
